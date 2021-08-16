require 'spec_helper'
require 'not_blank'

describe DelegateWhenNil do
  before(:all) { NotBlank.setup }

  class ::String
    def blank?
      strip == ""
    end
  end

  class Person
    attr_accessor :last_name, :parent
    delegate_when_blank :last_name, to: :parent, prefix: :get
  end

  it "does not delegate when the local property is present" do
    child = Person.new
    child.last_name = "Wong"
    expect(child.get_last_name).to eq "Wong"
  end

  it "does not get upset when everything is nil" do
    child = Person.new
    expect(child.last_name).to eq nil
    expect(child.get_last_name).to eq nil
  end

  it "does not delegate when the property is present and the delegate target is also present" do
    child = Person.new
    child.last_name = "Shaw"
    child.parent = Person.new
    expect(child.last_name).to eq "Shaw"
    expect(child.get_last_name).to eq "Shaw"
  end

  it "delegates when the property is nil and the delegate target is present" do
    child = Person.new
    child.parent = Person.new
    child.parent.last_name = "Wonka"
    expect(child.last_name).to be_nil
    expect(child.get_last_name).to eq "Wonka"
  end

  it "delegates when the property is blank and the delegate target is also present" do
    child = Person.new
    child.last_name = ""

    child.parent = Person.new
    child.parent.last_name = "Wonka"

    expect(child.last_name).to eq ""
    expect(child.get_last_name).to eq "Wonka"
  end

  it "delegates recursively" do
    child = Person.new
    child.last_name = ""

    child.parent = Person.new
    child.parent.last_name = "  "

    child.parent.parent = Person.new
    child.parent.parent.last_name = "Socrates"

    expect(child.last_name).to eq ""
    expect(child.get_last_name).to eq "Socrates"
  end

end
