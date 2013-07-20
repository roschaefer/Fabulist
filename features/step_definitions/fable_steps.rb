####################################
####### Lion and the mouse #########
####################################

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


####################################
####### Donkey and the Wolf ########
####################################

Given(/^there is the donkey and a wolf$/) do
  memorize Donkey.new
  memorize Wolf.new
end

Given(/^the donkey has a splinter in his foot$/) do
  the.donkey.splinter = true
end

When(/^the miserable animal meets the wolf$/) do
  the.animal_miserable.meets the.wolf
end

When(/^he whines:$/) do |speech|
  the.last_animal.talk speech
end

When(/^the wolf answers:$/) do |speech|
  the.last_wolf.talk speech
end

When(/^he continues:$/) do |speech|
  the.last_animal.talk speech
end

When(/^he tears apart the miserable animal$/) do
  the.last_animal.tear_apart the.animal_miserable
end

Then(/^the donkey should have no pain$/) do
  the.donkey.should_not have_pain
end

Then(/^no pitiful animal exists$/) do
  expect { the.pitiful }.to raise_exception
end

Then(/^now the donkey is not alive anymore$/) do
  the.donkey.should_not be_alive
end



####################################
###### Silly and Smart Wolves ######
####################################

Given(/^there is (\d+) smart wolf and (\d+) silly wolves$/) do |number_smart, number_silly|
  number_smart.to_i.times do
    memorize TaggedObject.new(Wolf.new, :that_is => :smart)
  end
  silly_wolves = []
  number_silly.to_i.times do
    wolf = Wolf.new
    memorize wolf
    silly_wolves << wolf
  end
  memorize TaggedObject.new(silly_wolves, :silly_wolves => true)
end

Given(/^they have stolen (\d+) sheeps$/) do |number_sheeps|
  sheeps = []
  number_sheeps.to_i.times do
    sheeps << Animal.new
  end
  memorize TaggedObject.new(sheeps, :stolen => true, :sheeps => true)
end

When(/^the smart wolf suggest to equitably share the loot$/) do
  the.wolf_that_is(:smart).talk "Let us share the loot equitably"
end

When(/^the others ask how to do that$/) do
  the.silly_wolves.each do |wolf|
    wolf.talk "How to do that?"
  end
end

When(/^the smart suggests to divide by (\d+)$/) do |number|
  the.wolf_that_is(:smart).talk "Let us divide by #{number}"
end

When(/^he adds (\d+) wolves to one sheep$/) do |number_wolves|
  result = the.silly_wolves.first(number_wolves.to_i).push(the.sheeps.first)
  memorize TaggedObject.new(result, :result => true)
end

When(/^he adds himself to (\d+) sheeps$/) do |number_sheeps|
  result = the.sheeps.last(number_sheeps.to_i).push(the.wolf_that_is(:smart))
  memorize TaggedObject.new(result, :result => true)
end

Then(/^both results are equal to (\d+)$/) do |number|
  expect(the(1).st_result.count).to eq number.to_i
  expect(the(2).nd_result.count).to eq number.to_i
end

Then(/^he asks: "(.*?)"$/) do |question|
  the(1).st.talk question
end

Then(/^he other silly wolves answer "(.*?)"$/) do |answer|
  the.last_silly_wolves.each do |wolf|
    wolf.talk "That's right, exactly"
  end
end
