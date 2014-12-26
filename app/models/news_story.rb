#class StoryTracking
#  def after_validation(record)
#
#    record.published = false if record.archived? == true
#  end
#end

class NewsStory < ActiveRecord::Base
  include Bootsy::Container

  #after_validation StoryTracking.new

  belongs_to :author, :class_name => 'User'
  validates :author_id, :presence => true

  validates :title, :presence => true

  #--------------------Methods--------------------------------

  def published=(value)
    write_attribute(:archived, false) if value
    super(value)
  end

  def archived=(value)
    write_attribute(:published, false) if value
    super(value)
  end
    


  #-------------------Class Methods---------------------------

  def self.records(show_drafts: false, show_archives: false, hide_published: false)
    r = hide_published ? NewsStory.where(:published => false) : NewsStory.all
    r = r.where.not(:archived => true) unless show_archives # || (show_archives &&
    r = r.where(:published => true) unless show_drafts
    r
  end
end

