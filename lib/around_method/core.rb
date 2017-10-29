module AroundMethod
  module Core
    def around_method(method_name, wrapper_method)
      renamed_original_method = "#{method_name}_inner"
      alias_method(renamed_original_method, method_name)
      define_method(method_name) do
        method(wrapper_method).call(&method(renamed_original_method))
      end
    end
  end
end