require 'rails_helper'

RSpec.describe NewsStory, :type => :model do
  let(:story){ build :news_story }

  describe 'Db' do
    it{ should have_db_column(:published).with_options(:default => false) }
    it{ should have_db_column(:archived).with_options(:default => false) }
  end

  describe 'Validations' do
    it{ should validate_presence_of :title }
    it{ should validate_presence_of :author_id }
  end

  describe 'Associations' do
    it{ should belong_to(:author).class_name('User') }
  end

  describe 'Idioms' do
    specify 'If a record is saved with archived => true, published will be set to false' do
      story.published = true
      story.archived = true
      story.published.should == false
    end

    specify 'If a record is saved with published => true, archived will be set to false' do
      story.archived = true
      story.published = true
      story.archived.should == false
    end
  end

  describe 'Class Methods' do
    let!(:pub){ create :published }
    let!(:draft){ create :draft }
    let!(:archive){ create :archive }


    describe '#records(show_drafts: false, show_archives: false, :hide_published => false)' do
      it 'should return no records if :hide_published => false' do
        NewsStory.records(:hide_published => true).count == 0
      end

      it 'should return only what is requested (drafts or archives) if :hide_published => false' do
        #@x = NewsStory.records(:hide_published => true, :show_drafts => true)
        NewsStory.records(:hide_published => true, :show_drafts => true).count.should == 1
        NewsStory.records(:hide_published => true, :show_archives => true).count.should == 1
        NewsStory.records(:hide_published => true, :show_archives => true, :show_drafts => true).count.should == 2
      end

      it 'should return only published and no archived records if no parameter is sent' do
        NewsStory.records.count.should == 1
        NewsStory.records.first.should == pub
      end
      
      it 'should return both published and drafts if show_drafts is true' do
        NewsStory.records(:show_drafts => true).count.should == 2
        NewsStory.records(:show_drafts => true).last.should == draft
      end

      it 'should return published and archived records if show_archives is true' do
        NewsStory.records(:show_archives => true).count.should == 2
        NewsStory.records(:show_archives => true).last.should == archive
      end
      
      it 'should return all records if show_drafts and show_archives is set to true' do
        NewsStory.records(:show_drafts => true, :show_archives => true).count.should == 3
      end
    end
  end
end
