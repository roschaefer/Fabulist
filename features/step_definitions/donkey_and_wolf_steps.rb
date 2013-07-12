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
  the.last.talk speech
end

When(/^the wolf answers:$/) do |speech|
  the.last_wolf.talk speech
end

When(/^he continues:$/) do |speech|
  the.last.talk speech
end

When(/^he tears apart the miserable animal$/) do
  the.last.tear_apart the.animal_miserable
end

Then(/^the donkey should have no pain$/) do
  the.donkey.should have_no_pain
end

Then(/^no pitiful animal exists$/) do
  expect { the.pitiful }.to raise_exception
end

Then(/^now the donkey is not alive anymore$/) do
  the.donkey.should_not be_alive
end
