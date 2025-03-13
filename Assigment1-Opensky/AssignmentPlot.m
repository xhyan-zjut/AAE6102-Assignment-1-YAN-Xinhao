%% ACF
data=trackResults(4).I_multi{201};
if data(6)<0
    data=-data;
end
plot(-0.5:0.1:0.5,data,'r-');hold on;
scatter(-0.5:0.1:0.5,data,'bo');
xlabel('code delay');
ylabel('ACF');
title('ACF of Multi-correlator');

%% WLS
opensky_gt=[22.328444770087565,114.1713630049711,3];
% urban_gt=[22.3198722, 114.209101777778,3];
geobasemap satellite;
error=[];
for i=1:size(navSolutions.latitude,2)
    geoplot(navSolutions.latitude(i),navSolutions.longitude(i),'r*', 'MarkerSize', 10);hold on;
end
geoplot(opensky_gt(1),opensky_gt(2),'o','MarkerFaceColor','y', 'MarkerSize', 10,'MarkerEdgeColor','y');hold on;

v=[];
for i=1:size(navSolutions.vX,2)
   v=[v;navSolutions.vX(i),navSolutions.vY(i),navSolutions.vZ(i)] ;
end
plot(1:39,v(:,1),1:39,v(:,2));
legend('x (ECEF)','y (ECEF)')

%% KF
opensky_gt=[22.328444770087565,114.1713630049711,3];
% urban_gt=[22.3198722, 114.209101777778,3];
geobasemap satellite;
error=[];
for i=1:size(navSolutions.latitude,2)
    geoplot(navSolutions.latitude_kf(i),navSolutions.longitude_kf(i),'r*', 'MarkerSize', 10);hold on;
end
geoplot(opensky_gt(1),opensky_gt(2),'o','MarkerFaceColor','y', 'MarkerSize', 10,'MarkerEdgeColor','y');hold on;

v=[];
for i=1:size(navSolutions.vX,2)
   v=[v;navSolutions.VX_kf(i),navSolutions.VY_kf(i),navSolutions.VZ_kf(i)] ;
end
plot(1:39,v(:,1),1:39,v(:,2));
legend('x (ECEF)','y (ECEF)')