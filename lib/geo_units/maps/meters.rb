module GeoUnits
  module Maps
    module Meters
      def to_unit_multiplier units = :meters
        from_unit[units]
      end

      def from_unit
        {
          :feet       => 0.3048,
          :meters     => 1,
          :kilometers => 1000,
          :miles      => 1609.344
        }
      end

      def to_unit
        {
         :feet        => 3.2808399,
         :meters      => 1,
         :kilometers  => 0.001,
         :miles       => 0.00062137
        }
      end

      extend self
    end
  end
end
