require_relative 'spec_helper'

describe Robot do
  before :each do
    Robot.class_variable_set :@@robot_list, []
    @robot_array = []
    5.times {@robot_array << Robot.new}
    
    #[0] at (0,1)
    1.times {@robot_array[0].move_up}

    #[1] at (0, -1)
    1.times {@robot_array[1].move_down}

    #[2] at (-1, 0)
    1.times {@robot_array[2].move_left}

    #[3] at (1, 0)
    1.times {@robot_array[3].move_right}

    #[4] at (0, 0)

  end
  
  describe '#scan' do

    it "@robot_array[4] is surrounded by 4 robots" do
      expect(@robot_array[4].scan.length).to eq(4)
    end

    it "move @rob0t_array[4] up by 2, scan should return 1" do
      2.times {@robot_array[4].move_up}
      expect(@robot_array[4].scan.length).to eq(1)
    end

    it "move @rob0t_array[4] down by 2, scan should return 1" do
      2.times {@robot_array[4].move_down}
      expect(@robot_array[4].scan.length).to eq(1)
    end

    it "move @robot_array[4] left by 2, scan should return 1" do
      2.times {@robot_array[4].move_left}
      expect(@robot_array[4].scan.length).to eq(1)
    end

    it "move @rob0t_array[4] right by 2, scan should return 1" do
      2.times {@robot_array[4].move_right}
      expect(@robot_array[4].scan.length).to eq(1)
    end

    it "move @rob0t_array[4] rout of range, scan should return 0" do
      3.times {@robot_array[4].move_right}
      expect(@robot_array[4].scan.length).to eq(0)
    end
    
  end
end
