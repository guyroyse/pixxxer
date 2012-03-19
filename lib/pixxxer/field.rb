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
    case type
    when :integer
      @pixxxitter = IntegerFieldPixxxitter.new self
      @depixxxitter = IntegerFieldDepixxxitter.new self 	
    when :float
      @pixxxitter = FloatFieldPixxxitter.new self
      @depixxxitter = FloatFieldDepixxxitter.new self 	
    when :boolean
      @pixxxitter = BooleanFieldPixxxitter.new self
      @depixxxitter = BooleanFieldDepixxxitter.new self 	
    when :comp3
      @pixxxitter = Comp3FieldPixxxitter.new self
      @depixxxitter = Comp3FieldDepixxxitter.new self 	
    when :ebcdic_string
      @pixxxitter = EbcdicStringFieldPixxxitter.new self
      @depixxxitter = EbcdicStringFieldDepixxxitter.new self 	
    end
    @type = type
    self
  end
  # backwards compatability
  def as_string
    as(:string)
  end
  def as_integer
    as(:integer)
  end
  def as_float
    as(:float)
  end
  def as_boolean
    as(:boolean)
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

