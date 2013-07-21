Given(/^I am a user and my name is "(.*?)"$/) do |name|
  user =  User.new(name)
  i_am user
  memorize user
end

When(/^someone asks for (.*)$/) do |name|
  # this is the only step where I use instance variables
  # to ensure that both objects are definitely the same
  @object = the.object_called? name
end

Then(/^I will respond$/) do
  @object.should be me
end
