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
		return coerce_field_to_boolean(field) if @field.type == 'Boolean'
		return adjust_float(field.to_f) if @field.type == Float
		field
	end
	def coerce_field_to_boolean(field)
		field == @field.true_value
	end
	def adjust_float(field)
		field / 10 ** @field.precision
	end
end

class IntegerFieldDepixxxitter < FieldDepixxxitter
	def coerce_field(field)
		return field.to_i if field.match /^?\d+$/ 
		nil
	end
end
