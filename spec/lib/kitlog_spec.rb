# frozen_string_literal: true

require "rspec"
require "kitlog"

RSpec.describe(Kitlog) do
  subject(:output) { StringIO.new }

  let(:logger) { described_class }

  before { described_class.configure(destination: output) }

  def maybe_parse(output)
    JSON.parse(output.string)
  rescue JSON::ParserError
    nil
  end

  it "logs in valid JSON format" do
    expect { logger.log(event: "hey") }.
      to change { maybe_parse(output) }.
      to(include("event" => "hey"))
  end

  describe ".with" do
    let(:logger) { described_class.with(component: "app") }

    it "persists additional keys into other log messages" do
      expect { logger.log(event: "hey") }.
        to change { maybe_parse(output) }.
        to(include("component" => "app", "event" => "hey"))
    end
  end
end
