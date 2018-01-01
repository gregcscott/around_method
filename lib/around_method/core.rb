module AroundMethod
  module Core
    def around_method(method_name, wrapper_method)
      apply_around_method(method_name, wrapper_method) if method_defined?(method_name)
      around_method_wrapped[method_name] = wrapper_method
    end

    def apply_around_method(method_name, wrapper_method)
      renamed_original_method = "#{method_name}_inner"
      alias_method(renamed_original_method, method_name)
      with_method_added_hook_disabled do
        define_method(method_name) do
          original_method_proc = method(renamed_original_method)
          method(wrapper_method).call(&original_method_proc)
        end
      end
    end

    def method_added(method_name)
      if around_method_wrapped.has_key?(method_name) && enable_method_added_hook?
        apply_around_method(method_name, around_method_wrapped[method_name])
      end
      super
    end

    def around_method_wrapped
      @around_method_wrapped ||= {}
    end

    def disable_method_added_hook?
      @disable_method_added_hook
    end

    def enable_method_added_hook?
      !disable_method_added_hook?
    end

    # Allow AroundMethod's method_added hook to be temporarily disabled,
    # otherwise application will trigger an infinite loop.
    def with_method_added_hook_disabled
      @disable_method_added_hook = true
      yield
      @disable_method_added_hook = false
    end
  end
end