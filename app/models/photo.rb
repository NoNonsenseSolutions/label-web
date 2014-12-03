class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :likes
  has_many :qrcodes
  has_many :tags
  mount_uploader :file, PhotoUploader
  validate :validate_minimum_image_size


  private
  	def validate_minimum_image_size
  		if file.path
	  		image = MiniMagick::Image.open(file.path)
	  		unless image[:width] > 400 && image[:height] > 400
	  			errors.add :image, "should be 400x400px minimum!"
	  		end
      else
        errors.add :image, "must be uploaded"
	  	end
	  	
  	end
end
