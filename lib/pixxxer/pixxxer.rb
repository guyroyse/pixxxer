require 'pixxxer/template'

$pixxxer_templates = {}

def define_pixxx_template(template_name)
	$pixxxer_templates[template_name] = PixxxerTemplate.new
end

class String
	def depixxxit(template_name)
    if $pixxxer_templates.has_key?(template_name)
		  $pixxxer_templates[template_name].depixxxit(self)
    else
      raise 'pixxxer template not defined: %s' % template_name
    end
	end
end

class Hash
	def pixxxit(template_name)
    if $pixxxer_templates.has_key?(template_name)
		  $pixxxer_templates[template_name].pixxxit(self)
    else
      raise 'pixxxer template not defined: %s' % template_name
    end
	end
end
