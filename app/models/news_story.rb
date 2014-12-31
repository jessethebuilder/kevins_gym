#class StoryTracking
#  def after_validation(record)
#
#    record.published = false if record.archived? == true
#  end
#end

class NewsStory < ActiveRecord::Base
  include Bootsy::Container

  mount_uploader :main_image, MainImageUploader
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
    if hide_published
      r = empty_query
    else
      r = where(:published => true)
    end

    r = r + drafts if show_drafts
    r = r + archives if show_archives
    r
  end

  def self.empty_query
    where('published = true AND archived = true')
  end

  def self.published
    where(:published => true)
  end

  def self.drafts
    where('published = false AND archived = false')
  end

  def self.archives
    where(:archived => true)
  end
end

