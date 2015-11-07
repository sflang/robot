require_relative 'spec_helper'

describe Robot do
  before :each do
    Robot.class_variable_set :@@robot_list, []
    @robot_array = []
    5.times {@robot_array << Robot.new}
    
    #[0] at (5,3)
    5.times {@robot_array[0].move_right}
    3.times {@robot_array[0].move_up}

    #[1] at (-5,-3)
    5.times {@robot_array[1].move_left}
    3.times {@robot_array[1].move_down}

    #[2] at (-5,-3)
    5.times {@robot_array[2].move_left}
    3.times {@robot_array[2].move_down}

    #[3] at (10, -10)
    10.times {@robot_array[3].move_right}
    10.times {@robot_array[3].move_down}

    #[4] at (-100, 100)
    100.times {@robot_array[4].move_left}
    100.times {@robot_array[4].move_up}

  end
  
  describe '.in_position' do

    it "does not return any robots at (0,0)" do
      expect(Robot.in_position(0,0)).to eq([])
    end

    it "returns the correct robot at (5,3)" do
      expect(Robot.in_position(5,3).length).to eq(1)
      expect(Robot.in_position(5,3)[0]).to eq(@robot_array[0])
    end

    it "returns the correct robot at (10,-10)" do
      expect(Robot.in_position(10,-10).length).to eq(1)
      expect(Robot.in_position(10,-10)[0]).to eq(@robot_array[3])
    end

    it "returns the correct robot at (-100,100)" do
      expect(Robot.in_position(-100,100).length).to eq(1)
      expect(Robot.in_position(-100,100)[0]).to eq(@robot_array[4])
    end

    it "returns two robots at (-5,-3)" do
      expect(Robot.in_position(-5,-3).length).to eq(2)
    end

    
  end
end
