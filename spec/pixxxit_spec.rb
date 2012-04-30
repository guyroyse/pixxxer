require 'pixxxer'

def ebcdic_compatible?
  Iconv.new('EBCDIC-US', 'ASCII')
rescue Iconv::InvalidEncoding => e
  false
end

describe 'Hash.pixxxit' do

  it 'builds a string from multiple fields' do
    @sample = {
      :string => 'abcde',
      :integer => 12345,
      :float => 123.45,
      :true => true
    }

    define_pixxx_template(:foobar) \
      .add_field(:string).as(:string).at_position(0).with_width(5).and \
      .add_field(:integer).as(:integer).at_position(5).with_width(5).and \
      .add_field(:float).as(:float).at_position(10).with_width(5).with_precision(2).and \
      .add_field(:true).as(:boolean).at_position(15)
    @sample.pixxxit(:foobar).should == 'abcde1234512345Y'
  end

  # OS X iconv not compatible with EBCDIC, so skip tests
  if !ebcdic_compatible?
    $stderr.puts 'Skipping COBOL multi test: incompatible iconv version'
  else
    it 'builds a string from multiple COBOL fields' do
      @sample = {
        :c1 => '-987.65',
        :c2 => '1',
        :e1 => 'yo!',
        :e2 => 'X9.&'
      }

      define_pixxx_template(:foobar) \
        .add_field(:c1).as(:comp3).at_position(0).with_width(5).with_precision(2).and \
        .add_field(:e1).as(:ebcdic_string).at_position(5).with_width(5).and \
        .add_field(:c2).as(:comp3).at_position(10).with_width(5).and \
        .add_field(:e2).as(:ebcdic_string).at_position(15)
      @sample.pixxxit(:foobar).should == "\x00\x00\x98\x76\x5D\xA8\x96\x5A\x40\x40\x00\x00\x00\x00\x1C\xE7\xF9\x4B\x50"
    end
  end

end
