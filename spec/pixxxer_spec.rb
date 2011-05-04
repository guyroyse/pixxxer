require 'pixxxer'

describe 'RSpec' do

  it "Runs" do
    true.should == true
  end

end

describe 'Pixxxer' do

  describe 'pixxxit' do
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

  end

end
