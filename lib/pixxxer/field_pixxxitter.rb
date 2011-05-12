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
		pad_string shorten_string(hash[@field.name].to_s)
	end
	def shorten_string(string)
		if @field.type == Integer
			return string[string.length - @field.width, @field.width] unless @field.width.nil?
		else
			return string[0, @field.width] unless @field.width.nil?
		end
		string
	end
	def pad_string(string)
		if @field.type == Integer
			return string.rjust(@field.width, '0') unless @field.width.nil?
		else
			return string.ljust(@field.width, ' ') unless @field.width.nil?
		end
		string
	end

end


