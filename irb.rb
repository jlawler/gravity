require 'rubygems'
require 'gosu'

$:.unshift './lib'

require 'config_parser'
require 'gosu_circle'
require 'frame'

def velocity_for_orbit(range_in_au)
  sun_mass = 1.989*(10**30)
  (Frame::G_IN_AU_PER_KG_D2 * sun_mass)**0.5

end

