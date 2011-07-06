require 'pixxxer'

describe 'String' do

	describe 'String.depixxxit' do
	
		before(:each) do
			@sample = '12345abcde'
		end
		
		it 'parses a field and coerces it to a string' do
			define_pixxx_template(:foobar).add_field(:foo).as(:string).at_position(5).with_width(5)
			depixxxed = @sample.depixxxit :foobar
			depixxxed[:foo].should be_a_kind_of(String)
		end

	end

	describe 'Hash.pixxxit' do
	
		before(:each) do
			@sample = {
				:string => 'abcde', 
			}
		end
		
		it 'builds a string from one field' do
			define_pixxx_template(:foobar).add_field(:string)
			@sample.pixxxit(:foobar).should == 'abcde'
		end

		it 'builds a string with a width that is too small' do
			define_pixxx_template(:foobar).add_field(:string).with_width(2)
			@sample.pixxxit(:foobar).should == 'ab'
		end

		it 'builds a string with a width that is too big' do
			define_pixxx_template(:foobar).add_field(:string).with_width(10)
			@sample.pixxxit(:foobar).should == 'abcde     '	
		end

		it 'builds a string with a width that is just right' do
			define_pixxx_template(:foobar).add_field(:string).with_width(5)
			@sample.pixxxit(:foobar).should == 'abcde'	
		end

		it 'builds a string with a position' do
			define_pixxx_template(:foobar).add_field(:string).at_position(5)
			@sample.pixxxit(:foobar).should == '     abcde'
		end

		it 'builds a string with a width and a position' do
			define_pixxx_template(:foobar).add_field(:string).with_width(2).at_position(5)
			@sample.pixxxit(:foobar).should == '     ab'
		end

		it 'builds a string defined explicitly as a string' do
			define_pixxx_template(:foobar).add_field(:string).as(:string)
			@sample.pixxxit(:foobar).should == 'abcde'
		end

	end

end

