import sys

def validate():
    fobj = open("simple_conns_host.log")
    print "validating the log file..."
    riskyhosts = []
    hosts = ["192.168.178.*","192.168.2.*"]
    for line in fobj:
        if line.rstrip().startswith('#') == False:
            unknownhost = True
            for host in hosts:
                p = re.compile(host)
                if p.match(line.rstrip()):
                    unknownhost = False
            if unknownhost == True:
                riskyhosts.append(line.rstrip())
    fobj.close()
    return riskyhosts

def printresult(riskyhosts, result):
     print prefix + ": {\"result\": " + result + ", \"info\": {\"risky_hosts\": [" + ", ".join(riskyhosts) + "]}}"



if __name__ == "__main__":
    if len(sys.argv) == 2:
        prefix = sys.argv[1]
        riskyhosts = validate()
        if len(riskyhosts)==0:
            printresult(riskyhosts,"CLEAN")
        elif len(riskyhosts)<3:
            printresult(riskyhosts,"SUSPICIOUS")
        else:
            printresult(riskyhosts,"MALICIOUS")


    else:
        print "ID is missing!"
