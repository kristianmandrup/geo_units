module GeoUnits
  module Converter
    module Units
      def degrees_to_radians(degrees)   
        degrees.to_f * GeoUnits::Constants.radians_per_degree
      end

      def units_sphere_multiplier(units)
        units = GeoUnits.key units
        GeoUnits::Mapsearth_radius_map[units]
      end

      def units_per_latitude_degree(units)
        units = GeoUnits.key units
        GeoUnits::Maps.radian_multiplier[units]
      end

      def pi_div_rad
        GeoUnits::Constants.pi_div_rad
      end

      def units_per_longitude_degree(lat, units)
        miles_per_longitude_degree = (lat * Math.cos(lat * pi_div_rad)).abs 
        units = GeoUnits.key units
        miles_per_longitude_degree.miles_to(units)
      end 
  
      def earth_radius units
        units = GeoUnits.key units
        GeoUnits::Maps.earth_radius_map[units]
      end
      
      def radians_ratio units
        units = GeoUnits.key units
        radians_per_degree * earth_radius(units)
      end
  
      extend self       
    end
  end
end