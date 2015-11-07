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

    @robot_array[4].equipped_weapon = SpecialWeapon.new

  end
  
  describe '#attack' do
    #binding.pry

    it "@robot_array[4] attacks all 4 robots with special weapon" do
      @robot_array[4].attack
      @robot_array[0..3].each do |robot|
        expect(robot.health).to eq(70)
      end
    end
    
  end
end
