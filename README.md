# Fabulist

Write declarative and vivid cucumber features by referencing shared state across multiple steps.

## Installation

Add this line to your application's Gemfile:

    gem 'fabulist', :git => 'https://github.com/teamaker/Fabulist.git'

And then run:

    $ bundle install

## Usage

In situations where you write conjunctive steps (ie. share state across several step definitions), it's usual to assign instance variables and work with them in another step.
When doing so, your step definitions have to know these instance variables and thus are inflexible and tightly coupled. The idea of the fabulist is to reference your objects via certain details that emerge from your cucumber scenario.

Therefore, this gem provides a simple api to memorize arbitrary ruby object and to reference them either by class, by a method that returns true or false or just by insertion order.

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

In this case, there would be a plenty of other ways to summon the user:

```ruby
the(1).st                       # => user
the.last                        # => user
the.called?           "John"    # => user
the.user_called?      "John"    # => user
the.last_user_called? "John"    # => user

# only this will raise an exception
the(2).nd_last  # => raise NoObjectFound, because there is only one object in the memory
```

Cucumber Features should not be described in a vague manner. As a fabulist, you can tell your story very precise with less but meaningful details.

Think about personas. Wouldn't that be nice?

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

Do your customer speaks another language than english?
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
