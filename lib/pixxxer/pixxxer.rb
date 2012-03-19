require 'pixxxer/template'

$pixxxer_templates = {}

def define_pixxx_template(template_name)
	$pixxxer_templates[template_name] = PixxxerTemplate.new
end

class String
	def depixxxit(template_name)
    raise "pixxxer template \"#{template_name}\" not defined" unless $pixxxer_templates.has_key? template_name
		$pixxxer_templates[template_name].depixxxit self
	end
end

class Hash
	def pixxxit(template_name)
    raise "pixxxer template \"#{template_name}\" not defined" unless $pixxxer_templates.has_key? template_name
		$pixxxer_templates[template_name].pixxxit self
	end
end
