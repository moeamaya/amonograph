class Favor < ActiveRecord::Base
  belongs_to :user
  belongs_to :drawing
end
