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

    extend self
  end
end
