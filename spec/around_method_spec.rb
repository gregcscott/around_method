require 'spec_helper'

RSpec.describe AroundMethod do
  let(:instance) { klass.new }

  it 'has a version number' do
    expect(AroundMethod::VERSION).not_to be nil
  end

  shared_examples_for "method is wrapped" do
    it 'wraps methods' do
      expect(instance.wrapped).to eq 'cognito ergo sum'
    end
  end

  context 'when around_method is called after method is defined' do
    let(:klass) do
      Class.new do
        def wrapped
          'cognito'
        end

        def wrapper
          yield + ' ergo sum'
        end

        around_method :wrapped, :wrapper
      end
    end

    it_behaves_like "method is wrapped"
  end

  context 'when around_method is called before method is defined' do
    let(:klass) do
      Class.new do
        around_method :wrapped, :wrapper

        def wrapped
          'cognito'
        end

        def wrapper
          yield + ' ergo sum'
        end
      end
    end

    it_behaves_like "method is wrapped"
  end

  context 'when around_method is called when method is defined on a superclass' do
    let(:klass) do
      Class.new(superclass) do
        around_method :wrapped, :wrapper

        def wrapper
          yield + ' ergo sum'
        end
      end
    end
    let(:superclass) do
      Class.new do
        def wrapped
          'cognito'
        end
      end
    end

    it_behaves_like "method is wrapped"
  end
end
