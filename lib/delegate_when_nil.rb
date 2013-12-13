require "delegate_when_nil/version"

module DelegateWhenNil
  def define_conditional_delegation name, target
    old_name = "delegate_when_nil_#{name}".to_sym
    return if method_defined? old_name

    class_eval <<DELEGATION
      alias #{old_name} #{name}                         # alias delegate_when_nil_description description
      def #{name} *args                                 # def description *args
        result = #{old_name}(*args)                     #   result = delegate_when_nil_description(*args)
        if result == nil                                #   if result == nil
           delegate = #{target}                         #     delegate = parent
           result = delegate.#{name}(*args) if delegate #     result = delegate.description(*args) if delegate
        end                                             #   end
        result                                          #   result
      end                                               # end
DELEGATION
  end

  def delegate_when_nil *names
    target = names.pop[:to]
    raise "missing :to option to #delegate_when_nil for #{name}" if target.to_s == ""
    names.each do |name|
      define_conditional_delegation name, target
    end
  end
end
