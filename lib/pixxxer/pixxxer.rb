$pixxxer_templates = {}

class PixxxerField
	def initialize(template)
		@template = template
		@position = 0
		@precision = 0
	end
	def with_width(width)
		@width = width
		self
	end
	def at_position(position)
		@position = position
		self
	end
	def as_string
		self
	end
	def as_integer
		@type = Integer
		self
	end
	def as_float
		@type = Float
		self
	end
	def with_precision(precision)
		@precision = precision
		self
	end
	def and
		@template
	end
	def depixxxit(string)
		field = extract_field string
		coerce_field field
	end
	def extract_field(string)
		return string[@position..string.length-1] if @width.nil?
		string[@position, @width]
	end
	def coerce_field(field)
		return field.to_i if @type == Integer
		return adjust_float(field.to_f) if @type == Float
		field
	end
	def adjust_float(field)
		field / 10 ** @precision
	end
end

class PixxxerTemplate
	def initialize
		@fields = {}
	end
	def add_field(field_name)
		@fields[field_name] = PixxxerField.new(self)
		@fields[field_name]
	end
	def depixxxit(string)
		record = {}
		@fields.each do |field_name, field|
			record[field_name] = field.depixxxit string
		end
		record
	end
end

def define_pixxx_template(template_name)
	$pixxxer_templates[template_name] = PixxxerTemplate.new
end

class String
	def depixxxit(template_name)
		$pixxxer_templates[template_name].depixxxit self
	end
end
