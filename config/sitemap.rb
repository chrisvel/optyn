require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://www.optyn.com'
SitemapGenerator::Sitemap.create do
  
  if Rails.env.production?
    
    add '/', :changefreq => 'daily', :priority => 0.9  
    add '/consumer-features', :changefreq => 'weekly', :priority => 0.8 
    add '/merchant-features', :changefreq => 'weekly', :priority => 0.8 
    add '/pricing', :changefreq => 'weekly', :priority => 0.8 
    add '/faq', :changefreq => 'weekly', :priority => 0.8 
    add '/about', :changefreq => 'weekly', :priority => 0.8
    add '/contact', :changefreq => 'weekly', :priority => 0.8
    add '/terms', :changefreq => 'weekly', :priority => 0.8
    add '/privacy', :changefreq => 'weekly', :priority => 0.8

    Shop.real.each do |shop|
      add "public/shop/#{shop.identifier}", :changefreq => 'weekly', :priority => 0.8
    end

    SitemapGenerator::Sitemap.default_host = 'https://www.optyn.com'
    Message.made_public.each do |message|
      add("/#{shop.name.parameterize}/campaigns/#{message.name.parameterize}-#{message.uuid}", :changefreq => 'weekly', :priority => 0.8)
    end 
  end
end

if Rails.env.production?
  SitemapGenerator::Sitemap.ping_search_engines # called for you when you use the rake task
end  