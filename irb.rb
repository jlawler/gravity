require 'rubygems'
require 'gosu'
require 'chipmunk'




class Planetoid
  attr_accessor :mass, :pos, :vel
  def initialize h={}
    self.mass = h[:mass]
    self.pos = h[:pos]
    self.vel = h[:vel]
  end
end

SUN=Planetoid.new(
  mass: 1.989*(10**30),
  pos: [0,0,0],
  vel: [0,0,0]
)


