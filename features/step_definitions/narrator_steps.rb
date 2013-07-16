Given(/^I am tired$/) do
  i_am Person.new
  i.am_tired
end

Given(/^we have a coffe machine in the hall$/) do
  memorize CoffeeMachine.new
end

Given(/^it has (\d+) coffee left$/) do |number_coffees|
  the.coffee_machine.has_left(number_coffees.to_i)
end

When(/^I insert (\d+)\$ into the machine$/) do |amount|
  i.interact(:action => :insert, :params => amount.to_i, :with => the.coffee_machine)
end

When(/^I press its coffee button$/) do
  i.interact(:action => :push, :with => the.coffee_machine.button)
end

Then(/^it will serve me a coffe$/) do
  the.coffee_machine.should have_served_a_coffee(:to => me)
end

Then(/^it has no coffees left$/) do
  the.coffee_machine.should_not have_coffees_left
end
