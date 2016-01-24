class Mock

  def initialize(stubee)
    @the_stubee = stubee
  end

  def with(*arg)
    @stub_args = arg
    self
  end

  def returns(value)
    stub_args   = @stub_args
    stub_method = @stub_method
    l = lambda { |*args| (stub_args && stub_args != args) ? (raise) : (return value) }

    if @the_stubee.is_a?(Class)
      modu = Module.new
      modu.send(:define_method, stub_method, l)
      if @all_instances
        @the_stubee.class_eval { prepend modu }
      else
        @the_stubee.singleton_class.class_eval { prepend modu }
      end
    else
      @the_stubee.define_singleton_method(stub_method, l)
    end

  end
end


class Object
  def stubs(method_name)
    target = self.is_a?(Mock) ? self : Mock.new(self)
    target.instance_eval { @stub_method = method_name.to_sym }
    target
  end

  def all_instances
    mock = Mock.new(self)
    mock.instance_eval { @all_instances = true }
    mock
  end
end



