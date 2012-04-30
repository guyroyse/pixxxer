require 'pixxxer'

def ebcdic_compatible?
  Iconv.new('EBCDIC-US', 'ASCII')
rescue Iconv::InvalidEncoding => e
  false
end

# OS X iconv not compatible with EBCDIC, so skip tests
if !ebcdic_compatible?
  $stderr.puts 'Skipping EBCDIC tests: incompatible iconv version'
else
  describe 'EbcdicString' do

    describe 'String.depixxxit' do
    
      before(:each) do
        @sample = "12345\x82\x81\xa9\xf0\xf1\x40"
      end
      
      it 'parses a field and coerces it to an EBCDIC string' do
        define_pixxx_template(:foobar) \
          .add_field(:foo).as(:abcdic_string).at_position(5).with_width(6)
        depixxxed = @sample.depixxxit :foobar
        depixxxed[:foo].should be_a_kind_of(String)
        depixxxed[:foo] == 'baz01 '
      end

    end

    describe 'Hash.pixxxit' do
    
      before(:each) do
        @sample = {
          :string => 'baz01'
        }
      end
      
      it 'builds an EBCDIC string from one field' do
        define_pixxx_template(:foobar).add_field(:string).as(:ebcdic_string)
        @sample.pixxxit(:foobar).should == "\x82\x81\xa9\xf0\xf1"
      end

      it 'builds an EBCDIC string with a width that is too small' do
        define_pixxx_template(:foobar).add_field(:string).as(:ebcdic_string) \
          .with_width(2)
        @sample.pixxxit(:foobar).should == "\x82\x81"
      end

      it 'builds an EBCDIC string with a width that is too big' do
        define_pixxx_template(:foobar).add_field(:string).as(:ebcdic_string) \
          .with_width(10)
        @sample.pixxxit(:foobar).should == "\x82\x81\xa9\xf0\xf1\x40\x40\x40\x40\x40"
      end

      it 'builds an EBCDIC string with a width that is just right' do
        define_pixxx_template(:foobar).add_field(:string).as(:ebcdic_string) \
          .with_width(5)
        @sample.pixxxit(:foobar).should == "\x82\x81\xa9\xf0\xf1"
      end

      it 'builds an EBCDIC string with a position' do
        define_pixxx_template(:foobar).add_field(:string).as(:ebcdic_string) \
          .at_position(5)
        @sample.pixxxit(:foobar).should == "\x40\x40\x40\x40\x40\x82\x81\xa9\xf0\xf1"
      end

      it 'builds an EBCDIC string with a width and a position' do
        define_pixxx_template(:foobar).add_field(:string).as(:ebcdic_string) \
          .with_width(2).at_position(5)
        @sample.pixxxit(:foobar).should == "\x40\x40\x40\x40\x40\x82\x81"
      end

    end

  end
end
