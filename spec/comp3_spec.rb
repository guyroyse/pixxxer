require 'pixxxer'

describe 'Comp3' do
    
  describe 'String.depixxxit' do
    
    before(:each) do
      define_pixxx_template(:foobar) \
        .add_field(:foo).as(:comp3).at_position(0).with_width(4)
      @sample = "\x00\x12\x34\x5D"
    end

    it 'parses a field and coerces it to a comp3' do
      depixxxed = @sample.depixxxit :foobar
      depixxxed[:foo].should be_a_kind_of(Integer)
      depixxxed[:foo].should == -12345
    end

    it 'parses a field and coerces it to a comp3 with decimal places' do
      define_pixxx_template(:foobar) \
        .add_field(:foo).as(:comp3).with_precision(2).at_position(0).with_width(4)
      depixxxed = @sample.depixxxit :foobar
      depixxxed[:foo].should be_a_kind_of(Float)
      depixxxed[:foo].should == -123.45
    end

    it 'coerces invalid comp3s to nil' do
      depixxxed = "123\xa0".depixxxit :foobar
      depixxxed[:foo].should == nil
    end

  end

  describe 'Hash.pixxxit' do

    before(:each) do
      @sample = {
        :f => -1234.56
      }
    end

    it 'builds a string coerced from a comp3 with a width that is too big' do
      define_pixxx_template(:foobar) \
        .add_field(:f).as(:comp3).with_width(6).with_precision(2)
      @sample.pixxxit(:foobar).should == "\00\x00\x01\x23\x45\x6D"
    end

    it 'builds a string coerced from a comp3 with a width that is too small' do
      define_pixxx_template(:foobar) \
        .add_field(:f).as(:comp3).with_width(2).with_precision(2)
      @sample.pixxxit(:foobar).should == "\x45\x6D"
    end

    it 'builds a string coerced from a comp3 with a width that is just right' do
      define_pixxx_template(:foobar) \
        .add_field(:f).as(:comp3).with_width(4).with_precision(2)
      @sample.pixxxit(:foobar).should == "\x01\x23\x45\x6D"
    end

    it 'builds a string coerced from a comp3 with a precision that is too big' do
      define_pixxx_template(:foobar) \
        .add_field(:f).as(:comp3).with_width(6).with_precision(3)
      @sample.pixxxit(:foobar).should == "\00\x00\x12\x34\x56\x0D"
    end

    it 'builds a string coerced from a comp3 with a precision that is too small' do
      define_pixxx_template(:foobar) \
        .add_field(:f).as(:comp3).with_width(6).with_precision(1)
      @sample.pixxxit(:foobar).should == "\00\x00\x00\x12\x34\x5D"
    end

    it 'builds a string coerced from a comp3 and defaults the precision to zero' do
      define_pixxx_template(:foobar).add_field(:f).as(:comp3).with_width(6)
      @sample.pixxxit(:foobar).should == "\00\x00\x00\x01\x23\x4D"
    end

    it 'builds an empty string when value is not a number' do
      define_pixxx_template(:foobar).add_field(:noncomp3).as(:comp3)
      { :noncomp3 => 'abcde' }.pixxxit(:foobar).should == ''
    end

  end

end
