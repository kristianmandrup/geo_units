require 'spec_helper'

# - www.movable-type.co.uk/scripts/latlong.html
describe Array do
  # deg, format, dp
  describe '#to_dms' do
    let (:dms_arr) { [58.3, 4].to_dms }

    it 'should convert [58.3, 4] to string of dms format' do
      dms_arr.should match /58.*18.*, 04.*00/
    end
  end

  describe '#to_dms :reverse' do
    let (:dms_arr) { [58.3, 4].to_dms :lat_lng}

    it 'should convert [58.3, 4] to string of dms format' do
      dms_arr.should match /04.*00.*N, 058.*18.*E/
    end
  end
end
