require 'gosu'

class Player
    
    def initialize window
        @window = window
    end
    
end

class Game < Gosu::Window
    
    def initialize width=800, height=600, fullscreen=false
        super
        @player = Player.new self
    end
    
end

Game.new.show