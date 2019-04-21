module HerokuEnv
  extend self

  def app_name
    ENV['HEROKU_APP_NAME'].presence
  end

  def suffix_env_mappings
    @suffix_env_mappings ||= {}
  end

  def add_env(suffix:, env:)
    harmonized_env_name = env.to_s.strip.gsub(/\s+/, "_").underscore
    suffix_env_mappings[suffix.to_s] = harmonized_env_name.to_sym

    define_method("#{harmonized_env_name}?") do
      self.env == harmonized_env_name.to_sym
    end

    define_method(harmonized_env_name) do |&block|
      block.call if self.env == harmonized_env_name.to_sym
    end
  end

  def env
    @env ||= begin
      env_name_suffix = suffix_env_mappings.keys.find { |suffix| app_name.end_with?(suffix) }
      suffix_env_mappings[env_name_suffix]
    end
  end

  def configure(&block)
    block.call(self)
  end
end
