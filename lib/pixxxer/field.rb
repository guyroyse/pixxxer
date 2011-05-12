require 'pixxxer/field_pixxxitter'
require 'pixxxer/field_depixxxitter'

class PixxxerField
	attr_reader :width, :name, :position, :type, :precision
	def initialize(field_name, template)
		@template = template
		@name = field_name
		@position = 0
		@precision = 0
		@pixxxitter = FieldPixxxitter.new self
		@depixxxitter = FieldDepixxxitter.new self
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
	def depixxxit(record)
		@depixxxitter.depixxxit record
	end
end

