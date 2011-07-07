require 'iconv'
class FieldPixxxitter
	def initialize(field)
		@field = field
	end
	def pixxxit(hash, record)
		field = fetch_field hash
		add_to_record record, field
	end
	def add_to_record(record, field)
		record = widen_record record
		inject_field record, field
	end
	def widen_record(record)
		record.ljust @field.position
	end
	def inject_field(record, field)
		record[@field.position, field.length] = field
		record
	end
	def fetch_field(hash)
		field = coerce_field hash[@field.name].to_s
		field = pad_field field
		shorten_field field
	end
	def coerce_field(field)
    c = case @field.type
		when :float
			(field.to_f * 10 ** @field.precision).to_i
		when :boolean
			field == 'true' ? @field.true_value : @field.false_value
		when :comp3
			i_to_comp3(field)
		when :ebcdic_char
			ascii_to_ebcdic(field)
    else
      field
		end
    c.to_s
	end
	def shorten_field(field)
    return field if @field.width.nil?
		case @field.type
    when :integer, :float, :comp3, :ebcdic_char
			field[field.length - @field.width, @field.width]
		else
			field[0, @field.width]
		end
	end
	def pad_field(field)
    return field if @field.width.nil?
		case @field.type
    when :integer, :float
			field.rjust(@field.width, '0')
		when :comp3
			field.rjust(@field.width, "\x00")
		when :ebcdic_char
			field.rjust(@field.width, "\x40")
		else
			field.ljust(@field.width, ' ')
		end
	end
	def i_to_comp3(field)
    n = field.to_i
    s = n.abs.to_s + (n < 0 ? "d" : "c")
    s = "0" + s if s.size.odd?
    [s].pack("H*")
	end
	def ascii_to_ebcdic(field)
    @ae_iconv ||= Iconv.new('EBCDIC-US', 'ASCII')
    @ae_iconv.iconv(field)
	end
end
