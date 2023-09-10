:global RSIsReadyToConnect;
:if ( $RSIsReadyToConnect = true ) do {
  :global SECRET;
  :global RSFetchMode;
  :global RSBaseUrl;

  :local natrulenumber;
  :set natrulenumber 4;

  :local filename;
  :set filename "flash/packetscount-$natrulenumber.txt";

  :local packetscount;
  :set packetscount [/ip firewall nat get value-name=packets number=4];
  :local lastpacketscount;
  :set lastpacketscount [/file get $filename contents]; /file set $filename contents=$packetscount;

  :if (($packetscount > $lastpacketscount) || ($lastpacketscount != 0 && $packetscount = 0) ) do={
    /tool fetch url="$RSBaseUrl/packets-count/update" mode="$RSFetchMode" \
      http-header-field="Content-Type: application/json,Authorization: Bearer $[$SECRET get "rs-access-token"]" \
      http-data="{\"nat_rule_number\": $natrulenumber, \"packets_count\": $packetscount}"
  }
}
