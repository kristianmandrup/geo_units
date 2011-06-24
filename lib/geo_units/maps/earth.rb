module GeoUnits
  module Maps
    module Earth
      def radius
        {
        :miles      => 3963.1676, 
        :kilometers => 6378.135, 
        :meters     =>  6378135, 
        :feet       => 20925639.8 
        }
      end

      def major_axis_radius 
        { 
        :miles      => 3963.19059, 
        :kilometers => 6378.137,
        :meters     => 6378137,
        :feet       => 20925646.36
        }
      end

      def minor_axis_radius 
        { 
        :kilometers => 6356.7523142,
        :miles      => 3949.90276,
        :meters     => 6356752.3142,
        :feet       => 20855486.627
        }
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
      
      extend self
    end
  end
end