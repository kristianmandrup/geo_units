require 'spec_helper'

class Meters
  include GeoUnits::Maps::Meters
end

def meters
  Meters.new
end

# - www.movable-type.co.uk/scripts/latlong.html
describe GeoUnits::Maps::Meters do
  subject { meters }

  specify { subject.from_unit[:feet].should   be_between(0.3045, 0.305)  }

  specify { subject.from_unit[:miles].should  be_between(1609, 1610) }

  specify { subject.to_unit[:feet].should     be_between(3.28, 3.29)  }

  specify { subject.to_unit[:miles].should    be_between(0.0006, 0.0007) }
end


