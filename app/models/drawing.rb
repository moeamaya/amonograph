class Drawing < ActiveRecord::Base
  belongs_to :user
  validates :title, length: { minimum: 3 }
  validates :about, length: { in: 5..1000 }

  mount_uploader :drawing, DrawingUploader

  self.per_page = 5
end
