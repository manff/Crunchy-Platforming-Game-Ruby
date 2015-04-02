require 'gosu'


class Crunchy
    
    def initialize(window)
        $moveing = false
        $facing_right = false
        

        @crunchy_right = Gosu::Image.new(window, "Crunchy_Pictures/Crunchy-Right.png", false)
        @crunchy_left = Gosu::Image.new(window, "Crunchy_Pictures/Crunchy-Left.png", false)
    end
    
    
    
    def draw(x, y)
        @x = x
        @y = y
        
        
        
        if ($facing_right) then
            @crunchy_right.draw(@x, @y, 0)
        else
            @crunchy_left.draw(@x, @y, 0)
        end
    end
end

class Enemy
    
end

class Tad < Enemy
    def initialize(window)
        @tad_right = Gosu::Image.new(window, "Crunchy_Pictures/Tad-Facing-Right.png", false)
        @timer = 0
        @tadRight = false
        
        @x = 200
        @y = 200
    end
    
    def draw
        @tad_right.draw(@x, @y, 0)
    end
    
    def update
        @timer += 1
        
        if (@timer > 500)
            @tadRight = !@tadRight
            @timer = 0
        end
        
        if (@tadRight) then
            @x += 10
        else
            @x -= 10
        end
    end
end


class World
    
   def initialize(window, fileName)
       @background = Gosu::Image.new(window, fileName, false)
   end
   
   def draw
       @background.draw(0, 0, 0)
   end
end


class GameWindow < Gosu::Window
    
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Gosu Tutorial Game"
    
    @crunchy_move_x = 200
    @crunchy_move_y = 200
    
    @tad_test = Tad.new(self)
    @crunchy1 = Crunchy.new(self)
    @world1 = World.new(self, "Crunchy_Pictures/World-One-Background.jpeg")
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
  end
  
  def button_up(id)
      if id == Gosu::KbRight && $facing_right then
          $moving = false
      end
      
      if id == Gosu::KbLeft && !$facing_right then
          $moving = false
      end
  end

  def update
      if ($moving) then
          if ($facing_right) then
              @crunchy_move_x += 5
              else
              @crunchy_move_x -= 5
          end
      end
      
      @tad_test.update
      
      
  end

  def draw
    @world1.draw
    @crunchy1.draw(@crunchy_move_x, @crunchy_move_y)
    @tad_test.draw
    
  end
end

GameWindow.new.show
