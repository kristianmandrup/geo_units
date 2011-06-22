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

module GeoUnits
  autoload :Converter,      'geo_units/converter'
  autoload :DmsConverter,   'geo_units/dms_converter'
  autoload :NumericExt,     'geo_units/numeric_ext'

  module ClassMethods
    def key unit = :km
      unit = unit.to_sym
      methods.grep(/_unit/).each do |meth|
        return meth.to_s.chomp('_unit').to_sym if send(meth).include? unit
      end
      raise ArgumentError, "Unknown unit key: #{unit}"
    end

    def units
      [:feet, :meters, :kms, :miles, :radians]
    end

    [:feet, :meters, :kms, :miles, :radians].each do |unit|
      class_eval %{
        def #{unit}_to unit, number
          unit   = key(unit)
          meters = number / GeoUnits.meters_map[:#{unit}]
          meters * meters_map[unit]
        end
      }
    end

    def precision
      {
        :feet => 0,
        :meters => 2,
        :kms => 4,
        :miles => 4,
        :radians => 4
      }
    end

    # from mongoid-geo, as suggested by niedhui :)
    def radian_multiplier
      {
        :feet     => 364491.8,
        :meters   => 111170,
        :kms      => 111.17,
        :miles    => 69.407,
        :radians  => 1
      }
    end

    def meters_multiplier
      {
        :feet     => 0.305,
        :meters   => 1,
        :kms      => 6371,
        :miles    => 3959,
        :radians  => 111170 
      }
    end

    def meters_map
      {
       :feet    => 3.2808399,
       :meters  => 1,
       :kms     => 0.001,
       :miles   => 0.00062137,
       :radians => 0.00000899
      }
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

