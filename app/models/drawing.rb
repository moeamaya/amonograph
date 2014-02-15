class Drawing < ActiveRecord::Base
  belongs_to :user
  validates :title, length: { minimum: 3 }
  validates :about, length: { in: 5..1000 }

  mount_uploader :drawing, DrawingUploader

  self.per_page = 5

  is_impressionable :counter_cache => true, :column_name => :views, :unique => :request_hash

  # Searches the next 5 id values for given input
  # id expects an interger value
  def self.next(id)
    ids= []
    5.times {
      id += 1
      ids << id
    }
    try = Drawing.order(:id).find_by_id(ids)
    if try.nil?
      return Drawing.first
    else
      return try
    end
  end
end
