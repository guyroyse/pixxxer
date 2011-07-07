require 'pixxxer'

describe 'comp3' do

	# add tests for invalid values
	
	describe 'String.depixxxit' do

		it 'parses a field and coerces it to ebcdic_char' do
			define_pixxx_template(:foobar) \
				.add_field(:foo).as(:ebcdic_char).at_position(0).with_width(6)
			depixxxed = "\x40\x82\x81\xa9\xf0\xf1".depixxxit :foobar
			depixxxed[:foo].should be_a_kind_of(String)
		end
	end

	describe 'Hash.pixxxit' do

		before(:each) do
			@sample = {
				:field1 => "baz01"
			}
		end

		it 'builds a string coerced from ebcdic_char' do
			define_pixxx_template(:foobar) \
				.add_field(:field1).as(:ebcdic_char)
			@sample.pixxxit(:foobar).should == "\x82\x81\xa9\xf0\xf1"
		end
		
		it 'builds a string coerced from ebcdic_char with a width that is too big' do
			define_pixxx_template(:foobar) \
				.add_field(:field1).as(:ebcdic_char).with_width(7)
			@sample.pixxxit(:foobar).should == "\x40\x40\x82\x81\xa9\xf0\xf1"
		end

		it 'builds a string coerced from ebcdic_char with a width that is too small' do
			define_pixxx_template(:foobar) \
				.add_field(:field1).as(:ebcdic_char).with_width(2)
			@sample.pixxxit(:foobar).should == "\x82\x81"
		end

		it 'builds a string coerced from ebcdic_char with a width that is just right' do
			define_pixxx_template(:foobar) \
				.add_field(:field1).as(:ebcdic_char).with_width(5)
			@sample.pixxxit(:foobar).should == "\x82\x81\xa9\xf0\xf1"
		end

	end

end
