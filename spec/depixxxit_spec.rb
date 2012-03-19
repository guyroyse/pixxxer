require 'pixxxer'

describe 'String.depixxxit' do

	before(:each) do
		@sample = '12345abcde'
	end
	
	it 'parses one big field from a string' do
		define_pixxx_template(:foobar).add_field(:foo)
		depixxxed = @sample.depixxxit :foobar
		depixxxed[:foo].should == '12345abcde'
	end

	it 'parses a field with a width' do
		define_pixxx_template(:foobar).add_field(:foo).with_width(5)
		depixxxed = @sample.depixxxit :foobar
		depixxxed[:foo].should == '12345'
	end

	it 'parses a field with a starting position' do
		define_pixxx_template(:foobar).add_field(:foo).at_position(5)
		depixxxed = @sample.depixxxit :foobar
		depixxxed[:foo].should == 'abcde'
	end

	it 'parses a field with a starting position and a width' do
		define_pixxx_template(:foobar).add_field(:foo).at_position(4).with_width(2)
		depixxxed = @sample.depixxxit :foobar
		depixxxed[:foo].should == '5a'
	end

	it 'parses multiple fields' do
		define_pixxx_template(:foobar) \
			.add_field(:foo).at_position(0).with_width(5).as(:integer).and \
			.add_field(:bar).at_position(5).with_width(5)
		depixxxed = @sample.depixxxit :foobar
		depixxxed[:foo].should == 12345
		depixxxed[:bar].should == 'abcde'
	end

	it 'parses with multiple templates' do
		define_pixxx_template(:foobar).add_field(:foo).at_position(0).with_width(5).as(:integer)
		define_pixxx_template(:bazqux).add_field(:foo).at_position(5).with_width(5)
		foobar_depixxxed = @sample.depixxxit :foobar
		bazqux_depixxxed = @sample.depixxxit :bazqux
		foobar_depixxxed[:foo].should == 12345
		bazqux_depixxxed[:foo].should == 'abcde'
	end

end
