Gem::Specification.new do |s|

	s.name = "pixxxer"
	s.version = '0.2.0'
	s.platform = Gem::Platform::RUBY
	s.authors = ['Guy Royse', 'Alyssa Diaz']
	s.email = ['guy@guyroyse.com']
	s.homepage = "http://github.com/guyroyse/pixxxer"
	s.license = "MIT"
	s.summary = "DSL for building and parsing fixed with records"
	s.description = "Simple interface for dealing with the fixed width records that are commong required when working with legacy COBOL systems."

	s.required_rubygems_version = ">=1.5.2"

	s.add_development_dependency 'rspec', '>= 2.5.0'
	s.add_development_dependency 'rspec-core', '>= 2.5.1'
	s.add_development_dependency 'rspec-expectations', '>= 2.5.0'

	s.files = Dir["lib/**/*"] 
	s.files << "LICENSE"
	s.files << "README.md"

	s.require_path = 'lib' 
end

