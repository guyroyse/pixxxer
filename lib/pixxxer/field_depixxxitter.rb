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
	def is_numeric(field)
		field.match /^?\d+$/	
	end
end

class IntegerFieldDepixxxitter < NumberFieldDepixxxitter
	def coerce_field(field)
		return field.to_i if is_numeric field 
		nil
	end
end

class FloatFieldDepixxxitter < NumberFieldDepixxxitter
	def coerce_field(field)
		return adjust_float(field.to_f) if is_numeric field
		nil
	end
	def adjust_float(field)
		field / 10 ** @field.precision
	end
end	

class BooleanFieldDepixxxitter < FieldDepixxxitter
	def coerce_field(field)
		field == @field.true_value
	end
end
