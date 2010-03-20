Gem::Specification.new do |s|
  s.name             = "mathstats"
  s.version          = "0.9.1"
  s.date             = "2008-11-07"
  s.summary          = "Basic statistics methods for ruby available as a \
mixin or standalone class"
  s.email            = "bmarini@gmail.com"
  s.homepage         = "http://github.com/bmarini/mathstats"
  s.description      = "Mathstats is a basic statistics library. It is meant \
to be mixed into Array, but you can also use it as a standalone class."
  s.has_rdoc         = true
  s.rdoc_options     = ["--main", "README.txt"]
  s.authors          = ["Ben Marini"]
  s.files            = [
    "README.txt",
    "Rakefile",
    "mathstats.gemspec",
    "lib/mathstats.rb"
  ]
  s.test_files       = ["test/mathstats_test.rb"]
  s.extra_rdoc_files = ["README.txt"]
end
