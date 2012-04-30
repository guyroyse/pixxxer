require 'pixxxer'

describe 'Boolean' do

  describe 'String.depixxxit' do

    it 'parses a field and coerces it to a boolean' do
      define_pixxx_template(:foobar) \
        .add_field(:true).as(:boolean).at_position(0).with_width(1).and \
        .add_field(:false).as(:boolean).at_position(1).with_width(1)
      depixxxed = "YN".depixxxit :foobar
      depixxxed[:true].should be_true
      depixxxed[:false].should be_false
    end

    it 'parses a field with an invalid value and coerces it to a boolean' do
      define_pixxx_template("foobar") \
        .add_field(:false).as(:boolean)
      depixxxed = 'foo'.depixxxit :foobar
      depixxxed[:false].should be_false
    end

    it 'parses a field and coerces it to a boolean with values for true and false defined on the template' do
      define_pixxx_template(:foobar).true_is('T').false_is('F') \
        .add_field(:true).as(:boolean).at_position(0).with_width(1).and \
        .add_field(:false).as(:boolean).at_position(1).with_width(1)
      depixxxed = "TF".depixxxit :foobar
      depixxxed[:true].should be_true
      depixxxed[:false].should be_false
    end

    describe 'values for true and false defined on the field' do
 
      before(:each) do
        define_pixxx_template(:foobar) \
          .add_field(:value).as(:boolean).with_width(1).true_is('T').false_is('F')
      end

      it 'parses a field and coerces it to a boolean for a true value' do
        depixxxed = "T".depixxxit :foobar
        depixxxed[:value].should be_true
      end

      it 'parses a field and coerces it to a boolean for a false value' do
        depixxxed = "F".depixxxit :foobar
        depixxxed[:value].should be_false
      end

    end

    describe 'values for true and false defined on the field and the tempalte' do
    
      before(:each) do
        define_pixxx_template(:foobar).true_is('1').false_is('0') \
          .add_field(:value).as(:boolean).with_width(1).true_is('T').false_is('F')
      end
    
      it 'parses a field and coerces it to a boolean for a true value' do
        depixxxed = "T".depixxxit :foobar
        depixxxed[:value].should be_true
      end

      it 'parses a field and coerces it to a boolean for a false value' do
        depixxxed = "F".depixxxit :foobar
        depixxxed[:value].should be_false
      end
    
    end

  end

  describe 'Hash.pixxxit' do

    before(:each) do
      @sample = {
        :true => true,
        :true2 => true,
        :false => false,
        :false2 => false,
        :invalid => 'foo',
        :nil => nil
      }
    end

    it 'builds a string coerced from a Boolean with a true value' do
      define_pixxx_template(:foobar) \
        .add_field(:true).as(:boolean)
      @sample.pixxxit(:foobar).should == 'Y'
    end

    it 'builds a string coerced from a Boolean with a false value' do
      define_pixxx_template(:foobar) \
        .add_field(:false).as(:boolean)
      @sample.pixxxit(:foobar).should == 'N'
    end

    it 'builds a string coerced from a Boolean with an invalid value' do
      define_pixxx_template(:foobar) \
        .add_field(:invalid).as(:boolean)
      @sample.pixxxit(:foobar).should == 'N'
    end

    it 'builds a string coerced from a Boolean that is nil' do
      define_pixxx_template(:foobar) \
        .add_field(:nil).as(:boolean)
      @sample.pixxxit(:foobar).should == 'N'
    end

    it 'builds a string coerced from a Boolean with a true value and a specified true string' do
      define_pixxx_template(:foobar) \
        .add_field(:true).as(:boolean).true_is('T')
      @sample.pixxxit(:foobar).should == 'T'
    end

    it 'builds a string coerced from a Boolean with a false value and a specified false string' do
      define_pixxx_template(:foobar) \
        .add_field(:false).as(:boolean).false_is('F')
      @sample.pixxxit(:foobar).should == 'F'
    end

    it 'builds a string coerced from Boolean with default Boolean value for fields where the Boolean values are not specified' do
      define_pixxx_template(:foobar) \
        .add_field(:true).at_position(0).as(:boolean).and \
        .add_field(:false).at_position(1).as(:boolean).and \
        .add_field(:true2).at_position(2).as(:boolean).true_is('T').and \
        .add_field(:false2).at_position(3).as(:boolean).false_is('F')
      @sample.pixxxit(:foobar).should == 'YNTF'
    end

    it 'builds a string coerced from Boolean values with different fields having different value strings' do
      define_pixxx_template(:foobar) \
        .add_field(:true).at_position(0).as(:boolean).true_is('1').and \
        .add_field(:true2).at_position(1).as(:boolean).true_is('T')
      @sample.pixxxit(:foobar).should == '1T'
    end

    it 'builds a string coerced from a Boolen with a true value and a true string specified at the template level' do
      define_pixxx_template(:foobar).true_is('T') \
        .add_field(:true).as(:boolean)
      @sample.pixxxit(:foobar).should == 'T'
    end

    it 'builds a string coerced from a Boolen with a false value and a false string specified at the template level' do
      define_pixxx_template(:foobar).false_is('F') \
        .add_field(:false).as(:boolean)
      @sample.pixxxit(:foobar).should == 'F'
    end

    it 'builds a string coerced from a Boolean with a true value and a true string specified at the template and field levels' do
      define_pixxx_template(:foobar).true_is('T') \
        .add_field(:true).as(:boolean).true_is('1')
      @sample.pixxxit(:foobar).should == '1'
    end

    it 'builds a string coerced from a Boolean with a false value and a false string specified at the template and field levels' do
      define_pixxx_template(:foobar).true_is('F') \
        .add_field(:true).as(:boolean).true_is('0')
      @sample.pixxxit(:foobar).should == '0'
    end

    it 'builds a string coerced from Booleans with strings sepcified at the template and field levels' do
      define_pixxx_template(:foobar).true_is('T').false_is('F') \
        .add_field(:true).at_position(0).as(:boolean).and \
        .add_field(:false).at_position(1).as(:boolean).and \
        .add_field(:true2).at_position(2).as(:boolean).true_is('1').and \
        .add_field(:false2).at_position(3).as(:boolean).false_is('0')
      @sample.pixxxit(:foobar).should == 'TF10'
    end

  end

end

