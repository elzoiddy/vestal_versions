require 'spec_helper'

describe VestalVersions::Comments do
  let(:user){ User.create(:name => 'Steve Richert') }
  
  before do
    User.prepare_versioned_options(:update_comments => :optional)
  end

  it 'defaults to nil' do
    user.update_attributes(:first_name => 'Stephen')
    user.versions.last.reason_for_update.should be_nil
  end

  it 'accept and return a reason for update' do
    user.update_attributes(:first_name => 'Stephen', 
      :reason_for_update => "some reason", :updated_by => "me" )
    
    user.versions.last.reason_for_update.should == "some reason"
    user.versions.last.user_name.should == 'me'
  end
  
  it "should require a reason for update when configured" do
    User.prepare_versioned_options(:update_comments => :required)
    lambda {user.update_attributes(:first_name => 'Stephen')}.should raise_error

    user.update_attributes(:first_name => 'Stephen', 
      :reason_for_update => "some reason")

    user.versions.last.reason_for_update.should == "some reason"
  end

  it "should not record a reason for update when not configured" do
    # not configured at all
    User.prepare_versioned_options(:update_comments => nil)
    user.update_attributes(:first_name => 'Stephen', 
      :reason_for_update => "some reason")

    user.versions.last.reason_for_update.should be_nil

    # configured for :none
    User.prepare_versioned_options(:update_comments => :none)
    user.update_attributes(:first_name => 'Stephen', 
      :reason_for_update => "some reason")

    user.versions.last.reason_for_update.should be_nil
  end

  
end
