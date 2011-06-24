module GeoUnits
  module Maps
    def earth_radius_map
      {
      :miles      => 3963.1676, 
      :kilometers => 6378.135, 
      :meters     =>  6378135, 
      :feet       => 20925639.8 
      }
    end

    def earth_major_axis_radius_map 
      { 
      :miles      => 3963.19059, 
      :kilometers => 6378.137,
      :meters     => 6378137,
      :feet       => 20925646.36
      }
    end

    def earth_minor_axis_radius_map 
      { 
      :kilometers => 6356.7523142,
      :miles      => 3949.90276,
      :meters     => 6356752.3142,
      :feet       => 20855486.627
      }
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

    def meters_multiplier
      {
        :feet     => 0.305,
        :meters   => 1,
        :kms      => 6371,
        :miles    => 3959,
        :radians  => 111170 
      }
    end

    def meters_map
      {
       :feet    => 3.2808399,
       :meters  => 1,
       :kms     => 0.001,
       :miles   => 0.00062137,
       :radians => 0.00000899
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