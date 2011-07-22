module GeoUnits
  module Maps
    autoload_modules :Earth, :Meters

    def self.include(base)
      base.send :include, Earth
      base.send :include, Meters
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
