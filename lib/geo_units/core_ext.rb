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

  def to_lng
    self.match(/[E|W]/) ? self.to_i : nil
  end

  def to_lat
    self.match(/[N|S]/) ? self.to_i : nil
  end
end

class Array
  def to_dms direction = nil
    lng, lat = extract_coords(direction)
    res = direction == :lat_lng ? [lat.to_lat_dms, lng.to_lng_dms] : [lng.to_lng_dms, lat.to_lat_dms]
    res.join(', ')    
  end

  def parse_dms direction = nil
    lng, lat = extract_coords(direction)
    direction == :lat_lng ? [lat.parse_dms, lng.parse_dms] : [lng.parse_dms, lat.parse_dms]
  end

  protected

  def extract_coords direction = nil
    direction ||= GeoUnits.default_coords_order

    unless [:lng_lat, :lat_lng].include? direction
      raise ArgumentError, "Direction must be either :lng_lat or :lat_lng, was: #{direction}. You can also set the default direction via GeoUnits#default_direction="
    end

    lat_index = direction == :reverse ? 0 : 1
    lng_index = direction == :reverse ? 1 : 0

    lat = self.to_lat if self.respond_to?(:to_lat)  
    lat ||= self[lat_index] if self[lat_index].respond_to?(:to_lat) && self[lat_index].to_lat
    lat ||= self[lng_index] if self[lng_index].respond_to?(:to_lat) && self[lng_index].to_lat
    lat ||= self[lat_index]

    lng = self.to_lng if self.respond_to?(:to_lng)
    lng ||= self[lng_index] if self[lng_index].respond_to?(:to_lng) && self[lng_index].to_lng
    lng ||= self[lat_index] if self[lat_index].respond_to?(:to_lng) && self[lat_index].to_lng
    lng ||= self[lng_index]

    [lng, lat]
  end
end
