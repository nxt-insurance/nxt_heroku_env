require 'spec_helper'

RSpec.describe HerokuEnv do
  # Because HerokuEnv is a singleton we clone it for
  # every subject call to ensure it doesn't use remembered
  # state from another test.
  subject { described_class.clone }

  before do
    described_class.configure do |config|
      config.add_env production: /myapp-p/
      config.add_env staging: /myapp-s/
      config.add_env user_acceptance_testing: /myapp-uat/
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

    it 'answers with true or false' do
      expect(subject.production?).to be_falsey
      expect(subject.staging?).to be_truthy
      expect(subject.user_acceptance_testing?).to be_falsey
    end
  end

  describe 'env block methods', stub_env: { 'HEROKU_APP_NAME': 'myapp-s' } do
    it 'defines env block methods' do
      expect(subject.respond_to?(:production))
      expect(subject.respond_to?(:staging))
      expect(subject.respond_to?(:user_acceptance_testing))
    end

    it 'only calls the block of the env method matching the heroku env' do
      blocks_called = []

      subject.staging { blocks_called << :staging }
      subject.production { blocks_called << :production }
      subject.user_acceptance_testing { blocks_called << :user_acceptance_testing }

      expect(blocks_called).to eq %i[staging]
    end
  end
end
