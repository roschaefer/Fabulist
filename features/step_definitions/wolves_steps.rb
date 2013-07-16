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
