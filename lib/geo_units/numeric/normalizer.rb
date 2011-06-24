module GeoUnits
  module Numeric
    module Normalizer
      # all degrees between -180 and 180
      def normalize_lng
        case self 
        when -360, 0, 360
          0
        when -360..-180
          self % 180      
        when -180..0 
          -180 + (self % 180) 
        when 0..180
          self
        when 180..360
          self % 180
        else
          return (self % 360).normalize_lng if self > 360
          return (360 - (self % 360)).normalize_lng if self < -360
          raise ArgumentError, "Degrees #{self} out of range"
        end
      end

      # all degrees between -90 and 90
      def normalize_lat
        case self 
        when -360, 0, 360
          0
        when -180, 180
          0
        when -360..-270
          self % 90      
        when -270..-180
          90 - (self % 90)
        when -180..-90
          - (self % 90)
        when -90..0 
          -90 + (self % 90) 
        when 0..90
          self
        when 90..180 
          self % 90
        when 180..270 
          - (self % 90)
        when 270..360 
          - 90 + (self % 90)
        else
          return (self % 360).normalize_lat if self > 360
          return (360 - (self % 360)).normalize_lat if self < -360
          raise ArgumentError, "Degrees #{self} out of range"      
        end
      end

      def normalize_deg shift = 0
        (self + shift) % 360 
      end
      alias_method :normalize_degrees, :normalize_deg
      
      extend self
    end
  end
end