clear;

noise = load('data/raytomo.mat');

xnode = noise.xnode;
ynode = noise.ynode;

selectperiods = 4:20
pnum = 0;
for ip = fliplr(selectperiods)
	pnum = pnum+1;
	tomo(pnum).phV = noise.raytomo(ip).GV;
	tomo(pnum).period = noise.raytomo(ip).period;
	tomo(pnum).avgphV = nanmean(tomo(pnum).phV(:));
	tomo(pnum).noise = true;
end

selectperiods = 0:4
for ip = selectperiods
	filename = sprintf('data/averageevent_%d.mat',ip);
	eqdata = load(filename);
	pnum = pnum+1;
	tomo(pnum).phV = eqdata.newisoGV;
	tomo(pnum).period = eqdata.periods(ip+1);
	tomo(pnum).avgphV = nanmean(tomo(pnum).phV(:));
	tomo(pnum).noise = false;
end

%figure(22)
%clf
%hold on
%ind = find([tomo(:).noise]);
%plot([tomo(ind).period],[tomo(ind).avgphV],'-ro');
%ind = find(~[tomo(:).noise]);
%plot([tomo(ind).period],[tomo(ind).avgphV],'-bo');
%
save('tomo.mat','tomo','xnode','ynode');
