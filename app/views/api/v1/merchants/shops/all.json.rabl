object @shop => :data
attributes :name, :uuid, :identifier, :description, :stype, :website, :time_zone, :created_at

node :errors do |shop|
  shop.error_messages
end
