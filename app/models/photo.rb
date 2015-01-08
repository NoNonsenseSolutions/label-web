class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :qrcodes
  has_many :tags, dependent: :destroy
  mount_uploader :file, PhotoUploader
  validate :validate_minimum_image_size, on: :create
  scope :title_search, ->(title) { where("lower(title) LIKE ?", "%#{title.downcase}%")}


  #Make sure the duplicate tags are not added and removed tags are removed
  def photo_tags
    all_tags = Hash.new {|h,k| h[k]=[]}
    self.tags.find_each do |t|
      all_tags[t.field] << t.value
    end
    all_tags
  end

  def edit_associated_tags(new_tags, field)
    new_tags.map(&:downcase)
    #Loads all tags
    old_tags = self.tags.where(field: field).map(&:value)
    #find removed tags
    removed_tags = old_tags - new_tags
    self.tags.where(field: field, value: removed_tags).delete_all
    #find added tags
    added_tags = new_tags - old_tags
    added_tags.each do |t|
      new_tag = Tag.create(field: field, value: t)
      self.tags << new_tag
    end
  end

  def self.search_by_tags(keyword)
    keyword = "##{keyword}" unless keyword[0] == "#"
    tag_ids = Tag.where(value: keyword).pluck(:photo_id)
    photos_with_title = self.uniq.title_search("#{keyword}")
    @photos = self.where(id: tag_ids) + photos_with_title
    @photos = @photos.uniq
  end

  def has_liked?(user)
    !!self.likes.find_by(user: user)
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
