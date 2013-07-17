# Fabulist

Enough of instance variables in your cucumber step definitions? Then maybe this will fit to your needs.

## Installation

Add this line to your application's Gemfile:

    gem 'fabulist', :git => 'https://github.com/teamaker/Fabulist.git'

And then run:

    $ bundle install

## Usage

Fabulist provides a simple API to retrieve objects from an array, depending on your probable intent. Find objects by class, a method or by insertion order.

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


```ruby
# store your object like this
user = User.new("Peter")
memorize user

# and retrieve your object in another step
the.user_called? "Peter"  # => user
```

## Notes
It is a good idea to represent your narrator as a variable to access it from everywhere in your cucumber step definitions.
You can see an example [here](https://github.com/teamaker/Fabulist/blob/master/features/support/narrator.rb).

If your objects lack the necessary methods to identify them, and you don't want to bloat your production code with test specific implementation, you can *wrap* your objects into a proxy.
Here you can see a [TaggedObject](https://github.com/teamaker/Fabulist/blob/master/features/support/tagged_object.rb) class, that tags another object with arbitrary attributes. But it's even better, if your wrapper accesses the underlying state of the object, rather than virtual attributes.

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
