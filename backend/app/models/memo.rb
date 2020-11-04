# frozen_string_literal: true

class Memo < ApplicationRecord
  belongs_to :tag

  def formatted_date
    published_at.strftime("%Y年%m月%d日")
  end

  scope :get_list, lambda {
    where(deleted: false)
      .order(id: "DESC")
      .limit(10)
      .map do |item|
      {
        id: item.id,
        title: item.title,
        published_date: item.formatted_date,
        tag_id: item.tag_id,
        tag_name: item.tag.name,
        tag_color: item.tag.color
      }
    end
  }

  scope :get_list_by_tag_id, lambda { |tag_id|
    where(tag_id: tag_id).get_list
  }
end
