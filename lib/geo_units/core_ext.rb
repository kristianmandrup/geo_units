require 'sugar-high/numeric'

module GeoUnitExt
  ::GeoUnits.units.each do |unit|
    class_eval %{
      def #{unit}_to unit
        unit = GeoUnits.key(unit)
        self.to_f * GeoUnits::Maps::Meters.from_unit[:#{unit}] * GeoUnits::Maps::Meters.to_unit[unit]
      end
    }
  end

  include NumberDslExt # from sugar-high

  def to_rad
    GeoUnits::Converter.to_rad self
  end
  alias_method :to_radians, :to_rad
  alias_method :degrees_to_rad, :to_radians
  alias_method :deg_to_rad, :to_radians
end

class Numeric
  include GeoUnitExt
  include ::GeoUnits::Numeric
  include ::GeoUnits::Numeric::Dms
  include ::GeoUnits::Numeric::Normalizer
end

class String
  def parse_dms options = {}
    GeoUnits::Converter::Dms.parse_dms self, options
  end
end

class Array
  def to_dms
    lat = self.respond_to?(:to_lat) ? self.to_lat : self[0]
    lng = self.respond_to?(:to_lng) ? self.to_lng : self[1]
    [lat.to_lat_dms, lng.to_lng_dms].join(', ')
  end

  def parse_dms
    lat = self.respond_to?(:to_lat) ? self.to_lat : self[0]
    lng = self.respond_to?(:to_lng) ? self.to_lng : self[1]
    [lat.parse_dms, lng.parse_dms]
  end
end
