Given(/^the lion "(.*?)" is asleep in the shadow of a tree$/) do |name|
  lion = Lion.new
  lion.is(:asleep)
  memorize TaggedObject.new(lion, :called => name, :male => true)
end

Given(/^the small mouse "(.*?)" is romping about$/) do |name|
  mouse =  Mouse.new
  mouse.is(:romping_about)
  memorize TaggedObject.new(mouse, :called => name, :female => true)
end

Given(/^the (.*) catches (.*)$/) do |name1, name2|
  the.animal_called(name1).catch(the.animal_called(name2))
end

When(/^she pleads$/) do |speech|
  the.last_female.plead(speech)
end

When(/^(.*) is laughing$/) do |name, speech|
  the.animal_called(name).talk speech
end

When(/^then (.*) just leaves her alone/) do |name|
  the.animal_called(name).release(the.last_female)
end

When(/^(.*) falls into a net trap some days later$/) do |name|
  the.animal_called(name).is(:trapped)
end

When(/^he roars desperately$/) do
  the.last_male.roar(:how => :desparately)
end

Then(/^(.*) comes to his aid$/) do |name|
  the.animal_called(name).help(the.last_male)
end

Then(/^she gnaws the ropes until (.*) is free$/) do |name|
  while the.animal_called(name).is? :trapped
    the.last_female.try_to_free(the.animal_called(name))
  end
end

Then(/^(.*) thanks (.*) and they become best friends$/) do |name1, name2|
  the.animal_called(name1).thank(the.animal_called(name2))
  the.animal_called(name1).friends << the.animal_called(name2)
  the.animal_called(name2).friends << the.animal_called(name1)
end

Then(/^sometimes strength is not all, even a small friend can be of great benefit$/) do
  true
end

