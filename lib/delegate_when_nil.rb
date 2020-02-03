require "delegate_when_nil/version"

module DelegateWhenNil
  # Child defines accessor :name
  # Parent defines accessor :name
  #
  # class Child
  #   delegate_when_nil :name, :address, to: :parent, prefix: :get
  #
  #   # equivalent to
  #   def get_name
  #     self.name || (parent && parent.get_name)
  #   end
  #
  # use #stop option to avoid prefix on parent (delegation "stops" at parent)
  #
  # class Child
  #   delegate_when_nil :name, :address, to: :parent, prefix: :get, stop: true
  #
  #   # equivalent to
  #   def get_name
  #     self.name || (parent && parent.name) # #name directly on parent instead of #get_name
  #   end
  #
  def delegate_when_nil *names
    opts     = names.pop
    raise "please provide a hash with keys :to and :prefix as last argument" unless opts.is_a?(Hash) && opts.key?(:to) && opts.key?(:prefix)

    fallback = opts[:to]
    prefix   = opts[:prefix]
    stop     = opts[:stop]

    raise "prefix required to avoid infinite recursion in #attr_fallback #{names.inspect}" unless prefix

    names.each { |name|
      myname = [prefix, name].compact.join('_')
      fbname = stop ? name : myname
      class_eval "def #{myname}(*args) ; self.#{name}(*args) || (#{fallback} && #{fallback}.#{fbname}(*args)) ; end"
    }
  end
end

Module.send :include, DelegateWhenNil
