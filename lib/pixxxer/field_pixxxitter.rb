require 'iconv'
class FieldPixxxitter
	def initialize(field)
		@field = field
	end
	def pixxxit(hash, record)
		field = fetch_field hash
		add_to_record record, field
	end
	def fetch_field(hash)
		field = coerce_field hash[@field.name].to_s
		field = pad_field field
		shorten_field field
	end
	def coerce_field(field)
		field.to_s
	end
	def pad_field(field)
    return field if @field.width.nil?
    field.ljust(@field.width, ' ')
	end
	def shorten_field(field)
    return field if @field.width.nil?
    field[0, @field.width]
	end
	def add_to_record(record, field)
		record = widen_record record
		inject_field record, field
	end
	def widen_record(record)
		record.ljust(@field.position, ' ')
	end
	def inject_field(record, field)
		record[@field.position, field.length] = field
		record
	end
end

class NumberFieldPixxxitter < FieldPixxxitter
  def is_valid?(field)
    true if Float(field) rescue false
  end
	def shorten_field(field)
		return field[field.length - @field.width, @field.width] unless @field.width.nil?
		field
	end
	def pad_field(field)
    return field if @field.width.nil?
		field.rjust(@field.width, '0')
	end
end

class IntegerFieldPixxxitter < NumberFieldPixxxitter
  def is_valid?(field)
    true if Integer(field) rescue false
  end
	def coerce_field(field)
		return '' unless is_valid? field
		field
	end
end

class FloatFieldPixxxitter < NumberFieldPixxxitter
	def coerce_field(field)
    return '' unless is_valid? field
		(field.to_f * 10 ** @field.precision).to_i.to_s
	end
end

class Comp3FieldPixxxitter < NumberFieldPixxxitter
  def coerce_field(field)
    return '' unless is_valid? field
    i = adjust_float(field)
    i_to_comp3(i)
	end
  def i_to_comp3(i)
    s = i.abs.to_s + (i < 0 ? "d" : "c")
    s = "0" + s if s.size.odd?
    [s].pack("H*")
  end
  def adjust_float(field)
		(field.to_f * 10 ** @field.precision).to_i
  end
	def pad_field(field)
    return field if @field.width.nil?
		field.rjust(@field.width, "\x00")
	end
	def widen_record(record)
		record.ljust(@field.position, "\x00")
	end
end

class BooleanFieldPixxxitter < FieldPixxxitter
	def coerce_field(field)
		field == 'true' ? @field.true_value : @field.false_value
	end
end

class EbcdicStringFieldPixxxitter < FieldPixxxitter
	def coerce_field(field)
    @@ea_iconv ||= Iconv.new('EBCDIC-US', 'ASCII')
    @@ea_iconv.iconv(field.to_s)
	end
	def pad_field(field)
    return field if @field.width.nil?
    field.ljust(@field.width, "\x40")
	end
	def widen_record(record)
		record.ljust(@field.position, "\x40")
	end
end
