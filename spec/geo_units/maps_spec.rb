require 'spec_helper'

class Map
  include GeoUnits::Maps
end

def map
  Map.new
end

# - www.movable-type.co.uk/scripts/latlong.html
describe GeoUnits::Maps::Earth do
  subject { map }

  # earth
  specify { subject.distance_per_latitude_degree[:miles].should be_between(69, 69.5) }

  # meters
  specify { subject.from_unit[:feet].should   be_between(0.3045, 0.305)  }

  # maps
  specify { subject.precision[:miles].should == 4  }
end


