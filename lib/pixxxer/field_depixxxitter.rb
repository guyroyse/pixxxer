class FieldDepixxxitter
	def initialize(field)
		@field = field
	end
	def depixxxit(record)
		field = extract_field record
		coerce_field field
	end
	def extract_field(record)
		return record[@field.position...record.length] if @field.width.nil?
		record[@field.position, @field.width]
	end
	def coerce_field(field)
		case @field.type
    when :integer
      field.to_i
    when :boolean
      coerce_field_to_boolean(field)
    when :float
      adjust_float(field.to_f)
    when :comp3
      comp3_to_i(field)
    when :ebcdic_char
      ebcdic_to_ascii(field)
    else
      field
    end
	end
	def coerce_field_to_boolean(field)
		field == @field.true_value
	end
	def comp3_to_i(field)
    u = field.unpack("H*").first
    n = u.chop.to_i
    u[-1,1] == 'd' ? -n : n
	end
	def ebcdic_to_ascii(field)
    @ea_iconv ||= Iconv.new('EBCDIC-US', 'ASCII')
    @ea_iconv.iconv(field)
	end
	def adjust_float(field)
		field / 10 ** @field.precision
	end
end
