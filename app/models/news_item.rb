class NewsItem < ActiveRecord::Base

  validates_presence_of :title, :content

  has_friendly_id :title, :use_slug => true, :strip_diacritics => true
  
  acts_as_indexed :fields => [:title, :body], :index_file => [RAILS_ROOT,"tmp","index"]
  
  def self.latest(amount = 10)
    find(:all, :order => "publish_date DESC", :limit => amount,
               :conditions => ["publish_date < ?", Time.now])
  end

  def not_published? # has the published date not yet arrived?
    publish_date > Time.now
  end
  
  def content
    self.body
  end
  
  def content=(value)
    self.body = value
  end

end