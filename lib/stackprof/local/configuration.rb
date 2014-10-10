require "erb"
require "optparse"
require "shellwords"

module StackProf
  module Local
    class Configuration
      OPTIONS_FILE = ".stackprof-local".freeze
      ERB_EOUTVAR = "-".freeze

      attr_reader :local_gems, :local_project
      attr_reader :remote_gems, :remote_project

      def initialize(args)
        parser.parse!(args_from_options_file)
        parser.parse!(args)
      end

      private

      def parser
        OptionParser.new do |parser|
          parser.on("--remote-gems PATH", String) do |path|
            @remote_gems = regexpify(path)
          end

          parser.on("--remote-project PATH", String) do |path|
            @remote_project = regexpify(path)
          end

          parser.on("--local-gems PATH", String) { |path| @local_gems = path }
          parser.on("--local-project PATH", String) { |path| @local_project = path }
        end
      end

      def args_from_options_file
        return [] unless File.exist?(OPTIONS_FILE)
        options_file_as_erb_string(OPTIONS_FILE).split(/\n+/).flat_map(&:shellsplit)
      end

      def options_file_as_erb_string(path)
        ERB.new(File.read(path), nil, ERB_EOUTVAR).result(binding)
      end

      def regexpify(expression)
        Regexp === expression ? expression : /#{expression}/
      end
    end
  end
end
