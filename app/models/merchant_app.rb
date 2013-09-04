require 'doorkeeper/plain_application_generator'

class MerchantApp < ActiveRecord::Base
  include Doorkeeper::PlainApplicationGenerator

  attr_accessor :redirect_uri

  attr_accessible :name, :redirect_uri

  has_one :oauth_application, class_name: 'Doorkeeper::Application', as: :owner, dependent: :destroy

  after_create :generate_application
end