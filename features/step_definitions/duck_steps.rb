Given(/^there is a rich duck called "Dagobert"$/) do
  dagobert = Duck.new
  proxy = Proxy.new(dagobert, :called => "Dagobert", :that_is => :rich)
  memorize proxy
end

Given(/^he has three grandchildren called "(.*?)" "(.*?)" and "(.*?)"$/) do |name1, name2, name3|
  tic, tric, trac = Duck.new, Duck.new, Duck.new
  the.last_duck.grandchildren << tic << tric << trac
  proxy1 = Proxy.new(tic,  :called => name1)
  proxy2 = Proxy.new(tric, :called => name2)
  proxy3 = Proxy.new(trac, :called => name3)
  memorize proxy1
  memorize proxy2
  memorize proxy3
end

When(/^the rich duck calls "(.*?)"$/) do |name|
  the.duck_that_is(:rich).call the.duck_called(name)
end

Then(/^(.*?) appears$/) do |name|
  the.duck_called(name).appear
end

Then(/^(.*?) is his grandchild$/) do |name|
  the.duck_called(name).should be_grandchild_of(the(1).st_duck)
end
