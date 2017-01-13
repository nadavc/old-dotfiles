#!/usr/bin/env ruby

require('net/http')
require('json')

org = ARGV[0]
base_dir = ARGV[1]

puts "Using org: #{org} and base_dir: #{base_dir}"

puts 'Enter GitHub token: '
pass = STDIN.gets.chomp

uri = URI("https://api.github.com/orgs/#{org}/repos")
uri.query = URI.encode_www_form([['per_page', '200']])


req = Net::HTTP::Get.new(uri)
req.basic_auth 'nadavc', pass

res = Net::HTTP.start(uri.hostname, uri.port, {use_ssl: true}) do |http|
  http.request(req)
end

json = JSON.parse(res.body, {symbolize_names: true})

json.each do |repo|
  repo_dest_dir = File.join(base_dir, repo[:name])
  if File.exist?(repo_dest_dir)
    Dir.chdir(repo_dest_dir) {
      puts("Rebasing against #{repo_dest_dir}")
      system('git pull --rebase')
    }
  else
    Dir.chdir(base_dir) {
      puts("Cloning #{repo[:ssh_url]}")
      system("git clone #{repo[:ssh_url]}")
    }
  end
end
