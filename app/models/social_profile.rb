class SocialProfile < ActiveRecord::Base
  belongs_to :shop
  attr_accessible :sp_link, :sp_type

  SOCIAL_PROFILES = [["1", "facebook"], ["2", "twitter"], ["3", "linkedin"]]

  validates :sp_link, :presence => true
  validates :sp_type,	:presence => true

  validates_format_of :sp_link, :with => URI::regexp(%w(http https))
  
  validates_uniqueness_of :sp_link, :scope => [:shop_id]
  validates_uniqueness_of :sp_type, :scope => [:shop_id]
end
