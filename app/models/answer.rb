class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true

  def formatted_created_at
    created_at.strftime('%Y-%m-%d %H:%M')
 end
end
