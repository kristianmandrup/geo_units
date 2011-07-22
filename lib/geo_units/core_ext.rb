require 'sugar-high/numeric'

module GeoUnitExt
  ::GeoUnits.units.each do |unit|
    class_eval %{
      def #{unit}_to unit
        unit = GeoUnits.key(unit)
        (self.to_f / GeoUnits::Meters.from_unit[:#{unit}]) * GeoUnits::Meters.to_unit[unit]
      end
    }
  end

  include NumberDslExt # from sugar-high

  def rpd
    self * GeoUnits.radians_per_degree
  end
  alias_method :to_radians, :rpd
end

class Fixnum
  include GeoUnitExt
  include ::GeoUnits::Numeric
end

class Float
  include GeoUnitExt
  include ::GeoUnits::Numeric
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
