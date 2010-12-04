$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'attr_required'
require 'attr_optional'
require 'rspec'

class A
  include AttrRequired, AttrOptional
  attr_required :attr_required_a
  attr_optional :attr_optional_a
end

class B < A
  attr_required :attr_required_b
  attr_optional :attr_optional_b
end
