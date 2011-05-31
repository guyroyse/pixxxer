require 'pixxxer'

describe 'Integer' do
	
	describe 'String.depixxxit' do

		it 'parses a field and coerces it to a integer' do
			define_pixxx_template(:foobar)
				.add_field(:foo).as_integer.at_position(0).with_width(5)
			depixxxed = '12345'.depixxxit :foobar
			depixxxed[:foo].should be_a_kind_of(Integer)
		end

	end

	describe 'Hash.pixxxit' do

		before(:each) do
			@sample = {
				:integer => 12345, 
			}
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

	end

end

