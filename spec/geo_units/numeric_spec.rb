require 'spec_helper'

# - www.movable-type.co.uk/scripts/latlong.html
describe Array do
  # deg, format, dp      
  describe '#to_dms' do
    it 'should convert [58.3, 4] to string of dms format' do
      dms_arr = [58.3, 4].to_dms
      puts dms_arr.inspect
    end
  end
end
