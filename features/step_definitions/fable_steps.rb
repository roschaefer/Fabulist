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
  recall(Animal, :called, name1).catch(recall Animal, :called, name2)
end

When(/^she pleads$/) do |speech|
  recall(Object, :female).plead(speech)
end

When(/^(.*) is laughing$/) do |name, speech|
  recall(Animal, :called, name).talk speech
end

When(/^then (.*) just leaves her alone/) do |name|
  recall(Animal, :called, name).release(recall Object, :female)
end

When(/^(.*) falls into a net trap some days later$/) do |name|
  recall(Animal, :called, name).is(:trapped)
end

When(/^he roars desperately$/) do
  recall(Object, :male).roar(:how => :desparately)
end

Then(/^(.*) comes to his aid$/) do |name|
  recall(Animal, :called, name).help(recall Object, :male)
end

Then(/^she gnaws the ropes until (.*) is free$/) do |name|
  while recall(Animal, :called, name).is? :trapped
    recall(Object, :female).try_to_free(recall(Animal, :called, name))
  end
end

Then(/^(.*) thanks (.*) and they become best friends$/) do |name1, name2|
  recall(Animal, :called, name1).thank(recall(Animal, :called, name2))
  recall(Animal, :called, name1).friends << recall(Animal, :called, name2)
  recall(Animal, :called, name2).friends << recall(Animal, :called, name1)
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
  recall(Donkey).splinter = true
end

When(/^the miserable animal meets the wolf$/) do
  recall(Animal, :miserable).meets recall(Wolf)
end

When(/^he whines:$/) do |speech|
  recall(Animal).talk speech
end

When(/^the wolf answers:$/) do |speech|
  recall(Wolf).talk speech
end

When(/^he continues:$/) do |speech|
  recall(Animal).talk speech
end

When(/^he tears apart the miserable animal$/) do
  recall(Wolf).tear_apart recall(Animal, :miserable)
end

Then(/^the donkey should have no pain$/) do
  recall(Donkey).should_not have_pain
end

Then(/^no pitiful animal exists$/) do
  expect { recall(Object, :pitiful) }.to raise_exception
end

Then(/^now the donkey is not alive anymore$/) do
  recall(Donkey).should_not be_alive
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
  recall(Wolf, :that_is, :smart).talk "Let us share the loot equitably"
end

When(/^the others ask how to do that$/) do
  recall(Object, :silly_wolves).each do |wolf|
    wolf.talk "How to do that?"
  end
end

When(/^the smart suggests to divide by (\d+)$/) do |number|
  recall(Wolf, :that_is, :smart).talk "Let us divide by #{number}"
end

When(/^he adds (\d+) wolves to one sheep$/) do |number_wolves|
  result = recall(Object, :silly_wolves).first(number_wolves.to_i).push(recall(Object, :sheeps).first)
  memorize TaggedObject.new(result, :result => :first)
end

When(/^he adds himself to (\d+) sheeps$/) do |number_sheeps|
  result = recall(Object, :sheeps).last(number_sheeps.to_i).push(recall(Wolf, :that_is, :smart))
  memorize TaggedObject.new(result, :result => :second)
end

Then(/^both results are equal to (\d+)$/) do |number|
  expect(recall(Object, :result, :first).count).to eq number.to_i
  expect(recall(Object, :result, :second).count).to eq number.to_i
end

Then(/^he asks: "(.*?)"$/) do |question|
  recall(Wolf).talk question
end

Then(/^he other silly wolves answer "(.*?)"$/) do |answer|
  recall(Object, :silly_wolves).each do |wolf|
    wolf.talk "That's right, exactly"
  end
end
