module HerokuEnv
  extend self

  def app_name
    ENV['HEROKU_APP_NAME'].presence
  end

  def heroku_app_name_to_env_mappings
    @heroku_app_name_to_env_mappings ||= {}
  end

  def add_env(**args)
    args.each do |env_name, heroku_app_name|
      app_name_pattern = heroku_app_name.is_a?(Regexp) ? heroku_app_name : Regexp.new(heroku_app_name.to_s)
      heroku_app_name_to_env_mappings[app_name_pattern] = env_name.to_sym

      define_method("#{env_name}?") do
        self.env == env_name.to_sym
      end

      define_method(env_name) do |&block|
        block.call if self.env == env_name.to_sym
      end
    end
  end

  def env
    @env ||= begin
      env_name = heroku_app_name_to_env_mappings.keys.find do |heroku_app_name_pattern|
        heroku_app_name_pattern.match?(app_name)
      end

      heroku_app_name_to_env_mappings[env_name]
    end
  end

  def configure(&block)
    block.call(self)
  end
end
