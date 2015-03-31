require 'gosu'

class Character
   
   def initialize(window)
       @window = window
   end
   
end

class Crunchy < Character
   
   def draw
       @curnchy_img = Gosu::Image.new(@window, "Crunchy_Pictures/Right-Facing-Crunchy-the-Snail.jpg", false)
       @crunchy_img.draw(0, 0, 0)
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
    
    @crunchy = Crunchy.new(self)
    @world1 = World.new(self, "Crunchy_Pictures/World-One-Background.jpeg")
  end
  
  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
      
  end

  def draw
    @world1.draw
    @crunchy.draw
  end
end

GameWindow.new.show
