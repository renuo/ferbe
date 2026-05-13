def measure
  # Warm up to ensure everything is loaded and cached
  20.times { HomeController.render(partial: "shared/tower", locals: { counter: 10 }) }

  n = 1000
  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  n.times { HomeController.render(partial: "shared/tower", locals: { counter: 10 }) }
  (Process.clock_gettime(Process::CLOCK_MONOTONIC) - start) / n.to_f * 1000
end

enabled = Ferbe.configuration.enabled
puts "Ferbe Status: #{enabled ? 'ENABLED' : 'DISABLED'}"

# Verify that wrapping actually occurs when enabled
if enabled
  output = HomeController.render(partial: "shared/tower", locals: { counter: 1 })
  unless output.include?("ferbe-partial")
    puts "❌ ERROR: Ferbe is configured as enabled, but tags are missing from output!"
    exit 1
  end
end

avg_time = measure
puts "Average render time (10 nested partials): #{avg_time.round(4)} ms"
