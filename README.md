# DelegateWhenNil

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'delegate_when_nil'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install delegate_when_nil

## Usage

First of all require the gem

   require 'delegate_when_nil'

Mix in the DelegateWhenNil module

   class Widget
     extend DelegateWhenNil
     ...

To use with ActiveRecord, put this in an initializer instead

   ActiveRecord::Base.send :extend, DelegateNil

Then #delegate_when_nil is available as a class method on your model,

   class Widget < PopularFramework::Base
     attr_accessor :parent
     attr_accessor :description, :colour, :height
     delegate_when_nil :description, :colour, :height, to: :parent
     ...

In this example, if the #description, #colour, or #height properties are accessed and are nil, DelegateWhenNil will ask the #parent property instead.

   p = Parent.new :description => "Woggle"
   w = Widget.new :parent => p, :colour => :blue

   w.description #=> "Woggle"
   w.colour      #=> :blue

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
