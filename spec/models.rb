require 'active_record'

ActiveRecord::Base.establish_connection(:adapter => :nulldb)
orig_stdout = $stdout
$stdout = File.new('/dev/null', 'w')
ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :username
    t.string :email
  end
end
$stdout = orig_stdout

require File.join(File.dirname(__FILE__), 'models', 'user')
