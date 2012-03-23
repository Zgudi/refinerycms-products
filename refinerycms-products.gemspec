Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-products'
  s.version           = '1.0.3'
  s.description       = 'Ruby on Rails Products engine for Refinery CMS'
  s.date              = '2012-13-23'
  s.summary           = 'Products engine for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*', 'db/**/*', 'public/**/*']
  s.authors           = ['James Thompson', 'Byron Peters']
  s.email             = 'james.b.thompson@gmail.com'
  s.homepage          = 'https://github.com/julesce/refinerycms-products'

  # Runtime dependencies
  s.add_dependency    'acts-as-taggable-on', '~> 2.2.2'

end