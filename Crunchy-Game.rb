require 'gosu'


class Crunchy
    
    def initialize(window)
        @speed = 1
        
        @crunchy = Gosu::Image.new(window, "Crunchy_Pictures/Crunchy-Right.png", false)
    end
    
    def draw(x, y)
        @x = x
        @y = y
        
        @crunchy.draw(@x, @y, 0)
    end
    
    def move
        
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
    
    @crunchy1 = Crunchy.new(self)
    @world1 = World.new(self, "Crunchy_Pictures/World-One-Background.jpeg")
  end
  
  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
      
  end

  def draw
    @world1.draw
    @crunchy1.draw(200, 200)
  end
end

GameWindow.new.show
