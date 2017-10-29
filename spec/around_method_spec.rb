require 'spec_helper'

RSpec.describe AroundMethod do
  it 'has a version number' do
    expect(AroundMethod::VERSION).not_to be nil
  end

  context 'when included into a class' do
    let(:klass) do
      Class.new do
        def wrapped
          'cognito'
        end

        def wrapper
          yield + ' ergo sum'
        end

        around_method(:wrapped, :wrapper)
      end
    end
    let(:instance) { klass.new }

    it 'wraps methods' do
      expect(instance.wrapped).to eq 'cognito ergo sum'
    end
  end
end
