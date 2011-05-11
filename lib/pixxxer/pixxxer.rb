$pixxxer_templates = {}

class PixxxerFieldPixxxitter
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

class PixxxerField
	attr_reader :width, :name, :position, :type, :precision
	def initialize(field_name, template)
		@template = template
		@name = field_name
		@position = 0
		@precision = 0
		@pixxxitter = PixxxerFieldPixxxitter.new self
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
	def pixxxit(hash, record)
		@pixxxitter.pixxxit hash, record
	end
	def depixxxit(string)
		field = extract_field string
		coerce_field field
	end
	def extract_field(string)
		return string[@position...string.length] if @width.nil?
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
		@fields[field_name] = PixxxerField.new(field_name, self)
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

def define_pixxx_template(template_name)
	$pixxxer_templates[template_name] = PixxxerTemplate.new
end

class String
	def depixxxit(template_name)
		$pixxxer_templates[template_name].depixxxit self
	end
end

class Hash
	def pixxxit(template_name)
		$pixxxer_templates[template_name].pixxxit self
	end
end
