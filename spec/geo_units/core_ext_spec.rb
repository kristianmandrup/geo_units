require 'spec_helper'

describe GeoUnits do
  describe 'Core extensions' do
    describe '#radians_to' do
      it 'should convert radians to kms' do
        2.radians_to(:kms).should be_within(0.5).of 111.17 * 2
      end
    end

    describe '#miles_to' do
      it 'should convert miles to kms' do
        2.miles_to(:kms).should be_within(0.2).of 3.21
      end
    end
  end
end