require 'pp'
class Planetoid
  METH = [ :mass, :pos, :vel, :radius, :color, :queued_acc, :name ]
  attr_accessor :frame, *METH
  def initialize h={}, frame
    METH.each{|e| instance_variable_set("@#{e.to_s}".to_sym, h[e])}
    self.frame = frame
    self.radius = h[:radius]||50
    self.color = h[:color] || [255, 0, 0]
  end
  def queued_acc
    @queued_acc ||= Vector[0.0,0.0,0.0]
  end
  def img
    @img||= Gosu::Image.new(Circle.new(self.radius, self.color[0], self.color[1], self.color[2]))
  end
  def dist_to x
    (self.pos - x.pos).magnitude
  end
  def queue_gravity_from( x )
    force =  self.frame.speed * ((self.mass * x.mass) * Frame::G_IN_AU_PER_KG_D2)/((self.dist_to(x)**2)*self.mass)
    dir = (x.pos - self.pos).normalize
    self.queued_acc = self.queued_acc + (dir*force)
  end
  def process_queue
    self.vel = self.vel + self.queued_acc
    self.queued_acc = nil 
  end
  def update_pos time=nil
    process_queue
    self.pos = self.pos + (self.vel*frame.speed)
  end
	def draw
    x =  (((self.frame.width_au*1.0/2) + self.pos[0])*self.frame.width / self.frame.width_au) - self.radius
    y =  (((self.frame.height_au*1.0/2) + self.pos[1])*self.frame.height / self.frame.height_au) - self.radius
    self.img.draw( x, y, 0)
  end
end


