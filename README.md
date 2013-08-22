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

  def called(name)
    self.name == name
  end
end

```
And you can keep track of your domain models with ```memorize``` and ```recall```:

```ruby
Given(/^I am a user and my name is "(.*?)"$/) do |name|
  user = User.new(name)
  memorize user
end

When(/^someone asks for (.*)$/) do |name|
  recall Object, :called, name
end
```

That's it!

*Hint: In this particular case, other ways to call the the user would be:*

```ruby
recall                         # => user
recall User, :called, "John"   # => user

# only this will raise an exception
recall AnotherClass          # => raises NoObjectFound
recall User, :called, "Karl" # => raises NoObjectFound
recall User, :whatsoever     # => raises NoObjectFound, because the user doesn't respond to 'whatsoever'
```
## Hints

Your objects lack the ability methods to say whether they have a particular feature or not? If do not want to bloat your production code with test specific implementation, you can just *wrap* your objects into something that does the job. I use a [tagged object](https://github.com/teamaker/Fabulist/blob/master/features/support/tagged_object.rb) in order to mark any object with arbitrary data. The tagged object then serves as a proxy for the original object.
Of cource, if you already have some objects, that encapsulate some state but lacking the necessary methods, let your proxy check the underlying state of the object.

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
