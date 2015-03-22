require 'gosu'

class GameWindow < Gosu::Window
    
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Gosu Tutorial Game"
    
    @image = Gosu::Image.from_text self, "Hello World", Gosu.default_font_name, 100
  end
  
  def button_down id
      close if id == Gosu::KbEscape
  end

  def update
      
  end

  def draw
      @image.draw 400 - @image.width/2, 300 - @image.height/2, 0
  end
end

GameWindow.new.show
