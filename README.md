# Fabulist

Write declarative and vivid cucumber features by referencing shared state across multiple steps.

## Installation

Add this line to your application's Gemfile:

    gem 'fabulist', :git => 'https://github.com/teamaker/Fabulist.git'

And then run:

    $ bundle install

## Usage
In situations where you write conjunctive steps (ie. share state across several step definitions) it's usual to assign instance variables used by the following steps. When doing so, your step definitions have to know implementation details of each other, thus become inflexible and tightly coupled.

Therefore, this gem provides a simple api to memorize arbitrary ruby object and to reference them by:

1. class
2. any predicate
3. insertion order

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

```ruby
class User
  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def called(name)
    self.name == name
  end
end

```
You can keep track of your domain models with ```memorize``` and ```recall```:

```ruby
Given(/^I am a user and my name is "(.*?)"$/) do |name|
  user = User.new(name)
  memorize user
end

When(/^someone asks for (.*)$/) do |name|
  recall Object, :called, name
end
```

That's it.

```ruby
#In this particular case, other ways to call the the user would be:
recall                         # => user
recall User, :called, "John"   # => user

# only this will raise an exception
recall AnotherClass          # => raises NoObjectFound
recall User, :called, "Karl" # => raises NoObjectFound
recall User, :whatsoever     # => raises NoObjectFound, because the user doesn't respond to 'whatsoever'
```
## Hints

Your objects lack the ability methods to say whether they have a particular feature or not? If do not want to bloat your production code with test specific implementation, try to *wrap* your objects. In the [features](https://github.com/teamaker/Fabulist/tree/master/features) I use a [tagged object](https://github.com/teamaker/Fabulist/blob/master/features/support/tagged_object.rb) to mark arbitrary objects. The tagged object serves as a proxy for the original object.
If your objects encapsulate some state but lack the necessary methods, a proxy should check the underlying state of the object.

Are your features first-person narrative? Give the [narrator](https://github.com/teamaker/Fabulist/blob/master/features/support/narrator.rb) his own representation. Then you can literally interact with the objects that occur in your story.

## Configuration
To make the convenience methods ```memorize``` and ```recall``` available to your cucumber world, add this line:
```ruby
# features/support/fabulist.rb
require 'fabulist/cucumber'
```

Do you use ActiveRecord and you always want updated models?
You can configure callbacks to define what happens before you memorize an object or recall it from memory.

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
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
