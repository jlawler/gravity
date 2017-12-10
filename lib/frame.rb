class Frame
	class <<self
		attr_accessor :width, :height, :window, :width_au, :height_au, :frame, :zoom, :speed, :time
  end

  def self.zoom=x
    @zoom=x
    Frame.height_au = Frame.height*Frame.zoom/240
    Frame.width_au = Frame.width*Frame.zoom/240
  end


end
Frame.time = 0
Frame.speed = 1
Frame.frame = 0
Frame.height = 480
Frame.width = 640
Frame.zoom = 1.0
