$logger = Rails.env.prodcution? ? Logger.new("log/production.log") : Logger.new("log/development.log")