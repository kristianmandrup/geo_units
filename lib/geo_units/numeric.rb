module GeoUnits
  module Numeric
    autoload_modules :Normalizer, :Dms, :from => 'geo_units'
    
    def to_lat 
      normalize_lat
    end

    def to_lng 
      normalize_lng
    end

    def is_between? lower, upper
      (lower..upper).cover? self
    end
      
    # Converts numeric degrees to radians
    def to_rad
      self * Math::PI / 180
    end
    alias_method :to_radians, :to_rad
    alias_method :as_rad,     :to_rad
    alias_method :as_radians, :to_rad
    alias_method :in_rad,     :to_rad
    alias_method :in_radians, :to_rad


    # Converts radians to numeric (signed) degrees
    # latitude (north to south) from equator +90 up then -90 down (equator again) = 180 then 180 for south = 360 total 
    # longitude (west to east)  east +180, west -180 = 360 total
    def to_deg
      self * 180 / Math::PI
    end

    alias_method :to_degrees, :to_deg
    alias_method :as_deg,     :to_deg
    alias_method :as_degrees, :to_deg
    alias_method :in_deg,     :to_deg
    alias_method :in_degrees, :to_deg

   
    # Formats the significant digits of a number, using only fixed-point notation (no exponential)
    # 
    # @param   {Number} precision: Number of significant digits to appear in the returned string
    # @returns {String} A string representation of number which contains precision significant digits
    def to_precision precision
      self.round(precision).to_s
    end
    alias_method :to_fixed, :to_precision  
  end
end           
