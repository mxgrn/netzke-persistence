require File.dirname(__FILE__) + '/spec_helper'

describe NetzkeComponentState do
  def set_current_user(user)
    NetzkeComponentState.init(:current_user => user)
  end
  
  def masquerade_as(hsh)
    NetzkeComponentState.init(:session => {:masquerade_as => hsh})
  end
  
  def reset_masquerade
    NetzkeComponentState.init(:session => {})
  end
  
  def set_component(component)
    NetzkeComponentState.init(:component => component)
  end
  
  it "should propagate settings down the hierarchy when masquerading" do
    role1 = Factory(:role)
    
    user1_with_role1 = Factory(:user, :role => role1)
    user2_with_role1 = Factory(:user, :role => role1)
    
    set_component("some_component")
    
    NetzkeComponentState.init(:session => {})

    # set value for first user
    set_current_user(user1_with_role1)
    NetzkeComponentState.update_state!(:some_option => 1)
    NetzkeComponentState.state.should == {:some_option => 1}
    
    # set value for second user
    set_current_user(user2_with_role1)
    NetzkeComponentState.update_state!(:some_option => 2)
    NetzkeComponentState.state.should == {:some_option => 2}
    
    # masquerade as those user's role, and change the value
    masquerade_as(:role_id => role1.id)
    NetzkeComponentState.update_state!(:some_option => 3)
    
    reset_masquerade

    # switch the users and check the values
    set_current_user(user1_with_role1)
    NetzkeComponentState.state.should == {:some_option => 3}
    
    set_current_user(user2_with_role1)
    NetzkeComponentState.state.should == {:some_option => 3}
    
    # Masquerade as world and override the values again
    masquerade_as(:world => true)
    NetzkeComponentState.update_state!(:some_option => 4)
    
    reset_masquerade
    
    # switch the users and check the values
    set_current_user(user1_with_role1)
    NetzkeComponentState.state.should == {:some_option => 4}
    
    set_current_user(user2_with_role1)
    NetzkeComponentState.state.should == {:some_option => 4}
    
  end
  
  it "should be possible to delete keys-value pairs by setting the value to nil" do
    NetzkeComponentState.state.should be_nil
    NetzkeComponentState.update_state!(:some_option => 1)
    NetzkeComponentState.state.should == {:some_option => 1}
    NetzkeComponentState.update_state!(:some_option => nil)
    NetzkeComponentState.state.should == {}
  end
end