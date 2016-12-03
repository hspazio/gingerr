namespace :gingerr do
  desc "Generate example data"
  task :example_data => :environment do
    p apps = generate_records(10) { example.app }
    p endpoints = generate_records(10) { example.endpoint }
    p success_signals = generate_records(1000) { example.success_signal(apps.sample, endpoints.sample) }
    p errors = generate_records(20, false) { example.error }
    p error_signals = generate_records(20) { example.error_signal(apps.sample, endpoints.sample, errors.sample) }
  end

  def generate_records(count, auto_save=true, &block)
    count.times.map {
      record = block.call

      if auto_save
        record.save && record
      else
        record
      end
    }
  end

  def example
    Gingerr::Example
  end
end
