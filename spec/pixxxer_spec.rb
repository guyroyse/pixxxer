require 'pixxxer'

describe 'Pixxxer' do

  describe 'pixxxit' do

		before(:each) do
			@sample = {:foo => 'abcde', :bar => 12345, :baz => 123.45}
		end

		it 'builds a string from one field' do
			define_pixxx_template(:foobar)
				.add_field(:foo)
			@sample.pixxxit(:foobar).should == 'abcde'
		end

		it 'builds a string with a width that is too small' do
			define_pixxx_template(:foobar)
				.add_field(:foo).with_width(2)
			@sample.pixxxit(:foobar).should == 'ab'
		end

		it 'builds a string with a width that is too big' do
			define_pixxx_template(:foobar)
				.add_field(:foo).with_width(10)
			@sample.pixxxit(:foobar).should == 'abcde     '	
		end

		it 'builds a string with a width that is just right' do
			define_pixxx_template(:foobar)
				.add_field(:foo).with_width(5)
			@sample.pixxxit(:foobar).should == 'abcde'	
		end

		it 'builds a string with a position' do
			define_pixxx_template(:foobar)
				.add_field(:foo).at_position(5)
			@sample.pixxxit(:foobar).should == '     abcde'
		end

    it 'builds a string with a width and a position' do
			define_pixxx_template(:foobar)
				.add_field(:foo).with_width(2).at_position(5)
			@sample.pixxxit(:foobar).should == '     ab'
		end

		it 'builds a string coerced from an integer' do
			define_pixxx_template(:foobar)
				.add_field(:bar).as_integer
			@sample.pixxxit(:foobar).should == '12345'
		end
		
		it 'builds a string coerced from an integer with a width that is too big' do
			define_pixxx_template(:foobar)
				.add_field(:bar).as_integer.with_width(10)
			@sample.pixxxit(:foobar).should == '0000012345'
		end

		it 'builds a string coerced from an integer with a width that is too small' do
			define_pixxx_template(:foobar)
				.add_field(:bar).as_integer.with_width(2)
			@sample.pixxxit(:foobar).should == '45'
		end

		it 'builds a string coerced from an integer with a width that is just right' do
			define_pixxx_template(:foobar)
				.add_field(:bar).as_integer.with_width(5)
			@sample.pixxxit(:foobar).should == '12345'
		end

		it 'builds a string coerced from a float with a width that is too big' do
			define_pixxx_template(:foobar)
				.add_field(:baz).as_float.with_width(10).with_precision(2)
			@sample.pixxxit(:foobar).should == '0000012345'
		end

		it 'builds a string coerced from a float with a width that is too small' do
			define_pixxx_template(:foobar)
				.add_field(:baz).as_float.with_width(3).with_precision(2)
			@sample.pixxxit(:foobar).should == '345'
		end

		it 'builds a string coerced from a float with a width that is just right' do
			define_pixxx_template(:foobar)
				.add_field(:baz).as_float.with_width(5).with_precision(2)
			@sample.pixxxit(:foobar).should == '12345'
		end

		it 'builds a string coerced from a float with a precision that is too big' do
			define_pixxx_template(:foobar)
				.add_field(:baz).as_float.with_width(10).with_precision(3)
			@sample.pixxxit(:foobar).should == '0000123450'
		end

		it 'builds a string from multiple fields' do
			define_pixxx_template(:foobar)
				.add_field(:foo).as_string.at_position(0).with_width(5).and
				.add_field(:bar).as_integer.at_position(5).with_width(5)
			@sample.pixxxit(:foobar).should == 'abcde12345'
		end

  end

  describe 'depixxxit' do

		before(:each) do
			@sample = '12345abcde'
		end

		it 'parses one big field from a string' do
			define_pixxx_template(:foobar)
				.add_field(:foo)
			depixxxed = @sample.depixxxit :foobar
			depixxxed[:foo].should == '12345abcde'
		end

		it 'parses a field with a width' do
			define_pixxx_template(:foobar)
				.add_field(:foo).with_width(5)
			depixxxed = @sample.depixxxit :foobar
			depixxxed[:foo].should == '12345'
		end

		it 'parses a field with a starting position' do
			define_pixxx_template(:foobar)
				.add_field(:foo).at_position(5)
			depixxxed = @sample.depixxxit :foobar
			depixxxed[:foo].should == 'abcde'
		end

		it 'parses a field with a starting position and a width' do
			define_pixxx_template(:foobar)
				.add_field(:foo).at_position(4).with_width(2)
			depixxxed = @sample.depixxxit :foobar
			depixxxed[:foo].should == '5a'
		end

		it 'parses a field and coerces it to a string' do
			define_pixxx_template(:foobar)
				.add_field(:foo).as_string.at_position(5).with_width(5)
			depixxxed = @sample.depixxxit :foobar
			depixxxed[:foo].should be_a_kind_of(String)
		end

		it 'parses a field and coerces it to a integer' do
			define_pixxx_template(:foobar)
				.add_field(:foo).as_integer.at_position(0).with_width(5)
			depixxxed = @sample.depixxxit :foobar
			depixxxed[:foo].should be_a_kind_of(Integer)
		end

		it 'parses a field and coerces it to a float' do
			define_pixxx_template(:foobar)
				.add_field(:foo).as_float.at_position(0).with_width(5)
			depixxxed = @sample.depixxxit :foobar
			depixxxed[:foo].should be_a_kind_of(Float)
		end

		it 'parses a field and coerces it to a float with decimal places' do
			define_pixxx_template(:foobar)
				.add_field(:foo).as_float.with_precision(2).at_position(0).with_width(5)
			depixxxed = @sample.depixxxit :foobar
			depixxxed[:foo].should be_a_kind_of(Float)
			depixxxed[:foo].should == 123.45
		end

		it 'parses multiple fields' do
			define_pixxx_template(:foobar)
				.add_field(:foo).at_position(0).with_width(5).as_integer.and
				.add_field(:bar).at_position(5).with_width(5)
			depixxxed = @sample.depixxxit :foobar
			depixxxed[:foo].should == 12345
			depixxxed[:bar].should == 'abcde'
		end

		it 'parses with multiple templates' do
			define_pixxx_template(:foobar)
				.add_field(:foo).at_position(0).with_width(5).as_integer
			define_pixxx_template(:bazqux)
				.add_field(:foo).at_position(5).with_width(5)
			foobar_depixxxed = @sample.depixxxit :foobar
			bazqux_depixxxed = @sample.depixxxit :bazqux
			foobar_depixxxed[:foo].should == 12345
			bazqux_depixxxed[:foo].should == 'abcde'
		end

  end

end
