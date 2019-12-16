# frozen_string_literal: true

require "logger"
require "values"
require "json"

module Kitlog
  class ContextualLogger < Value.new(:logger, :context)
    def log(**kwargs)
      logger.info(context.merge(kwargs))
    end

    def with(additional_context)
      super(context: context.merge(additional_context))
    end
  end

  FORMATTERS = {
    json: ->(payload) { payload.to_json },
    logfmt: ->(payload) do
      payload.reduce("") { |a, (k, v)| a + "#{k}=#{v.to_json} " }
    end,
  }.freeze

  # rubocop:disable Metrics/MethodLength
  def self.configure(destination: STDERR, format: nil)
    format ||= destination.isatty ? :logfmt : :json
    formatter = FORMATTERS.fetch(format)

    @logger = Logger.new(destination)
    @logger.formatter = proc do |_severity, datetime, _progname, payload|
      formatter.call(
        payload.merge(
          ts: datetime.strftime("%Y-%m-%dT%H:%M:%S.%NZ"),
          tid: Thread.current.object_id,
        ),
      ) + "\n"
    end
  end
  # rubocop:enable Metrics/MethodLength

  configure

  def self.logger
    @logger
  end

  def self.with(**context)
    ContextualLogger.new(@logger, context)
  end

  def self.log(**kwargs)
    @logger.info(kwargs)
  end

  def log(**kwargs)
    @logger.info(kwargs)
  end
end
