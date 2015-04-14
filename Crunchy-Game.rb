require 'gosu'

class Character
    def collision
        $blocks_y.each do |y|
            $blocks_x.each do |x|
                if (@y > y && @x + 60 > x && @x < x + 30)
                    @y = y
                    @jump_speed = 0
                    @jumping = false
                end
            end
        end
    end
    
    def move
        if ($moving) then
            if ($facing_right) then
                @x += 5
            else
                @x -= 5
            end
        end
        
        if (!@jumping) then
            if ($up_key_down)
                @jumping = true
                @jump_speed = -50
            end
        end

        @jump_speed += $gravity
        @y += @jump_speed
        
#        if (@y > 510) then
#            @y = 510
#            @jump_speed = 0
#            @jumping = false
#        end
    end
    
    def draw
        if ($facing_right) then
            @pic_right.draw(@x, @y, 0)
        else
            @pic_left.draw(@x, @y, 0)
        end
    end
end


class Crunchy < Character
    def initialize(window)
        $moveing = false
        $facing_right = false
        
        $gravity = 5
        
        $up_key_down = false
        
        @crunchy_x = 200
        @crunchy_y = 200
        
        @x = @crunchy_x
        @y = @crunchy_y

        @jumping = false
        @jump_speed = 0

        @crunchy_right = Gosu::Image.new(window, "Crunchy_Pictures/Crunchy-Right.png", false)
        @crunchy_left = Gosu::Image.new(window, "Crunchy_Pictures/Crunchy-Left.png", false)
        
        @pic_right = @crunchy_right
        @pic_left = @crunchy_left
    end
end


class Enemy
    def draw
        @enemy_pic_left.draw(@tad_x, @tad_y, 0)
    end
    
    def move
        @timer += 1
        
        if (@timer > 100)
            @tadRight = !@tadRight
            @timer = 0
        end
        
        if (@tadRight) then
            @tad_x += 5
        else
            @tad_x -= 5
        end
    end
end


class Tad < Enemy
    def initialize(window)
        @tad_right = Gosu::Image.new(window, "Crunchy_Pictures/Tad-Facing-Right.png", false)
        @timer = 0
        @tadRight = false
        
        @enemy_pic_left = @tad_right
        
        @tad_x = 500
        @tad_y = 200
    end
end


class Collectable
    def draw
        @collectable.draw($coin_x, $coin_y, 0)
    end
end


class Coin < Collectable
    def initialize(window)
        coin_x = 300
        coin_y = 300
        $coin_x = coin_x
        $coin_y = coin_y
        coin = Gosu::Image.new(window, "Crunchy_Pictures/Coin.png", false)
        @collectable = coin
    end
end


class SlimeCoin < Collectable
    def initialize(window)
        slime_coin_x = 400
        slime_coin_y = 400
        @x = slime_coin_x
        @y = slime_coin_y
        slime_coin = Gosu::Image.new(window, "Crunchy_Pictures/Slime-Coin.png", false)
        @collectable = slime_coin
    end
end


class Block
    def initialize(window, x, y)
        @block = Gosu::Image.new(window, "Crunchy_Pictures/Grass-Block.png", false)
        
        @x, @y = x, y
    end
    
    def draw
        @block.draw(@x, @y, 0)
    end
end


class Map
    def initialize(window)
        $col = 0
        $row = 0
        @levels = [
            ["#                 #      ##",
             "#    #                    #",
             "#                         #",
             "#       #                 #",
             "#   #          #          #",
             "#                         #",
             "#                         #",
             "#                         #",
             "#                  #      #",
             "#                         #",
             "#                         #",
             "#       #                 #",
             "#                         #",
             "#                         #",
             "#            #            #",
             "#                         #",
             "#                         #",
             "#                         #",
             "#                         #",
             "###########################"],
             
            ["  ",
             "  "]
         ]
         @level = 0
         @blocks = []
         $blocks_x = []
         $blocks_y = []
         
         @width = window.width
         @height = window.height
         @x = -30
         @y = -30
    end
    
    def load
        @levels.each do |level|
            level.each do |y|
                @y += 30
                y.split("").each do |x|
                    @x += 30
                    
                    if (@x == y.length * 30) then
                        @x = 0
                    end
                    
                    if (x == "#") then
                        @blocks.push(Block.new($self, @x, @y))
                        
                        $blocks_x.push(@x)
                        $blocks_y.push(@y)
                        
                        puts "Getting Map"
                        puts "block x: #{@x}"
                        puts "block y: #{@y}"
                    end
                end
            end
            puts "__"
        end
    end
    
    def apply
        @blocks.each do |c|
            c.draw
        end
    end
end


class GameWindow < Gosu::Window
    
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Gosu Tutorial Game"
    
    $self = self
    
    @coin_test = Coin.new(self)
    @slime_coin_test = SlimeCoin.new(self)
    @tad_test = Tad.new(self)
    @crunchy1 = Crunchy.new(self)
    @map = Map.new(self)
    @map.load
  end
  
  def button_down(id)
      if id == Gosu::KbEscape then close end
      
      if id == Gosu::KbRight then
          $facing_right = true
          $moving = true
      end
      
      if id == Gosu::KbLeft then
          $facing_right = false
          $moving = true
      end
      
      if id == Gosu::KbUp then
          $up_key_down = true
      end
  end
  
  def button_up(id)
      if id == Gosu::KbRight && $facing_right then
          $moving = false
      end
      
      if id == Gosu::KbLeft && !$facing_right then
          $moving = false
      end
      
      if id == Gosu::KbUp then
          $up_key_down = false
      end
  end

  def update
      @crunchy1.move
      @tad_test.move
      @crunchy1.collision
  end

  def draw
    @crunchy1.draw
    @tad_test.draw
    @coin_test.draw
    @slime_coin_test.draw
    @map.apply
  end
end

GameWindow.new.show
