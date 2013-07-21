# Fabulist

Write declarative and vivid cucumber features by referencing shared state across multiple steps.

## Installation

Add this line to your application's Gemfile:

    gem 'fabulist', :git => 'https://github.com/teamaker/Fabulist.git'

And then run:

    $ bundle install

## Usage
In situations where you write conjunctive steps (ie. share state across several step definitions) it's usual to assign instance variables used by the following steps. When doing so, your step definitions have to know implementation details of each other, thus become inflexible and tightly coupled. In contrast, the fabulist references shared state according to the given input data of the cucumber scenario.

Therefore, this gem provides a simple api to memorize arbitrary ruby object and to reference them by:

* their class
* any method that returns true or false
* the order they were memorized

Let's have a look at this sample scenario:

```cucumber
Feature: Reference shared objects between multiple step definitions
As a developer
I want to show this minmal working example
In order to demonstrate the main pupose of this gem

Scenario: Call by a name
  Given I am a user and my name is "John"
  When someone asks for John
  Then I will respond
```
Just one of this User objects is created, initialised with the name defined by the scenario.

```ruby
class User
  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def called?(name)
    self.name == name
  end
end

```
And then you can reference your memorized objects with a call that is very close to the actual statement in the cucumber step.

```ruby
Given(/^I am a user and my name is "(.*?)"$/) do |name|
  user = User.new(name)
  memorize user
end

When(/^someone asks for (.*)$/) do |name|
  the.object_called? name # => user
end
```

And basically, that's it!

In this particular case, there would be a plenty of equivalent ways to summon the user:

```ruby
the(1).st                       # => user
the.last                        # => user
the.called?           "John"    # => user
the.user_called?      "John"    # => user
the.last_user_called? "John"    # => user

# only this will raise an exception
the(2).nd            # => raises NoObjectFound, because there is only one object in the memory
the.user_whatsoever  # => raises NoObjectFound, because the user doesn't respond to 'whatsoever'
the.unknown_class    # => raises NoObjectFound, no class 'unknown_class', here the fabulist would interpret it as a method name
```

Cucumber Features should not be described in a vague manner. As a fabulist you can tell a story especially precise with little but meaningful details. Cucumber features written like personas would be a nice use case.

## Notes

If your objects lack the necessary methods to identify them, and you don't want to bloat your production code with test specific implementation, you can just *wrap* your objects into something, that does the job. To mark objects with arbitrary attributes, I use a [TaggedObject](https://github.com/teamaker/Fabulist/blob/master/features/support/tagged_object.rb), for the integration tests of this gem. But it's even better, if your wrapper accesses the underlying state of the object, rather than virtual attributes.

Another idea: Represent the narrator as a variable to access him, see an example [here](https://github.com/teamaker/Fabulist/blob/master/features/support/narrator.rb). You can then literally interact with the things you are talking about in the story.

## Configuration
Do you use ActiveRecord and you always want updated models?
You can configure callbacks to define what happens before the fabulist memorizes an object or recalls it from the memory.

```ruby
require 'fabulist'
Fabulist.configure do |config|
  config.before_memorize do |object|
    object.save!
  end
  config.after_recall  do |object|
    object.reload
  end
end

```
To make the convenience methods 'memorize' and 'the(index).what_ever_you_want' available to your cucumber world, add this line to a file in your ```features/support``` directory:
```
require 'fabulist/cucumber'
```

Your customer doesn't speak english?
You can fit your step definitions even closer to your feature description, just teach the fabulist your language:

```ruby
require 'fabulist'
Fabulist.teach "Deutsch" do |lang|
  lang.adress_sth       "der",  "die",  "das"
  lang.memorize_sth     "merke"
  lang.count_forwards   "1te",  "2ter",  "3tes"
  lang.count_backwards  "letzter",  "letztes",  "letzte",  "2t_letzter",  "3t_letztes",  "4t_letzte"
end
require 'fabulist/session'
World(Fabulist::Session)

###
Fabulist.language # => "Deutsch"
# You will then have access to your objects like this:
merke user
der(3).t_letzte_user_namens? "Peter"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
