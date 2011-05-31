require 'pixxxer'

describe 'String.depixxxit' do

	before(:each) do
		@sample = '12345abcde'
	end

	describe 'String' do

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

	end

	describe 'Boolean' do

		it 'parses a field and coerces it to a boolean' do
			define_pixxx_template(:foobar)
				.add_field(:true).as_boolean.at_position(0).with_width(1).and
				.add_field(:false).as_boolean.at_position(1).with_width(1)
			depixxxed = "YN".depixxxit :foobar
			depixxxed[:true].should be_true
			depixxxed[:false].should be_false
		end

		it 'parses a field and coerces it to a boolean with template level value' do
			define_pixxx_template(:foobar).true_is('T').false_is('F')
				.add_field(:true).as_boolean.at_position(0).with_width(1).and
				.add_field(:false).as_boolean.at_position(1).with_width(1)
			depixxxed = "TF".depixxxit :foobar
			depixxxed[:true].should be_true
			depixxxed[:false].should be_false
		end

		it 'parses a field and coerces it to a boolean with field level value' do
			define_pixxx_template(:foobar)
				.add_field(:value).as_boolean.with_width(1).true_is('T').false_is('F')
			depixxxed = "T".depixxxit :foobar
			depixxxed[:value].should be_true
			depixxxed = "F".depixxxit :foobar
			depixxxed[:value].should be_false
		end

		it 'parses a field and coerces it to a boolean value with field level overriding template level' do
		end

		it 'parses a field and coerces it to a boolean value with multiple field level values' do
		end

		it 'parses a field and coerces it to a boolean value with some field level values' do
		end

		# what about invalid values

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
