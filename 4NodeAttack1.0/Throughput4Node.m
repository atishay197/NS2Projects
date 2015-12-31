% Atishay throughput analysis
% Import trace file
t = importdata('project.tr');
% Storing size of packet recieved in packetSize
packetSize = str2double(t.textdata(:,6));
% storing time in matrix time
time = str2double(t.textdata(:,2));
% storing time in matrix time
src = str2double(t.textdata(:,3));
% storing time in matrix time
dst = str2double(t.textdata(:,4));

% 3 conditions for calculation of simlple throughput
recieve = strcmp(t.textdata(:,1),'r');
packettcp = strcmp(t.textdata(:,5),'tcp');
packet512 = packetSize(:,1) >= 512;
packetSize(:,1) = packetSize(:,1) - mod(packetSize(:,1),512);

packetLogicalArray = recieve & packettcp & packet512;

throughputPackets = [packetSize(packetLogicalArray,1)];
throughputTime = [time(packetLogicalArray,1)];

totalp = sum(throughputPackets);
maxtime = max(throughputTime);
mintime = min(throughputTime);

avgtp = 8*totalp/(maxtime - mintime)/1000;

plot (throughputTime,throughputPackets,'r-');
grid on;
xlabel ('Time (s)');
ylabel ('Throughput (kbps)');
legend('Throughput of all nodes','Location','NorthWest');
gname1 = sprintf('Throughput Analysis\nAverage throughput:%.0fkbps',avgtp);
title(gname1);