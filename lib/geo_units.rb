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

  def earth_radius_map
    {
    :miles      => 3963.1676, 
    :kilometers => 6378.135, 
    :meters     =>  6378135, 
    :feet       => 20925639.8 
    }
  end

  def earth_major_axis_radius_map 
    { 
    :miles      => 3963.19059, 
    :kilometers => 6378.137,
    :meters     => 6378137,
    :feet       => 20925646.36
    }
  end

  def earth_minor_axis_radius_map 
    { 
    :kilometers => 6356.7523142,
    :miles      => 3949.90276,
    :meters     => 6356752.3142,
    :feet       => 20855486.627
    }
  end
  
  def radians_per_degree
    Math::PI / 180.0
  end

  # Haversine Formula
  # Adapted from Geokit Gem
  # https://github.com/andre/geokit-gem.git
  # By: Andre Lewis
  def pi_div_rad 
    0.0174
  end

  def kms_per_mile 
    1.609
  end
  
  def meters_per_feet 
    3.2808399
  end

  def miles_per_latitude_degree 
    69.1
  end
  
  def kms_per_latitude_degree
    miles_per_latitude_degree * kms_per_mile
  end

  def latitude_degrees 
    earth_radius_map[:miles] / miles_per_latitude_degree
  end  

  def degrees_to_radians(degrees)   
    degrees.to_f * radians_per_degree
  end

  def units_sphere_multiplier(units)
    units = GeoUnits.key units
    earth_radius_map[units]
  end

  def units_per_latitude_degree(units)
    units = GeoUnits.key units
    GeoUnits.radian_multiplier[units]
  end

  def units_per_longitude_degree(lat, units)
    miles_per_longitude_degree = (latitude_degrees * Math.cos(lat * pi_div_rad)).abs 
    units = GeoUnits.key units
    case units
      when :feet
        miles_per_longitude_degree * kms_per_mile * 1000 * meters_per_feet
      when :meters
        miles_per_longitude_degree * kms_per_mile * 1000
      when :kms
        miles_per_longitude_degree * kms_per_mile
      when :miles
        miles_per_longitude_degree
    end
  end

  module ClassMethods
    def key unit = :km
      unit = unit.to_sym
      methods.grep(/_unit$/).each do |meth|
        return meth.to_s.chomp('_unit').to_sym if send(meth).include? unit
      end
      raise ArgumentError, "Unknown unit key: #{unit}"
    end

    def units
      [:feet, :meters, :kms, :miles, :radians]
    end

    def all_units
      [:miles, :mile, :kms, :km, :feet, :foot, :meter, :meters, :radians, :rad]
    end

    [:feet, :meters, :kms, :miles, :radians].each do |unit|
      class_eval %{
        def #{unit}_to unit, number = 0
          return 0 if number <= 0
          unit = key(unit)
          m = number / GeoUnits.meters_map[:#{unit}]
          m * meters_map[unit]
        end
      }
    end

    def earth_radius units
      units = GeoUnits.key units
      GeoUnits.earth_radius_map[units]
    end

    def radians_per_degree
      0.017453293  #  PI/180
    end    
        
    def radians_ratio units
      units = GeoUnits.key units
      radians_per_degree * earth_radius[units]
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

