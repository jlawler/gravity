
class Frame
  G_IN_AU_PER_KG_D2  = 1.488*(10**-34)
  G_IN_M_PER_KG_S2   = 6.693*(10**-11)
  M_PER_AU = (1.496 * 10**11)


  METH = [ :width, :height, :window, :width_au, :height_au, :frame, :zoom, :speed, :time ]
  attr_accessor *METH
    DEFAULTS = {
      time: 0,
      speed: 1,
      frame: 0,
      height: 960,
      width: 1280,
      zoom: 1.0
    }
  def height_au
    self.height*self.zoom/240
  end
  def width_au
    self.width*self.zoom/240
  end
  def initialize args={}
    h = DEFAULTS.merge args
    METH.each{|e| instance_variable_set("@#{e.to_s}".to_sym, h[e])}
  end
end

