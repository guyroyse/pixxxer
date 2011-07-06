require 'pixxxer/field_pixxxitter'
require 'pixxxer/field_depixxxitter'

class PixxxerField
	attr_reader :width, :name, :position, :type, :precision, :true_value, :false_value
	def initialize(field_name, template, true_value, false_value)
		@template = template
		@name = field_name
		@position = 0
		@precision = 0
		@true_value = true_value
		@false_value = false_value
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
  def as(type)
    @type = type
    self
  end
	def with_precision(precision)
		@precision = precision
		self
	end
	def true_is(value)
		@true_value = value
		self
	end
	def false_is(value)
		@false_value = value
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

