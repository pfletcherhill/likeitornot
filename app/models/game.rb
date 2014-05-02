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
    user.pages_by_count(9).each{|p| self.results.create(page: p)}
  end
  
end
