class Game < ActiveRecord::Base
  
  # Callbacks
  before_validation :generate_uid, on: :create
  after_create :populate_pages
  
  # Associations
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :pages, through: :results
  
  # Custom serializable_hash for use with as_json, to_json and to_xml
  def serializable_hash(options = nil)
    super({
      only: [:uid, :done],
      include: [:results]
    }.merge(options || {}))
  end
  
  private
  
  def generate_uid
    begin
      self.uid = SecureRandom.hex
    end while Game.exists?(uid: self.uid)
  end
  
  # TODO
  def populate_pages
    user_count = rand(0..9)
    user_pages = user.pages_by_count(user_count)
    pages = Page.where("id NOT IN (?)", [51, 26]).order("RANDOM()").limit(9 - user_count)
    (user_pages + pages).each do |page|
      self.results.create(page: page)
    end
  end
  
end
