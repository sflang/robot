class Robot
  attr_reader :position, :items, :health , :shield
  attr_accessor :equipped_weapon

  @@robot_list = []

  def initialize
    @position = [0,0]
    @items    = []
    @health   = 100
    @shield   = 50

    @@robot_list << self
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def move_up
    @position[1] += 1
  end

  def pick_up(item)
    
    if items_weight < 250

      case
      when item.class == BoxOfBolts then
        item.feed(self) if health <= 80 
      when item.class == Battery then
        @shield = 50
      end

      @equipped_weapon = item if item.is_a? Weapon
      items << item
    end
    
    
  end

  def items_weight
    items.inject(0){ |weight, item| weight += item.weight}
  end
  
  def wound(amount)
    if shield - amount >= 0
      @shield -= amount
      amount  = 0
    else
      amount  -= shield
      @shield = 0
    end
      
    if health - amount >= 0 
      @health -= amount
    else
      @health = 0
    end
  end

  def heal(amount)
    
    if health + amount > 100
      @health = 100
    else
      @health += amount
    end
  end

  def heal!(amount)
    raise "Robot is dead" if health <= 0
    heal(amount)
  end

  def attack(enemy=nil, amount=5)
    #binding.pry
    if equipped_weapon.nil? || !(equipped_weapon.respond_to? :range)
      range = 1
    else 
      range = equipped_weapon.range
    end


    case 
    when equipped_weapon.class == Grenade then
      #binding.pry
      do_it(enemy, amount) if in_range?(enemy, range)

    when equipped_weapon.class == SpecialWeapon then
      robots_to_attack = self.scan
      robots_to_attack.each do |robot|
        #bypass shields by increasing attack power by the
        #remaining shield points
        #binding.pry
        do_it(robot, amount)
      end

    else
      #binding.pry
      do_it(enemy, amount) if in_range?(enemy, range)
    end
    self.equipped_weapon = nil
  end

  def attack!(enemy, amount=5)
    raise "Can only attack a robot" unless enemy.is_a? Robot
    attack(enemy, amount)
  end

  def scan
    x = @position[0]
    y = @position[1]
    robots_from_scan = []

    right = Robot.in_position(x + 1, y    )
    left  = Robot.in_position(x - 1, y    )
    above = Robot.in_position(x    , y + 1)
    below = Robot.in_position(x    , y - 1)

    #binding.pry
    right.each { |robot| robots_from_scan << robot}
    left.each { |robot| robots_from_scan << robot}
    above.each { |robot| robots_from_scan << robot}
    below.each { |robot| robots_from_scan << robot}
      
    robots_from_scan
  end

  #Cless methods here
  def self.robot_list
    @@robot_list
  end

  def self.in_position(x, y)
    @@robot_list.select { |robot| robot.position == [x, y]}
  end

  private

  def vertical_distance(enemy)
    (position[1] - enemy.position[1]).abs
  end

  def horizontal_distance(enemy)
    (position[0] - enemy.position[0]).abs
  end

  def in_range?(enemy, range)

    dist = Math.sqrt(vertical_distance(enemy) **2 + horizontal_distance(enemy) **2)
    
    #binding.pry 
    dist.floor <= range
  end



  def do_it(enemy, amount)
    unless equipped_weapon == nil
      equipped_weapon.hit(enemy)
    else
      enemy.wound(amount)
    end
  end

end
