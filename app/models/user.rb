class User < ActiveRecord::Base
  
  # Callbacks
  after_save :populate_pages
  
  # Associations
  has_and_belongs_to_many :pages, -> { uniq }
  has_many :games, dependent: :destroy
  has_many :results, through: :games
  
  # Methods
  def graph(token = self.oauth_token)
    @graph ||= Koala::Facebook::API.new(token)
  end
  
  def friends
    graph.get_connections("me", "friends")
  end
  
  def likes
    graph.get_connections("me", "likes")
  end
  
  def interests
    graph.get_connections("me", "interests")
  end
  
  def fb_object
    graph.get_object("me")
  end
  
  def avatar
    graph.get_picture("me", {type: "square"})
  end
  
  def pages_by_count(count = 9)
    self.pages.shuffle.first(count)
  end
  
  def populate_pages
    pages.clear # Flush pages
    likes.each do |like|
      params = {uid: like["id"], category: like["category"], name: like["name"], url: like["url"]}
      page = Page.find_or_create_by(params)
      pages << page
    end
  end
  
  def evaluate_answers(answers = [])
    results = []
    answers.each do |page_id, ans|
      page = Page.find_by(uid: page_id)
      page.result = page.evaluate_answer(self, ans) # Pass current user and t/f answer
      results << page
    end
    return results
  end
  
  def stats
    return {
      correct_answers: results.map{|r| r.correct}.count(true),
      total_answers: results.count,
      likes: pages.count,
      results: games.map{|g| [g.updated_at, g.results.where(correct: true).count]}
    }
  end
  
  # Custom serializable_hash for use with as_json, to_json and to_xml
  def serializable_hash(options = nil)
    super({
      only: [:uid, :name, :email],
      methods: [:avatar]
    }.merge(options || {}))
  end
  
  # Class Methods
  def self.from_omniauth(auth)
    where(uid: auth.uid).first_or_initialize.tap do |user|
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      return user if user.save
      return nil
    end
  end
  
  def self.stats
    return {
      correct_answers: Result.pluck(:correct).count(true),
      total_answers: Result.count,
      likes: User.all.map{|u| u.pages.count}.sum / User.count,
      results: Game.last(100).map{|g| [g.updated_at, g.results.where(correct: true).count]}
    }
  end
    
end
