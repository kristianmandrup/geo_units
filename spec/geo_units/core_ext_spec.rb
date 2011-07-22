require 'spec_helper'

describe GeoUnits do
  describe 'Core extensions' do

    describe Numeric do
      describe '#miles_to' do
        it 'should convert meters to kms' do
          100.meters_to(:kms).should == 0.1
        end
      end

      describe '#miles_to' do
        it 'should convert miles to kms' do
          2.miles_to(:kms).should be_within(0.2).of 3.21
        end
      end

      describe '#feet_to' do
        it 'should convert feet to kms' do
          2.feet_to(:kms).should be_within(0.5).of (2 * 3.28 * 0.001)
        end
      end

      describe '#to_radians' do
        it 'should convert degrees to radians' do
          1.to_rad.should be_within(0.002).of 0.017
          1.to_radians.should be_within(0.002).of 0.017
          1.deg_to_rad.should be_within(0.002).of 0.017
          1.degrees_to_rad.should be_within(0.002).of 0.017
        end
      end
    end

    describe String do
      describe '#parse_dms' do
        it 'should raise error if no valid compass direction' do
          lambda { "58 18 00 X".parse_dms }.should raise_error
        end

        it 'should raise error if invalid format and set to raise' do
          lambda { "5.8 E".parse_dms }.should raise_error
        end

        it 'should parse valid format' do
          "58 E".parse_dms.should == 58.0
        end
      end
    end

    describe Array do
      describe '#to_dms' do
        it 'should convert' do
        end
      end

      describe '#parse_dms' do
        it 'should raise error if no valid compass direction' do
          lambda { ["15 18 00 X", "53 N"].parse_dms }.should raise_error
        end

        it 'should parse valid format' do
          ["58 E", "32 N"].parse_dms.should == [58.0, 32.0]
        end

        it 'should parse valid but reverse format' do
          ["32 N", "58 E"].parse_dms.should == [58.0, 32.0]
        end
      end
    end
  end
end
