class SpecialWeapon < Weapon
  attr_reader :range


  def initialize
    super("Special Weapon", 40, 30)
    @range = 1
  end

  def hit(robot, amount=45)
    #binding.pry
    robot.wound(robot.shield + damage)
  end

end