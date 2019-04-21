require 'spec_helper'

RSpec.describe HerokuEnv do
  # Because HerokuEnv is a singleton we clone it for
  # every subject call to ensure it doesn't use remembered
  # state from another test.
  subject { described_class.clone }

  before do
    described_class.configure do |config|
      config.add_env suffix: '-p', env: 'production'
      config.add_env suffix: '-s', env: 'staging'
      config.add_env suffix: '-uat', env: 'user acceptance testing'
    end
  end

  describe '#env' do
    it 'discovers the env when on staging', stub_env: { 'HEROKU_APP_NAME': 'myapp-p' } do
      subject.env == :staging
    end

    it 'discovers the env when on production', stub_env: { 'HEROKU_APP_NAME': 'myapp-uat' } do
      subject.env == :user_acceptance_testing
    end
  end

  describe 'question mark accessors', stub_env: { 'HEROKU_APP_NAME': 'myapp-s' } do
    it 'defines the question mark accessors' do
      expect(subject.respond_to?(:production?)).to be_truthy
      expect(subject.respond_to?(:staging?)).to be_truthy
      expect(subject.respond_to?(:user_acceptance_testing?)).to be_truthy
    end
  end
end
