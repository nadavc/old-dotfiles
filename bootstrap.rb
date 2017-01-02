#!/usr/bin/env ruby

require('fileutils')

HOMEBREW_EXT = 'homebrew'
HOMEBREW_CASK_EXT = 'homebrew-cask'
MAS_PKG_EXT = 'mas'

def install_brew
  brew_location = `which brew`
  if brew_location.empty?
    system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /tmp/homebrew-install.log < /dev/null')
    system('brew tap caskroom/versions')
    system('brew tap homebrew/versions')
  end
end

def install_mas
  mas_location = `which mas`
  if mas_location.empty?
    system('brew install mas')
  end
  puts "Signing into Apple Store..."
  puts "Enter Apple Store ID:"
  system("mas signin #{gets}")
end

def setup_directories
  conf_dir = File.join(Dir.home, '.config')
  unless File.exist?(conf_dir)
    Dir.mkdir(conf_dir)
  end
end

def install_pkg(extension, root_dir, cmd_prefix)
  Dir.entries(root_dir).select { |f| f.end_with?(".#{extension}") }.each { |file|
    abs_file = File.join(root_dir, file)
    to_install = File.readlines(abs_file)
                     .select { |line| not line.start_with?('#') }
                     .select { |line| not line.strip.empty? }

    to_install.each { |entry|
      cmd = "#{cmd_prefix} #{entry}"
      puts "Executing: #{cmd}"
      system(cmd)
    }
  }
end

# SETUP --------------------------------------------------------------
install_brew
install_mas
setup_directories

# INSTALL PACKAGES AND RUN INSTALL.SH --------------------------------
entries = Dir.entries('.') + Dir.entries('./private').map { |d| "private/#{d}" }
entries.select { |f| File.directory?(f) }.map { |f| File.join(Dir.pwd, f) }.each { |abs_dir|

  # Link prefs
  Dir.entries(abs_dir).select { |f| f.end_with?('.plist') }.each { |f|
    source_file = File.join(abs_dir, f)
    target_file = File.join(Dir.home, 'Library', 'Preferences', f)
    unless File.exist?(target_file) or File.symlink?(target_file)
      puts "Linking #{target_file} to #{source_file}"
      FileUtils.ln_s(source_file, target_file)
    end
  }

  # Install homebrew, homebrew-cask and mas apps
  install_pkg(HOMEBREW_EXT, abs_dir, 'brew install')
  install_pkg(HOMEBREW_CASK_EXT, abs_dir, 'brew cask install')
  install_pkg(MAS_PKG_EXT, abs_dir, 'mas install')

  # Link package/conf directory to ~/.config/package
  conf_dir = File.join(abs_dir, 'conf')
  target_file = File.join(Dir.home, '.config', File.basename(abs_dir))
  if File.directory?(conf_dir) and not File.exist?(target_file)
    FileUtils.ln_s(conf_dir, target_file)
  end

  # Copy fonts
  Dir.entries(abs_dir).select { |f| f.end_with?('.otf') }.each { |f|
    target_file = File.join(Dir.home, 'Library', 'Fonts', f)
    unless File.exist?(target_file)
      puts "Copying #{f} to #{target_file}"
      FileUtils.cp(File.join(abs_dir, f), target_file)
    end
  }

  # Create symlinks such that filename.symlink is linked from ~/.filename
  Dir.entries(abs_dir).select { |f| f.end_with?('.symlink') }.each { |f|
    source_file = File.join(abs_dir, f)
    target_file = File.join(Dir.home, "./#{f.gsub('.symlink', '')}")
    unless File.exist?(target_file) or File.symlink?(target_file)
      puts "Creating symlink from #{target_file} to #{source_file}"
      FileUtils.ln_s(source_file, target_file)
    end
  }

  # Run install.sh and pass script dir as first param
  install_script = File.join(abs_dir, 'install.sh')
  if File.exist?(install_script)
    puts "Executing #{install_script}..."
    system("#{install_script} #{abs_dir}")
  end
}
