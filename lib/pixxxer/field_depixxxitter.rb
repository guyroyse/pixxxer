require 'iconv'
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
		field
	end
end

class NumberFieldDepixxxitter < FieldDepixxxitter
	def is_valid?(field)
    field.match /\A\d+\z/
	end
end

class IntegerFieldDepixxxitter < NumberFieldDepixxxitter
	def coerce_field(field)
    return nil unless is_valid? field
		field.to_i
	end
end

class FloatFieldDepixxxitter < NumberFieldDepixxxitter
	def coerce_field(field)
    return nil unless is_valid? field
		adjust_float(field.to_f)
	end
	def adjust_float(field)
		field / 10 ** @field.precision
	end
end	

class Comp3FieldDepixxxitter < NumberFieldDepixxxitter
  def is_valid?(field)
    field.match /\A[\x00-\x99\x9C\x9D\x9F]+\z/
  end
  def coerce_field(field)
    return nil unless is_valid? field
    i = comp3_to_i(field)
    @field.precision == 0 ? i : adjust_float(i)
  end
  def comp3_to_i(field)
    u = field.unpack("H*").first
    i = u.chop.to_i
    u[-1,1] == 'd' ? -i : i
  end
	def adjust_float(i)
		i.to_f / 10 ** @field.precision
	end
end

class BooleanFieldDepixxxitter < FieldDepixxxitter
	def coerce_field(field)
		field == @field.true_value
	end
end

class EbcdicStringFieldDepixxxitter < FieldDepixxxitter
	def coerce_field(field)
    @@ae_iconv ||= Iconv.new('ASCII', 'EBCDIC-US')
    @@ae_iconv.iconv(field)
	end
end
