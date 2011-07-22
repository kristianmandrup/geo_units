require 'spec_helper'

class Earth
  include GeoUnits::Maps::Earth
end

def earth
  Earth.new
end

# - www.movable-type.co.uk/scripts/latlong.html
describe GeoUnits::Maps::Earth do
  subject { earth }

  specify { subject.distance_per_latitude_degree[:miles].should == 69.407 }
end

