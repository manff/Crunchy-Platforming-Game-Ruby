require 'gosu'

class GameWindow < Gosu::Window
  def initialize width=600, height=600, fullscreen=false
    super
    self.caption = "Gosu Tutorial Game"
    
    @image = Gosu::image.from_text self, "Hello World", Gosu.default_font_name, 100
  end
  
  def button_down id
      close if id == Gosu::KbEscape
  end

  def update
      
  end

  def draw
      @image.draw 0, 0, 0
  end
end

window = GameWindow.new
window.show