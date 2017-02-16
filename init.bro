event bro_init()
{
	print "Starting Bro...";
	local filter: Log::Filter = [$name="orig-resp-only", $path="simple_conns",$include=set("ts","id.orig_h","id.orig_p","id.resp_h","id.resp_p","service")];
  Log::add_filter(Conn::LOG, filter);
	local filter2: Log::Filter = [$name="resp-only", $path="simple_conns_resp",$include=set("ts","id.resp_h","id.resp_p","service")];
	Log::add_filter(Conn::LOG, filter2);
	local filter3: Log::Filter = [$name="port-only", $path="simple_conns_port",$include=set("id.resp_p")];
	Log::add_filter(Conn::LOG, filter3);
	local filter4: Log::Filter = [$name="port-only", $path="simple_conns_host",$include=set("id.resp_h")];
	Log::add_filter(Conn::LOG, filter4);
	print "Bro successfully started!";
}
