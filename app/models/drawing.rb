class Drawing < ActiveRecord::Base
  belongs_to :user

  mount_uploader :drawing, DrawingUploader

  self.per_page = 4
end
