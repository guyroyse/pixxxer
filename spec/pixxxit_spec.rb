require 'pixxxer'

describe 'Hash.pixxxit' do

	before(:each) do
		@sample = {
			:string => 'abcde', 
			:integer => 12345, 
			:float => 123.45,
			:true => true,
		}
	end

	it 'builds a string from multiple fields' do
		define_pixxx_template(:foobar) \
			.add_field(:string).as(:string).at_position(0).with_width(5).and \
			.add_field(:integer).as(:integer).at_position(5).with_width(5).and \
			.add_field(:float).as(:float).at_position(10).with_width(5).with_precision(2).and \
			.add_field(:true).as(:boolean).at_position(15)
		@sample.pixxxit(:foobar).should == 'abcde1234512345Y'
	end

end

