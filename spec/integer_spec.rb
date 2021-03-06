require 'pixxxer'

describe 'Integer' do

  describe 'String.depixxxit' do

    before(:each) do
      define_pixxx_template(:foobar) \
        .add_field(:foo).as(:integer).at_position(0).with_width(5)
    end
      
    it 'parses a field and coerces it to a integer' do
      depixxxed = '12345'.depixxxit :foobar
      depixxxed[:foo].should == 12345
    end

    it 'coerces invalid integers to nil' do
      depixxxed = 'abcde'.depixxxit :foobar
      depixxxed[:foo].should == nil
    end

  end

  describe 'Hash.pixxxit' do

    before(:each) do
      @sample = {
        :integer => 12345, 
      }
    end

    it 'builds a string coerced from an integer' do
      define_pixxx_template(:foobar).add_field(:integer).as(:integer)
      @sample.pixxxit(:foobar).should == '12345'
    end
    
    it 'builds a string coerced from an integer with a width that is too big' do
      define_pixxx_template(:foobar).add_field(:integer).as(:integer).with_width(10)
      @sample.pixxxit(:foobar).should == '0000012345'
    end

    it 'builds a string coerced from an integer with a width that is too small' do
      define_pixxx_template(:foobar).add_field(:integer).as(:integer).with_width(2)
      @sample.pixxxit(:foobar).should == '45'
    end

    it 'builds a string coerced from an integer with a width that is just right' do
      define_pixxx_template(:foobar).add_field(:integer).as(:integer).with_width(5)
      @sample.pixxxit(:foobar).should == '12345'
    end

    it 'builds an empty string when value is not a number' do
      define_pixxx_template(:foobar).add_field(:noninteger).as(:integer)
      { :noninteger => 'abcde' }.pixxxit(:foobar).should == ''
    end

  end

end

