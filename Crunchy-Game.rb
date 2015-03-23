require 'gosu'

class Crunchy
   
   def initialize window
    @image = Gosu::Image.new window, "Crunchy_Pictures/Left-Facing-Crunchy-the-Snail.jpg", false
    @x = 0
    @y = 0
    @speed
   end
   
   def warp x, y
    @x = x
    @y = y
   end
   
   def move
    @x += @speed
    @y += @speed
   end
   
   def draw
    @image.draw @x, @y, 0
   end
   
end

class GameWindow < Gosu::Window
    
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Gosu Tutorial Game"
    
    @crunchy1 = Crunchy.new(self)
    @crunchy1.warp 320, 240
  end
  
  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
      
  end

  def draw
    @player.draw
  end
end

GameWindow.new.show
