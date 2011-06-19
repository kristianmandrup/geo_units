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

class Array
  def to_dms
    lat = self.respond_to?(:to_lat) ? self.to_lat : self[0]
    lng = self.respond_to?(:to_lng) ? self.to_lng : self[1]    
    [lat.to_lat_dms, lng.to_lng_dms].join(', ')
  end
end