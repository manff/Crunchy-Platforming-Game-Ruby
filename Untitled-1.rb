require 'gosu'

class GameWindow < Gosu::Window
    
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Gosu Tutorial Game"
    
    @image = Gosu::Image.from_text self, "Hello World", Gosu.default_font_name, 100
    
    @music = Gosu::Song.new "Crunchy_Music/The Underground.mp3"
    
    @music.play
    
  end
  
  def button_down id
      close if id == Gosu::KbEscape
  end

  def update
      @x = self.width/2 - @image.width/2 + Math.sin(Time.now.to_f)+100
      @y = self.height/2 - @image.height/2 + Math.cos(Time.now.to_f)+200
  end

  def draw
      @image.draw @x, @y, 0
  end
end

GameWindow.new.show
