# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  include Authorship

  validates :body, presence: true, length: { minimum: 3 }
end
