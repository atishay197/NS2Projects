% Atishay throughput analysis
% Import trace file
fid = fopen('final1.tr');
t = textscan(fid,'%s %f32 %d32 %s %d32 %s %d32 %d32 %s %d %d');
fid = fclose(fid);
% Storing size of packet recieved in packetSize
packetSize = t{7};
% storing time in matrix time
time = t{2};
% storing source node in matrix src
src = t{3};
%storing later at which packet generated at lyr
lyr = t{4};
%sequenceno in seq
seq = t{5};

% 2 conditions for calculation of simlple throughput
sent = strcmp(t{1},'s');
recieve = strcmp(t{1},'r');
dropped = strcmp(t{1},'D');
packetAODV = strcmp(t{6},'AODV');

packetLogicalArraysent = sent & packetAODV;% & packet512;
packetLogicalArrayrecieved = recieve & packetAODV;% & packet512;

%sent, recieved and dropped packets
totalsent = sum(sent);
totalrecieved = sum(recieve);
totaldropped = sum(dropped);

throughputPacketssent = [packetSize(packetLogicalArraysent,1)];
throughputTimesent = [time(packetLogicalArraysent,1)];
throughputPacketsrecieved = [packetSize(packetLogicalArrayrecieved,1)];
throughputTimerecieved = [time(packetLogicalArrayrecieved,1)];

totalpsent = sum(throughputPacketssent);
maxtimesent = max(throughputTimesent);
mintimesent = min(throughputTimesent);

totalprecieved = sum(throughputPacketsrecieved);
maxtimerecieved = max(throughputTimerecieved);
mintimerecieved = min(throughputTimerecieved);

avgtpsent = 8*totalpsent/(maxtimesent - mintimesent)/1000;
avgtprecieved = 8*totalprecieved/(maxtimerecieved - mintimerecieved)/1000;

plot (throughputTimesent,throughputPacketssent,'r.',throughputTimerecieved,throughputPacketsrecieved,'b.');
grid on;
xlabel ('Time (s)');
ylabel ('Throughput (kbps)');
legend('Sent Packets','Recieved Packets','Location','NorthWest');
gname1 = sprintf('Throughput Analysis\nAverage throughput::sent:%.0fkbps recieved:%.0fkbps',avgtpsent,avgtprecieved);
title(gname1);