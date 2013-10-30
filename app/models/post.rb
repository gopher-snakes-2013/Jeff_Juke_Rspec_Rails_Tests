class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title, :slugelize

  validates_presence_of :title, :content

  private

  def titleize_title
    self.title = title.titleize
  end

  def slugelize
    symbol_regex = /[^\w-]/
    self.slug = self.title.downcase.gsub(/\s/, "-").gsub(symbol_regex, '')
  end
end