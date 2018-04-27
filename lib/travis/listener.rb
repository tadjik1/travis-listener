require 'travis/config'
require 'travis/support'
require 'travis/metrics'
require 'travis/listener/app'
require 'logger'

$stdout.sync = true

module Travis
  class << self
    def config
      @config ||= Listener::Config.load
    end
  end

  module Listener
    class Config < Travis::Config
      define  redis:            { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379'), namespace: 'sidekiq', network_timeout: 5 },
              redis_gatekeeper: { url: ENV.fetch('REDIS_GATEKEEPER_URL', 'redis://localhost:6379'), namespace: 'sidekiq', network_timeout: 5 },
              gator:            { queue: ENV.fetch('SIDEKIQ_GATEKEEPER_QUEUE', 'build_requests') },
              sync:             { queue: ENV.fetch('SIDEKIQ_SYNC_QUEUE', 'sync.gh_apps') },
              sentry:           { },
              metrics:          { reporter: 'librato' }

      def metrics
        # TODO fix keychain?
        super.to_h.merge(librato: librato.to_h.merge(source: librato_source), graphite: graphite)
      end
    end

    class << self
      attr_reader :metrics

      def setup
        if Travis.config.sentry.dsn
          require 'raven'
          ::Raven.configure do |config|
            config.dsn = Travis.config.sentry.dsn
            config.excluded_exceptions = %w{Sinatra::NotFound}
          end
        end

        # setup metrics early
        @metrics = begin
          if ENV['RACK_ENV'] == "production"
            logger = ::Logger.new(STDOUT)
            Travis::Metrics.setup(Travis.config.metrics, logger)
          end
        end
      end

      def disconnect
        # empty for now
      end
    end
  end
end
