# frozen_string_literal: true

require_relative 'lib/ask_gpt/version'

Gem::Specification.new do |spec|
  spec.name = 'ask_gpt'
  spec.version = AskGpt::VERSION
  spec.authors = ['Nuzair46']
  spec.email = ['nuzer501@gmail.com']

  spec.summary = 'A ruby gem to Interact with OpenAI GPT API with context and history'
  spec.homepage = 'https://github.com/Nuzair46/ask_gpt'

  spec.license = 'MIT'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Nuzair46/ask_gpt'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ruby-openai'
end
