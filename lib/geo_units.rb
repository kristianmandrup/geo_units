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
    [:Maps, :Constants, :"Converter::Units"].each do |module_name| 
      module_name = "GeoUnits::#{module_name.to_s.camelize}".constantize
      base.send :include, module_name
      base.extend module_name
    end
  end

  def self.units
    [:feet, :meters, :kms, :kilometers, :miles, :radians]
  end

  (units - [:radians]).each do |unit_type|
    define_singleton_method "#{unit_type}_to" do |unit, number = 0|
      return 0 if number <= 0        
      unit = normalized(unit)
      
      converter = GeoUnits::Maps::Meters
      from = converter.from_unit[unit_type]
      to = converter.to_unit[unit]

      m = number * from * to
    end
  end

  def self.radians_to unit, number, lat = 0
    unit = normalized(unit)
    # factor = GeoUnits::Converter::Units.units_per_longitude_degree(lat, unit)
    # puts "factor: #{factor} - #{unit}"
    (GeoUnits::Maps::Earth.distance_per_latitude_degree[unit] * number.to_f) 
  end

  module ClassMethods
    def normalized unit = :km
      unit = key(unit)
      return :feet if feet_unit.include? unit
      return :meters if meters_unit.include? unit
      return :kilometers if kms_unit.include? unit
      return :miles if miles_unit.include? unit
      return :radians if radins_unit.include? unit

      raise ArgumentError, "Normalize unit error, unit key: #{unit}"
    end

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

