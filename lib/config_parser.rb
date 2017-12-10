require 'yaml'
require 'planetoid'
require 'matrix'


class GravityConfig
  attr_accessor :bodies, :window_x, :window_y, :au_scale, :paused 
  def self.parse_file(file_name)
    gc = GravityConfig.new
    gc.paused = false
    root = YAML.load(File.read(file_name))
    z = root['bodies'] 
    z.keys.each{|k|
      z[k] = parse_entry(z[k])
    }
    z
    gc.bodies = z
    gc
  end
  def self.parse_entry(h)
    ret = {}
    ret[:mass] = eval(h['mass'])
    pos_line, vel_line = *h['position'].split(/\n/)
    ret[:pos] = Vector[*pos_line.split(/\s+/).map{|i|parse_sci_notation(i)}]
    ret[:vel] = Vector[*vel_line.split(/\s+/).map{|i|parse_sci_notation(i)}]
    %w(radius color).each{|i|
      ret[i.to_sym] = h[i] if h[i]
    }
    Planetoid.new ret 
  end
  def self.parse_sci_notation(e)
    raise "Unknown entry #{e.inspect}" unless e=~/^(-?\d+\.\d+)E(.*)$/
    $1.to_f * (10**($2.to_i))
  end
end


