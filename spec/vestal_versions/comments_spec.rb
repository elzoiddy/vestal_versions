require 'spec_helper'

describe VestalVersions::Comments do
  let(:user){ User.create(:name => 'Steve Richert') }

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
end
