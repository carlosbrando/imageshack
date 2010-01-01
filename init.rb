require "imageshack"

raise "You haven't added your key to ImageShack. Do this in config/initializers/imageshack_config.rb." if IMAGESHACK_KEY == "CHANGE ME"