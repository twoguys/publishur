class UserObserver < ActiveRecord::Observer
  
  def after_create(user)
    Event.create(:body => "#{user.name} (#{user.email}) signed up", :class_type => User.to_s)
  end
  
end
