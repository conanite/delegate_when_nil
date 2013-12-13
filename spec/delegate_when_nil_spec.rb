require 'spec_helper'

describe DelegateWhenNil do
  class Parent
    attr_accessor :last_name
  end

  class Child
    extend DelegateWhenNil
    attr_accessor :last_name, :parent, :size
    delegate_when_nil :last_name, :to => :parent
    delegate_when_nil :size, :to => :"parent.last_name"
  end

  it "should not intervene when the property is present" do
    child = Child.new
    child.last_name = "Wong"
    expect(child.last_name).to eq "Wong"
  end

  it "should not get upset when everything is nil" do
    child = Child.new
    expect(child.last_name).to eq nil
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

  it "should raise an error if a complex delegation target fails" do
    child = Child.new
    expect { child.size }.to raise_error
  end

  it "should execute a complex delegation target as expected" do
    child = Child.new
    child.parent = Parent.new
    child.parent.last_name = "1234567"
    expect(child.size).to eq 7
  end

  it "should ignore a complex delegation target as expected when the local property is not nil" do
    child = Child.new
    child.size = 21
    child.parent = Parent.new
    child.parent.last_name = "1234567"
    expect(child.size).to eq 21
  end
end
