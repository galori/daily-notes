# frozen_string_literal: true

require_relative "lib/daily_notes/version"

Gem::Specification.new do |spec|
  spec.name = "daily_notes"
  spec.version = DailyNotes::VERSION
  spec.authors = ["Gall Steinitz"]
  spec.email = ["gall.steinitz@datagrail.io"]
  spec.required_ruby_version = ">= 2.6.0"

  spec.summary       = "Creates a daily notes file"
  spec.description   = "Designed to be used every day - this gem creates a new \"daily_notes\" file for every day, in a file folder structure based on the days date. I made this for the purpose of helping me automate the way I organized my markdown files in vscode, where I take notes."
  spec.homepage      = "https://github.com/galori/daily-notes"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/galori/daily-notes"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("activesupport")
  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
