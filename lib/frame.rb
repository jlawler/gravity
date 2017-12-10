class Frame
	class <<self
		attr_accessor :width, :height, :window, :width_au, :height_au, :frame, :zoom
  end
  def self.mag_of_vector x
    tot = 0
    x.each{|xe| tot = tot + (xe**2) }
    tot ** 0.5
  end
  def self.add_vectors x,y
    [x,y].transpose.map{|(a,b)|a+b}
  end

  def self.sub_vectors x,y
    [x,y].transpose.map{|(a,b)|a-b}
  end
  def self.normalize_vec x
    m = mag_of_vector(x)
    x.map{|i|i*1.0/m}
  end
  def self.zoom=x
    @zoom=x
    Frame.height_au = Frame.height*Frame.zoom/240
    Frame.width_au = Frame.width*Frame.zoom/240
  end


end
Frame.frame = 0
Frame.height = 480
Frame.width = 640
Frame.zoom = 1.0
