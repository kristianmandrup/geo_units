module GeoUnits
  module Converter
    autoload_modules :Normalizer, :Dms, :Units

    include Normalizer

    # Convert numeric degrees to deg/min/sec latitude (suffixed with N/S)
    # 
    # @param   {Number} deg: Degrees
    # @param   {String} [format=dms]: Return value as 'd', 'dm', 'dms'
    # @param   {Number} [dp=0|2|4]: No of decimal places to use - default 0 for dms, 2 for dm, 4 for d
    # @returns {String} Deg/min/seconds

    def to_lat deg, format = :dms, dp = 0
      deg = deg.normalize_lat
      _lat = Dms.to_dms deg, format, dp
      _lat == '' ? '' : _lat[1..-1] + (deg<0 ? 'S' : 'N')  # knock off initial '0' for lat!
    end

    # Convert numeric degrees to deg/min/sec longitude (suffixed with E/W)
    # 
    # @param   {Number} deg: Degrees
    # @param   {String} [format=dms]: Return value as 'd', 'dm', 'dms'
    # @param   {Number} [dp=0|2|4]: No of decimal places to use - default 0 for dms, 2 for dm, 4 for d
    # @returns {String} Deg/min/seconds

    def to_lon deg, format = :dms, dp = 0
      deg = deg.normalize_lng
      lon = Dms.to_dms deg, format, dp
      lon == '' ? '' : lon + (deg<0 ? 'W' : 'E')
    end


    # Convert numeric degrees to deg/min/sec as a bearing (0º..360º)
    # 
    # @param   {Number} deg: Degrees
    # @param   {String} [format=dms]: Return value as 'd', 'dm', 'dms'
    # @param   {Number} [dp=0|2|4]: No of decimal places to use - default 0 for dms, 2 for dm, 4 for d
    # @returns {String} Deg/min/seconds

    def to_brng deg, format = :dms, dp = 0
      deg = (deg.to_f + 360) % 360  # normalise -ve values to 180º..360º
      brng = Dms.to_dms deg, format, dp
      brng.gsub /360/, '0'  # just in case rounding took us up to 360º!
    end

    include NumericCheckExt # from sugar-high/numeric

    # Converts numeric degrees to radians
    def to_rad degrees
      degrees * Math::PI / 180
    end
    alias_method :to_radians, :to_rad
    alias_method :as_rad,     :to_rad
    alias_method :as_radians, :to_rad
    alias_method :in_rad,     :to_rad
    alias_method :in_radians, :to_rad


    # Converts radians to numeric (signed) degrees
    # latitude (north to south) from equator +90 up then -90 down (equator again) = 180 then 180 for south = 360 total 
    # longitude (west to east)  east +180, west -180 = 360 total
    def to_deg radians
      radians * 180 / Math::PI
    end

    alias_method :to_degrees, :to_deg
    alias_method :as_deg,     :to_deg
    alias_method :as_degrees, :to_deg
    alias_method :in_deg,     :to_deg
    alias_method :in_degrees, :to_deg

    extend self
  end
  extend self
end
