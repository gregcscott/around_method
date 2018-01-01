require 'around_method/version'
require 'around_method/core'

# Make available to all classes.
class Object
  extend AroundMethod::Core
end