module GeoUnits
  module Numeric
    def to_dms format = :dms, dp = nil
      GeoUnits::DmsConverter.to_dms self, format, dp
    end

    def to_lat_dms format = :dms, dp = nil
      GeoUnits::Converter.to_lat self, format, dp
    end

    def to_lon_dms format = :dms, dp = nil
      GeoUnits::Converter.to_lon self, format, dp
    end
    alias_method :to_lng_dms, :to_lon_dms
  end
end