require 'pixxxer'

describe 'String.pixxxit' do

	before(:each) do
		@sample = {
			:string => 'abcde', 
			:integer => 12345, 
			:float => 123.45,
			:true => true,
			:false => false
		}
	end

	it 'builds a string from one field' do
		define_pixxx_template(:foobar)
			.add_field(:string)
		@sample.pixxxit(:foobar).should == 'abcde'
	end

	it 'builds a string with a width that is too small' do
		define_pixxx_template(:foobar)
			.add_field(:string).with_width(2)
		@sample.pixxxit(:foobar).should == 'ab'
	end

	it 'builds a string with a width that is too big' do
		define_pixxx_template(:foobar)
			.add_field(:string).with_width(10)
		@sample.pixxxit(:foobar).should == 'abcde     '	
	end

	it 'builds a string with a width that is just right' do
		define_pixxx_template(:foobar)
			.add_field(:string).with_width(5)
		@sample.pixxxit(:foobar).should == 'abcde'	
	end

	it 'builds a string with a position' do
		define_pixxx_template(:foobar)
			.add_field(:string).at_position(5)
		@sample.pixxxit(:foobar).should == '     abcde'
	end

	it 'builds a string with a width and a position' do
		define_pixxx_template(:foobar)
			.add_field(:string).with_width(2).at_position(5)
		@sample.pixxxit(:foobar).should == '     ab'
	end

	it 'builds a string coerced from an integer' do
		define_pixxx_template(:foobar)
			.add_field(:integer).as_integer
		@sample.pixxxit(:foobar).should == '12345'
	end
	
	it 'builds a string coerced from an integer with a width that is too big' do
		define_pixxx_template(:foobar)
			.add_field(:integer).as_integer.with_width(10)
		@sample.pixxxit(:foobar).should == '0000012345'
	end

	it 'builds a string coerced from an integer with a width that is too small' do
		define_pixxx_template(:foobar)
			.add_field(:integer).as_integer.with_width(2)
		@sample.pixxxit(:foobar).should == '45'
	end

	it 'builds a string coerced from an integer with a width that is just right' do
		define_pixxx_template(:foobar)
			.add_field(:integer).as_integer.with_width(5)
		@sample.pixxxit(:foobar).should == '12345'
	end

	it 'builds a string coerced from a float with a width that is too big' do
		define_pixxx_template(:foobar)
			.add_field(:float).as_float.with_width(10).with_precision(2)
		@sample.pixxxit(:foobar).should == '0000012345'
	end

	it 'builds a string coerced from a float with a width that is too small' do
		define_pixxx_template(:foobar)
			.add_field(:float).as_float.with_width(3).with_precision(2)
		@sample.pixxxit(:foobar).should == '345'
	end

	it 'builds a string coerced from a float with a width that is just right' do
		define_pixxx_template(:foobar)
			.add_field(:float).as_float.with_width(5).with_precision(2)
		@sample.pixxxit(:foobar).should == '12345'
	end

	it 'builds a string coerced from a float with a precision that is too big' do
		define_pixxx_template(:foobar)
			.add_field(:float).as_float.with_width(10).with_precision(3)
		@sample.pixxxit(:foobar).should == '0000123450'
	end

	it 'builds a string coerced from a float with a precision that is too small' do
		define_pixxx_template(:foobar)
			.add_field(:float).as_float.with_width(10).with_precision(1)
		@sample.pixxxit(:foobar).should == '0000001234'
	end

	it 'builds a string coerced from a float and defaults the precision to zero' do
		define_pixxx_template(:foobar)
			.add_field(:float).as_float.with_width(5)
		@sample.pixxxit(:foobar).should == '00123'
	end

	it 'builds a string coerced from a Boolean with a true value' do
		define_pixxx_template(:foobar)
			.add_field(:true).as_boolean
		@sample.pixxxit(:foobar).should == 'Y'
	end

	it 'builds a string coerced from a Boolean with a false value' do
		define_pixxx_template(:foobar)
			.add_field(:false).as_boolean
		@sample.pixxxit(:foobar).should == 'N'
	end

	it 'builds a string coerced from a Boolean with a true value and a specified true string' do
		define_pixxx_template(:foobar)
			.add_field(:true).as_boolean.true_is('T')
		@sample.pixxxit(:foobar).should == 'T'
	end

	it 'builds a string coerced from a Boolean with a false value and a specified false string' do
		define_pixxx_template(:foobar)
			.add_field(:false).as_boolean.false_is('F')
		@sample.pixxxit(:foobar).should == 'F'
	end

	it 'builds a string coerced from a Boolen with a true value and a true string specified at the template level' do
		define_pixxx_template(:foobar).true_is('T')
			.add_field(:true).as_boolean
		@sample.pixxxit(:foobar).should == 'T'
	end

	it 'builds a string coerced from a Boolen with a false value and a false string specified at the template level' do
		define_pixxx_template(:foobar).false_is('F')
			.add_field(:false).as_boolean
		@sample.pixxxit(:foobar).should == 'F'
	end

	it 'builds a string from multiple fields' do
		define_pixxx_template(:foobar)
			.add_field(:string).as_string.at_position(0).with_width(5).and
			.add_field(:integer).as_integer.at_position(5).with_width(5).and
			.add_field(:float).as_float.at_position(10).with_width(5).with_precision(2)
		@sample.pixxxit(:foobar).should == 'abcde1234512345'
	end

end
