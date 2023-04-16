# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user
  include Authorship

  validates :title, presence: true, length: { minimum: 3 }
  validates :body, presence: true, length: { minimum: 3 }
end
