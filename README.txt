= Mathstats

Mathstats is a simple statistics library.

== Goals

1. Support for basic statistics equations
2. No dependencies
3. Rails integration
4. Usable as a mixin:   [4,8,15,16,23,42].variance
5. Usable as a library: Mathstats.variance([4,8,15,16,23,42])

== Installation

$ gem install mathstats

== Usage

require 'mathstats'

Mathstats.attach_to(Array)
[4,8,15,16,23,42].variance

# Or if you don't want to mess with the Array class
Mathstats.variance([4,8,15,16,23,42])

== Methods available

* mean, average
* standard_deviation
* sum
* variance