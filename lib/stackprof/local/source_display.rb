require "stackprof/report"

module StackProf
  module Local
    module SourceDisplay
      def source_display(f, file, lines, range = nil)
        super(f, Local.localize(file), lines, range = nil)
      end
    end
  end
end

StackProf::Report.prepend(StackProf::Local::SourceDisplay)
