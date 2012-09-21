 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 #  Geodesy representation conversion functions (c) Chris Veness 2002-2010
 #   - www.movable-type.co.uk/scripts/latlong.html
 #
 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  

# Parses string representing degrees/minutes/seconds into numeric degrees
# 
# This is very flexible on formats, allowing signed decimal degrees, or deg-min-sec optionally
# suffixed by compass direction (NSEW). A variety of separators are accepted (eg 3º 37' 09"W) 
# or fixed-width format without separators (eg 0033709W). Seconds and minutes may be omitted. 
# (Note minimal validation is done).
# 
# @param   [String|Number] Degrees or deg/min/sec in variety of formats
# @returns [Number] Degrees as decimal number
# @throws  ArgumentError

require 'sugar-high/numeric'
require 'sweetloader'

module GeoUnits
  autoload_modules :Constants, :Converter, :Maps, :Numeric

  class << self
    attr_accessor :default_coords_order

    def default_coords_order
      @default_coords_order ||= :lng_lat
    end
  end

  def self.included(base)
    [Maps, Constants, UnitConversions].each do |module_name| 
      base.send :include, module_name
      base.extend module_name
    end
  end

  def self.units
    [:feet, :meters, :kms, :miles, :radians]
  end

  units.each do |unit|
    class_eval %{
      def self.#{unit}_to unit, number = 0
        return 0 if number <= 0
        unit = key(unit)
        m = number / GeoUnits::Maps.meters_map[:#{unit}]
        m * GeoUnits::Maps.meters_map[unit]
      end
    }
  end

  module ClassMethods
    def key unit = :km
      unit = unit.to_sym
      methods.grep(/_unit$/).each do |meth|
        return meth.to_s.chomp('_unit').to_sym if send(meth).include? unit
      end
      raise ArgumentError, "Unknown unit key: #{unit}"
    end

    def all_units
      [:miles, :mile, :kms, :km, :feet, :foot, :meter, :meters, :radians, :rad]
    end

    protected

    def feet_unit
      [:ft, :feet, :foot]
    end

    def meters_unit
      [:m, :meter, :meters]
    end

    def kms_unit
      [:km, :kms, :kilometer, :kilometers]
    end

    def miles_unit
      [:mil, :mile, :miles]
    end

    def radians_unit
      [:rad, :radians]
    end
  end

  extend ClassMethods
end

require 'geo_units/core_ext'

