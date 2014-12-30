class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :qrcodes
  has_many :tags, dependent: :destroy
  mount_uploader :file, PhotoUploader
  validate :validate_minimum_image_size, on: :create
  scope :title_search, ->(title) { where("lower(title) LIKE ?", "%#{title.downcase}%")}


  
  def edit_associated_tags(new_tags)
    new_tags.map(&:downcase)
    tags = self.tags.map(&:field)
    removed_tags = tags - new_tags
    self.tags.where(field: removed_tags).delete_all
    added_tags = new_tags - tags
    added_tags.each do |tag|
      new_tag = Tag.find_or_create_by(field: tag)
      self.tags << new_tag
    end
  end

  def self.search_by_tags(keyword)
    keyword = "##{keyword}" unless keyword[0] == "#"
    tag_ids = Tag.where(field: keyword).pluck(:photo_id)
    photos_with_title = self.uniq.title_search("#{keyword}")
    @photos = self.where(id: tag_ids) + photos_with_title
    @photos = @photos.uniq
  end



  private
  	def validate_minimum_image_size
  		if file.path
	  		image = MiniMagick::Image.open(file.path)
	  		unless image[:width] > 400
	  			errors.add :image, "should be 400px wide minimum!"
	  		end
      else
        errors.add :image, "must be uploaded"
	  	end
	  	
  	end


end
