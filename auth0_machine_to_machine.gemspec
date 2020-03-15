require_relative 'lib/auth0_machine_to_machine/version'

Gem::Specification.new do |spec|
  spec.name = "auth0_machine_to_machine"
  spec.version = Auth0MachineToMachine::VERSION
  spec.authors = ["playfulcorgi"]
  spec.email = ["unrulybeardedweekend@gmail.com"]
  spec.homepage = "https://github.com/playfulcorgi/auth0_machine_to_machine"
  spec.license = "MIT"
  spec.summary = "Retrieves JWT bearer token from Auth0 for authenticating and authorizing requests."
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.5.0"
end
