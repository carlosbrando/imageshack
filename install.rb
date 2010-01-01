puts 'Copying files...'

src_file = File.join(File.dirname(__FILE__), 'initializers', 'imageshack_config.rb')
dest_file = File.join(RAILS_ROOT, 'config', 'initializers', 'imageshack_config.rb')

FileUtils.cp_r(src_file, dest_file)

puts 'Files copied - Installation complete!'