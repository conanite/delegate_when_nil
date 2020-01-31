# DelegateWhenNil

This gem provides a macro-method, #delegate_when_nil, which works kind of like #delegate, except it evaluates
the expression locally first, and delegates to the target only if the local result is nil.


    class Parent
      attr_accessor :name, :address
      ...
    end

    class Child
      attr_accessor :name, :address
      delegate_when_nil :name, :address, to: :parent, prefix: :get

      # equivalent to
      # def get_name
      #   self.name || (parent && parent.get_name) # #get_name on Parent might delegate further...
      # end

    # use #stop option to avoid the prefix on the parent attribute (delegation "stops" at parent)

    class Child
      delegate_when_nil :name, :address, to: :parent, prefix: :get, stop: true

      # equivalent to
      # def get_name
      #   self.name || (parent && parent.name) # #name directly on parent instead of #get_name
      # end

## Installation

Add this line to your application's Gemfile:

    gem 'delegate_when_nil'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install delegate_when_nil

## Usage

DelegateWhenNil installs itself in Module so is available everywhere in your code.

    class Widget < PopularFramework::Base
      attr_accessor :parent
      attr_accessor :description, :colour, :height
      delegate_when_nil :description, :colour, :height, to: :parent, prefix: :get
      ...

In this example, if the #description, #colour, or #height properties are accessed and are nil, DelegateWhenNil will ask the #parent property instead.

    p = Parent.new :description => "Woggle"
    w = Widget.new :parent => p, :colour => :blue

    w.get_description #=> "Woggle"
    w.get_colour      #=> :blue

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
