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
Just one of this user objects is created, initialised with the name defined by the scenario.

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
the.unknown_class    # => raises NoObjectFound, the fabulist doesn't know the class 'unknown_class' so he believes 'unknown_class' to be a method name
```

Don't describe Cucumber Features in a vague manner. As a fabulist you can tell a story very precise with few but meaningful details. Just try to implement your story as a persona. That would be a great use case.

## Hints

Your objects lack the ability methods to say whether they have a particular feature or not? If do not want to bloat your production code with test specific implementation, you can just *wrap* your objects into something that does the job. I use this [TaggedObject](https://github.com/teamaker/Fabulist/blob/master/features/support/tagged_object.rb) in order to mark any object with arbitrary data. The tagged object then serves as a proxy for the original object.
Of cource, if you already have some objects, that encapsulate some state but lacking the necessary methods, let your proxy check the underlying state of the object.

Are your features first-person narrative? Give the [narrator](https://github.com/teamaker/Fabulist/blob/master/features/support/narrator.rb) his own representation. Then you can literally interact with the objects that occur in your story.

## Configuration
Do you use ActiveRecord and you always want updated models?
You can configure callbacks to define what happens before the fabulist memorizes an object or recalls it from his memory.

```ruby
# features/support/fabulist.rb
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
To make the convenience methods ```memorize``` and ```the(index).what_ever_you_want``` available to your cucumber world, add this line:
```ruby
# features/support/fabulist.rb
require 'fabulist/cucumber'
```

Your customer doesn't speak english?
Just teach the fabulist your language:

```ruby
# features/support/fabulist.rb
require 'fabulist'
Fabulist.teach "Deutsch" do |lang|
  lang.adress_sth       "der",  "die",  "das"
  lang.memorize_sth     "merke"
  lang.count_forwards   "1te",  "2ter",  "3tes"
  lang.count_backwards  "letzter",  "letztes",  "letzte",  "2t_letzter",  "3t_letztes",  "4t_letzte"
end
require 'fabulist/session'
World(Fabulist::Session)
```
In this way you can fit your step definition even closer to your feature description.

```ruby
# features/german.feature
Fabulist.language                         # => "Deutsch"
merke user                                # same as 'memorize' user
der(3).t_letzte_user_namens? "Peter"      # same as the(3).rd_last_user_namens
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
