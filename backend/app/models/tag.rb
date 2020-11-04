# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :memos, foreign_key: "tag_id"
end
