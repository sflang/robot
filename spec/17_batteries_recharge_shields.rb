require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @battery = Battery.new
  end

  
  describe "#pick_up" do
    it "recharges depleted shield" do
      @robot.wound(100)
      expect(@robot.shield).to eq(0)
      expect(@robot.health).to eq(50)

      # add item2 to collection of items, and make sure it's there when we call #items
      @robot.pick_up(@battery)
      expect(@robot.shield).to eq(50)
      expect(@robot.health).to eq(50)
    end
  end
end