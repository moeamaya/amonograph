class Drawing < ActiveRecord::Base
  belongs_to :user

  mount_uploader :drawing, DrawingUploader
end
