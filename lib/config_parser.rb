require 'yaml'
require 'planetoid'
require 'matrix'


class GravityConfig
  attr_accessor :bodies, :raw_config, :window_x, :window_y, :au_scale, :paused , :name
  def initialize x
    @raw_config=x
  end
  def self.parse_file(frame, file_name)
    gc = GravityConfig.new YAML.load(File.read(file_name))
    gc.raw_config['bodies'].each {|(k,z)|
      (gc.bodies||=[]) <<  parse_entry(frame, z.merge(Hash[:name, k]))
    }
    gc
  end
  def self.parse_entry(frame, h)
    ret = { name: h[:name] }
    ret[:mass] = eval(h['mass'])
    pos_line, vel_line = *h['position'].split(/\n/)
    ret[:pos] = Vector[*pos_line.split(/\s+/).map{|i|parse_sci_notation(i)}]
    ret[:vel] = Vector[*vel_line.split(/\s+/).map{|i|parse_sci_notation(i)}]
    %w(radius color).each{|i|
      ret[i.to_sym] = h[i] if h[i]
    }
    Planetoid.new ret, frame 
  end
  def self.parse_sci_notation(e)
    raise "Unknown entry #{e.inspect}" unless e=~/^(-?\d+\.\d+)E(.*)$/
    $1.to_f * (10**($2.to_i))
  end
end


