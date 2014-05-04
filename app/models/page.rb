class Page < ActiveRecord::Base
  
  # Attributes
  attr_accessor :result
  
  # Callbacks
  before_validation :set_picture
  before_validation :set_url
  
  # Associations
  has_and_belongs_to_many :users, -> { uniq }
  has_many :results
  has_many :games, through: :results
  
  def graph
    @graph ||= Koala::Facebook::API.new
  end
  
  def fb_object
    graph.get_object(self.uid)
  end
  
  def set_url
    self.url ||= fb_object["link"]
  end
  
  # Methods
  def set_picture(force = false)
    if force
      self.picture = graph.get_picture(self.uid, {type: "large"})
    else
      self.picture ||= graph.get_picture(self.uid, {type: "large"})
    end
  end
  
  def evaluate_answer(user, answer)
    self.users.include?(user) == answer
  end
  
  # Custom serializable_hash for use with as_json, to_json and to_xml
  def serializable_hash(options = nil)
    super({
      only: [:uid, :name, :picture, :url],
      methods: []
    }.merge(options || {}))
  end
  
end
