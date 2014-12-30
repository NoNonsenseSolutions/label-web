class Tag < ActiveRecord::Base
  has_many :photo_tags
  belongs_to :photo
  before_save :normalize
  scope :hash_tags, -> { where("field LIKE ?", "#%") }
  scope :color_tags, -> { where.not("field LIKE ?", "#%")}

  private
  	def normalize
  		self.field = self.field.downcase
  	end
end
