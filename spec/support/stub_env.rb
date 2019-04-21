module StubEnvHelper
  def with_stubbed_env(**opts, &block)
    values_before = opts.keys.map do |key|
      { key => ENV[key.to_s] }
    end.reduce({}, &:merge)

    opts.each do |key, value|
      ENV[key.to_s] = value.to_s
    end

    block.call

    values_before.each do |key, value|
      ENV[key.to_s] = value
    end
  end
end

RSpec.configure do |config|
  config.include StubEnvHelper

  config.around(:each, :stub_env) do |example|
    stub_env_opts = example.metadata.fetch(:stub_env)
    with_stubbed_env(stub_env_opts) do
      example.call
    end
  end
end
