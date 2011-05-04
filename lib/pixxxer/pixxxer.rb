class PixxxerField
	def initialize
		@position = 0
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
		field
	end
end

class PixxxerTemplate
	def add_field(field_name)
		@field = PixxxerField.new
		@field
	end
	def depixxxit(string)
		{:foo => @field.depixxxit(string) }
	end
end

def define_pixxx_template(template_name)
	$pixxxer_template = PixxxerTemplate.new
end

class String
	def depixxxit(template_name)
		$pixxxer_template.depixxxit self
	end
end
