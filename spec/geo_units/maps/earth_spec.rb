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

  specify { subject.distance_per_latitude_degree[:miles].should be_between(69, 69.5) }

  specify { subject.radius[:miles].should be_between(3963, 3964) }

  specify { subject.major_axis_radius[:miles].should be_between(3963, 3964) }

  specify { subject.minor_axis_radius[:miles].should be_between(3949, 3950) }

  specify { subject.latitude_degrees(:miles).should be_between(57, 58)  }
end

