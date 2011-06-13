class Fixnum
  include ::GeoUnits::NumericExt 
end

class Float
  include ::GeoUnits::NumericExt
end

class String  
  def parse_dms
    GeoUnits::DmsConverter.parse_dms self
  end
end
