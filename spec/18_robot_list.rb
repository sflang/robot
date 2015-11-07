require_relative 'spec_helper'

describe Robot do
  before :each do
    Robot.class_variable_set :@@robot_list, []
  end
  
  describe '.robot_list' do

    it "should initialiiy be empty" do
      expect(Robot.robot_list).to eq([])
    end

    it "should have an element for each instance" do
      array_of_robots = []
      10.times { array_of_robots << Robot.new}
      expect(Robot.robot_list.length).to eq(10)
    end
  end
end
