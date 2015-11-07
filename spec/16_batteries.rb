require_relative 'spec_helper'

describe Battery do
  before :each do
    @battery = Battery.new
  end

  it "should be an item" do
    expect(@battery).to be_an(Item)
  end

  it "should have name 'Battery'" do
    expect(@battery.name).to eq("Battery")
  end

  it "should have weight 25" do
    expect(@battery.weight).to eq(25)
  end

end
