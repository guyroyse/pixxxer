require 'pixxxer'

describe 'comp3' do

	# add tests for invalid values
	
	describe 'String.depixxxit' do

		it 'parses a field and coerces it to comp3' do
			define_pixxx_template(:foobar) \
				.add_field(:foo).as(:comp3).at_position(0).with_width(5)
			depixxxed = "\x12\x34\x5D".depixxxit :foobar
			depixxxed[:foo].should be_a_kind_of(Integer)
		end

	end

	describe 'Hash.pixxxit' do

		before(:each) do
			@sample = {
				:field1 => -12345
			}
		end

		it 'builds a string coerced from comp3' do
			define_pixxx_template(:foobar) \
				.add_field(:field1).as(:comp3)
			@sample.pixxxit(:foobar).should == "\x12\x34\x5D"
		end
		
		it 'builds a string coerced from comp3 with a width that is too big' do
			define_pixxx_template(:foobar) \
				.add_field(:field1).as(:comp3).with_width(5)
			@sample.pixxxit(:foobar).should == "\x00\x00\x12\x34\x5D"
		end

		it 'builds a string coerced from comp3 with a width that is too small' do
			define_pixxx_template(:foobar) \
				.add_field(:field1).as(:comp3).with_width(2)
			@sample.pixxxit(:foobar).should == "\x34\x5D"
		end

		it 'builds a string coerced from comp3 with a width that is just right' do
			define_pixxx_template(:foobar) \
				.add_field(:field1).as(:comp3).with_width(3)
			@sample.pixxxit(:foobar).should == "\x12\x34\x5D"
		end

	end

end
