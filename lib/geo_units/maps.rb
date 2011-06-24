module GeoUnits
  module Maps
    autoload_modules :Earth, :Meters, :from => 'geo_units'

    def self.include(base)
      base.send :include, Earth
      base.send :include, Meters
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

    def precision
      {
        :feet => 0,
        :meters => 2,
        :kms => 4,
        :miles => 4,
        :radians => 4
      }
    end 
  
    extend self
  end
end