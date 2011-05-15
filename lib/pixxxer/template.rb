require 'pixxxer/field'

class PixxxerTemplate
	def initialize
		@true_value = 'Y'
		@false_value = 'N'
		@fields = {}
	end
	def true_is(value)
		@true_value = value
		self
	end
	def false_is(value)
		@false_value = value
		self
	end
	def add_field(field_name)
		@fields[field_name] = PixxxerField.new(field_name, self, @true_value, @false_value)
		@fields[field_name]
	end
	def depixxxit(string)
		record = {}
		@fields.each do |field_name, field|
			record[field_name] = field.depixxxit string
		end
		record
	end
	def pixxxit(hash)
		string = ''
		@fields.each do |field_name, field|
			string = field.pixxxit hash, string
		end
		string
	end
end

