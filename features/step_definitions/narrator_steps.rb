Given(/^I am tired$/) do
  i_am Person.new
  i.am_tired
end

Given(/^we have a coffee machine in the hall$/) do
  memorize CoffeeMachine.new
end

Given(/^it has (\d+) coffee left$/) do |number_coffees|
  recall(CoffeeMachine).has_left(number_coffees.to_i)
end

When(/^I insert (\d+)\$ into the machine$/) do |amount|
  i.interact(:action => :insert, :params => amount.to_i, :with => recall(CoffeeMachine))
end

When(/^I press its coffee button$/) do
  i.interact(:action => :push, :with => recall(CoffeeMachine).button)
end

Then(/^it will serve me a coffe$/) do
  recall(CoffeeMachine).should have_served_a_coffee(:to => me)
end

Then(/^it has no coffees left$/) do
  recall(CoffeeMachine).should_not have_coffees_left
end
