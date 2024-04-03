Sentry.init do |config|
  config.dsn = 'https://86f1046491904c299bb7963319028eb9@o4506877621239808.ingest.us.sentry.io/4506877621436416'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
