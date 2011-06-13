require 'rubygems'
require 'mechanize'
require 'open-uri'

class DnsUpdater < Thor
	desc "update USERNAME PASSWORD", "Run update with current IP to PowerAdmin DNS panel"
	def update(username, password)
		ip = open("http://automation.whatismyip.com/n09230945.asp").read

		agent = Mechanize.new

		# Login
		agent.post("http://dns.ipserverone.com/index.php", "username" => username, "password" => password, "authenticate" => "Login")

		# Do update
		agent.post("http://dns.ipserverone.com/edit_record.php", "rid" => "16404", "zid" => "1041", "name" => "ci.internal", "type" => "A", "prio" => 0, "content" => ip, "ttl" => 3600, "commit" => "Commit changes")
	end
end