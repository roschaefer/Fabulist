# Fabulist

## Installation

Add this line to your application's Gemfile:

    gem 'fabulist', :git => 'git://github.com:teamaker/Fabulist.git'

And then run:

    $ bundle install

Or install it yourself as:

    $ gem install fabulist

## Usage

Fabulist provides a simple API to retrieve objects from an array, depending on what you probably mean. Find objects by class name or any method or simply by insertion order.

Let's say, you have a class like this:

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

You can then write your step definition as follows:

```ruby
# store your object like this
user = User.new("Peter")
memorize user

# and retrieve your object in another step
the.user_called? "Peter"  # => user
```

## Configuration
You can configure callbacks to define what happens before the fabulist memorizes an object or recalls it from the memory. Let's say you use ActiveRecord:

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
You can fit your step definitions even closer to your step description, just teach the fabulist your language:

```ruby
require 'fabulist'
Fabulist.teach "Deutsch" do |lang|
  lang.adress_sth "der", "die", "das"
  lang.memorize_sth "merke"
  lang.count_forwards "1te", "2ter", "3ter"
  lang.count_backwards "letzter", "letztes", "letzte", "2t_letzter", "3t_letztes", "4t_letzte"
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
