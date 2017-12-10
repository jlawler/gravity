class Planetoid
  #G = 6.693*(10**-11)
  attr_accessor :mass, :pos, :vel, :radius, :color
  def initialize h={}
    self.mass = h[:mass]
    self.pos = h[:pos]
    self.vel = h[:vel]
    self.radius = h[:radius]||50
    self.color = h[:color] || [255, 0, 0]
  end
  def img
    @img||= Gosu::Image.new(Circle.new(self.radius, self.color[0], self.color[1], self.color[2]))
  end
  def dist_to x
    (self.pos - x.pos).magnitude
  end
  def add_gravity_from(x, timescale)

    force =  timescale * ((self.mass * x.mass) * G_IN_AU_PER_KG_D2)/((self.dist_to(x)**2)*self.mass)
    dir = (x.pos - self.pos).normalize
    self.vel = self.vel + (dir*force)

  end
  def update_pos(timescale)
    self.pos = self.pos + (self.vel*timescale)
  end
	def draw
    x =  
      (((Frame.width_au*1.0/2) + self.pos[0])*Frame.width / Frame.width_au) - self.radius
    y = 
      (((Frame.height_au*1.0/2) + self.pos[1])*Frame.height / Frame.height_au) - self.radius

    self.img.draw(
      x,
      y,
      self.pos[2] ) 

  end
  
end


