require 'nokogiri'
require 'messagecenter/templates/markup_generator'
require 'messagecenter/templates/existing_template'
require 'messagecenter/templates/blank_template'
require 'messagecenter/templates/system_template_personalizer'
require 'messagecenter/templates/structure_creator'

class Template < ActiveRecord::Base
  include Messagecenter::Templates::SystemTemplatePersonalizer
  include Messagecenter::Templates::StructureCreator
  include ShopLogo
  include Rails.application.routes.url_helpers

  attr_accessor :parsed_html, :parsed_result, :pared_extends, :styles

  attr_accessible :shop_id, :system_generated, :name, :structure, :html

  serialize :structure, Hash

  has_many :messages, dependent: :destroy
  has_many :stylesheets
  has_one :template_upload
  belongs_to :shop

  after_create :create_structure
  after_save :generate_thumbnail

  scope :fetch_system_generated, where(system_generated: true)

  scope :for_shop, ->(shop_identifier) { where(shop_id: shop_identifier) }

  scope :for_name, ->(template_name) { where(name: template_name) }

  PLACE_HOLDER_ELEM = "<placeholder></placeholder>\n"
  mount_uploader :thumbnail, TemplateThumbnailUploader

  def self.system_generated
    fetch_system_generated
  end

  def self.basic
    for_name("Basic").first
  end

  def self.copy(template_id, shop)
    existing_template = Template.find(template_id)
    new_template = Template.new(html: existing_template.html, name: "#{shop.name} #{existing_template.name}", shop_id: shop.id)
    new_template.personalize
    new_template.save
    new_template.id
  end

  def self.sanitize_custom_tags(content, message, receiver)
    # Sanitaize the footer
    template_node = Nokogiri::XML(template_div_content)
    template_node.css('.optyn-footer').each do |footer_node|

      #substitute the receiver email
      footer_node.css('receiver-email').each do |receiver_email_node|
        receiver_email_node.swap(receiver.email)
      end

      #substitute the unsubscribe link
      footer_node.css('unsubscribe').each do |unsubscribe_node|
        unsubscribe_node.swap(%{<a href="#{SiteConfig.app_base_url}#{removal_confirmation_connection_path(Encryptor.encrypt(receiver.email, message.uuid))}?tracker=#{receiver.uuid}">Unsubscribe</a>})
      end
    end

    template_node.to_s
  end

  def fetch_editable_content(message_content)
    content = ""

    content = Messagecenter::Templates::MarkupGenerator.generate_editable_content(message_content, self)

    content
  end

  def fetch_content(message_content)
    content = ""

    html = Messagecenter::Templates::MarkupGenerator.generate_content(message_content, self)
    content = InlineStyle.process(html)

    content
  end

  def fetch_cached_content(message, force=false)
    Rails.cache.fetch("template_message_#{message.uuid}", force: false, expires_in: SiteConfig.ttls.email_footer) do
      fetch_content(message.content)
    end
  end

  def generate_thumbnail
    if self.html_changed? && self.reload
      self.remove_thumbnail! if !self.thumbnail.to_s.blank?
      file = html_to_thumbnail
      self.thumbnail = file
      self.save
      file.unlink
    end
  end

  def html_to_thumbnail
    file = Tempfile.new(["template_#{self.id.to_s}", 'jpg'], 'tmp', :encoding => 'ascii-8bit')
    file.write(IMGKit.new(self.html, quality: 50).to_jpg)
    file.flush
    file
  end
end
