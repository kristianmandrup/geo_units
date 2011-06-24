module GeoUnits
  module Constants
    def radians_per_degree
      Math::PI / 180.0
    end

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
  
    extend self      
  end
end