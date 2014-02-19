class Drawing < ActiveRecord::Base
  belongs_to :user
  validates :title, length: { minimum: 3 }
  validates :about, length: { in: 5..1000 }

  mount_uploader :drawing, DrawingUploader

  self.per_page = 5

  is_impressionable :counter_cache => true, :column_name => :views, :unique => :request_hash

  def self.prev(id)
    Drawing.order("created_at DESC").where("drawings.id < ?", id).first
  end
end
