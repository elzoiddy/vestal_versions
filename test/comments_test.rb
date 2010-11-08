require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class UsersTest < Test::Unit::TestCase
  context 'The reason for change for an update' do
    setup do
      @user = User.create(:name => 'Steve Richert')
    end

    should 'default to nil' do
      @user.update_attributes(:first_name => 'Stephen')
      assert_nil @user.versions.last.reason_for_update
    end

    should 'accept and return a reason for update' do
      @user.update_attributes(:first_name => 'Stephen', :reason_for_update => "some reason")
      assert_equal "some reason", @user.versions.last.reason_for_update
    end
  end
end
