= Mathstats

Mathstats is a simple statistics library.

== Goals

1. Support for basic statistics equations
2. No dependencies
3. Rails integration
4. Usable as a mixin:   [4,8,15,16,23,42].variance
5. Usable as a library: Mathstats::Lib.variance([4,8,15,16,23,42])

== Installation

$ gem sources -a http://gems.github.com
$ gem install bmarini-mathstats

== Usage

require 'rubygems'
require 'mathstats'

Array.send :include, Mathstats
[4,8,15,16,23,42].variance

# Or if you don't want to mess with the Array class
Mathstats::Lib.variance([4,8,15,16,23,42])