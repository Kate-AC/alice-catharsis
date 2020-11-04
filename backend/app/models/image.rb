# frozen_string_literal: true

class Image < ApplicationRecord
  TARGET_TYPES = { all: [0, 1], normal: 0, r18: 1 }.with_indifferent_access.freeze

  enum target_type: { normal: 0, r18: 1 }

  scope :search_by_condition, lambda { |condition|
    where(target_type: TARGET_TYPES[condition[:target_type]])
      .where(deleted: false)
      .order(id: :desc)
  }

  def adjusty_json
    JSON.parse(adjusty)
  end
end
