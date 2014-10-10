require "stackprof/local/version"
require "stackprof/local/configuration"
require "stackprof/local/source_display"

module StackProf
  module Local
    extend self

    attr_reader :configuration

    def configure(args)
      @configuration = Configuration.new(args)
    end

    def localize(file)
      if configuration.remote_gems.match(file)
        to_local_gems(file)
      else
        to_local_project(file)
      end
    end

    private

    def to_local_gems(file)
      file.sub(configuration.remote_gems, configuration.local_gems)
    end

    def to_local_project(file)
      file.sub(configuration.remote_project, configuration.local_project)
    end
  end
end
