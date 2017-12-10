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
    @img||= Gosu::Image.new(Frame.window, Circle.new(self.radius, self.color[0], self.color[1], self.color[2]), false)
  end
  def dist_to x
    dist_in_au = (0..2).to_a.map do |i|
      (self.pos[i]-x.pos[i])**2
    end.inject(0){|h,e|h+e}**0.5
     
    dist_in_au #* (1.496 * 10**11)
  end
  def add_gravity_from(x, timescale)
   # STDERR.puts "V MAG #{Frame.mag_of_vector(self.vel)}"
   #puts "DIST TO %0.02f" % self.dist_to(x)

    force =  timescale * ((self.mass * x.mass) * G_IN_AU_PER_KG_D2)/((self.dist_to(x)**2)*self.mass)
    dir = Frame.normalize_vec Frame.sub_vectors(x.pos, self.pos)
    self.vel = Frame.add_vectors self.vel, dir.map{|comp|comp*force} 

  end
  def update_pos(timescale)
    #STDERR.puts 'update_pos'
    (0..2).to_a.each{|i|
      self.pos[i] += (self.vel[i]*timescale)
    }
    #pp self.pos
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


