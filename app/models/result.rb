class Result < ActiveRecord::Base
  
  # Associations
  belongs_to :game
  belongs_to :page
  
  # Custom serializable_hash for use with as_json, to_json and to_xml
  def serializable_hash(options = nil)
    super({
      only: [:id, :answer, :correct],
      include: [:page]
    }.merge(options || {}))
  end
  
  def evaluate_answer(user, answer)
    self.correct = (page.users.include?(user) == answer)
    self.answer = !!answer
    self.save
  end
  
end
