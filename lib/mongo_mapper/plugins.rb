# encoding: UTF-8
module MongoMapper
  module Plugins
    def plugins
      @plugins ||= []
    end

    def plugin(mod)
      if RUBY_VERSION < "1.9" # updated for ruby 1.9 support
        extend mod::ClassMethods     if mod.const_defined?(:ClassMethods)
        include mod::InstanceMethods if mod.const_defined?(:InstanceMethods)
        mod.configure(self)          if mod.respond_to?(:configure)
      else
        extend mod::ClassMethods     if mod.const_defined?(:ClassMethods, false)
        include mod::InstanceMethods if mod.const_defined?(:InstanceMethods, false)
        mod.configure(self)          if mod.respond_to?(:configure)
      end
      
      plugins << mod
    end
  end
end
