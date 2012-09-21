module GeoUnits
  module Converter
    module Normalizer
      # all degrees between -180 and 180
      def normalize_lng deg
        case deg 
        when -360..-180
          deg % 180      
        when -180..0 
          -180 + (deg % 180) 
        when 0..180
          deg
        when 180..360
          deg % 180
        else
          raise ArgumentError, "Degrees #{deg} out of range, must be between -360 to 360"
        end
      end

      # all degrees between -90 and 90
      def normalize_lat deg
        case deg 
        when -360..-270
          deg % 90      
        when -270..-180
          90 - (deg % 90)
        when -180..-90
          - (deg % 90)
        when -90..0 
          -90 + (deg % 90) 
        when 0..90
          deg
        when 90..180 
          deg % 90
        when 180..270 
          - (deg % 90)
        when 270..360 
          - 90 + (deg % 90)
        else
          raise ArgumentError, "Degrees #{deg} out of range, must be between -360 to 360"    
        end 
      end

      def normalize_deg degrees, shift = 0
        (degrees + shift) % 360 
      end
      alias_method :normalize_degrees, :normalize_deg
      
      extend self     
    end
  end
end