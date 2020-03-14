require_relative 'lib/auth0_machine_to_machine/version'

Gem::Specification.new do |spec|
  spec.name = "auth0_machine_to_machine"
  spec.version = Auth0MachineToMachine::VERSION
  spec.authors = ["playfulcorgi"]
  spec.homepage = "https://github.com/playfulcorgi/auth0_machine_to_machine"
  spec.license = "MIT"
  spec.summary = "Retrieves JWT bearer token from Auth0 for authenticating and authorizing requests."
  spec.files = ["lib/auth0_machine_to_machine.rb"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.7.0"
end
