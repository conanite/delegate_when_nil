require 'spec_helper'

describe DelegateWhenNil do
  class Parent
    attr_accessor :last_name
  end

  class Child
    extend DelegateWhenNil
    attr_accessor :last_name, :parent
    delegate_when_nil :last_name, :to => :parent
  end

  it "should not intervene when the property is present" do
    child = Child.new
    child.last_name = "Wong"
    expect(child.last_name).to eq "Wong"
  end

  it "should not intervene when the property is present and the delegate target is also present" do
    child = Child.new
    child.last_name = "Shaw"
    child.parent = Parent.new
    expect(child.last_name).to eq "Shaw"
  end

  it "should not intervene when the property is present and the delegate target is also present" do
    child = Child.new
    child.parent = Parent.new
    child.parent.last_name = "Wonka"
    expect(child.last_name).to eq "Wonka"
  end
end
