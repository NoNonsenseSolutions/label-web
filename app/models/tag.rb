class Tag < ActiveRecord::Base
  has_many :photo_tags
  belongs_to :photo
  before_save :normalize
  scope :by_brand, -> { where(field: "brand") }
  scope :by_category, -> { where(field: "category") }
  scope :by_color, -> { where(field: "color") }
  scope :by_pattern, -> { where(field: "pattern") }
  scope :by_occasion, -> { where(field: "occasion") }
  scope :hash_tags, -> { where("field LIKE ?", "#%") }
  scope :color_tags, -> { where.not("field LIKE ?", "#%")}

  private
  	def normalize
  		self.field = self.field.downcase
  	end
end
