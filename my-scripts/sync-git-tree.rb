#!/usr/bin/env ruby

base_dir = ARGV[0]

Dir["#{base_dir}/*/*"].select { |f| File.directory?(f) }.each { |f|
  Dir.chdir(f) {
    puts "Git pulling from #{f}"
    unless system('git pull origin master --rebase')
      abort("Unable to pull --rebase on #{f}")
    end
  }
}