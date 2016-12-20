module Gingerr
  module Stats
    class AppsStateSummary
      def initialize(apps = Gingerr::App)
        @project_apps = apps
      end

      def call
        result = { ok: 0, unstable: 0, critical: 0 }

        @project_apps.find_each.each_with_object(result) { |app, data|
          stability_level = Gingerr::AppStats.new(app).stability_level
          data[stability_level] += 1
        }.to_a
      end
    end
  end
end
