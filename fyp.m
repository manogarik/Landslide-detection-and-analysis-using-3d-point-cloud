function fyp()

c=lasdata('points (16).las');
d=lasdata('points (17).las');
disp(length(c.x));
disp(length(d.x));
%figure;
%plot_xyz(c);
%figure; 
%plot_xyz(d);
xlimit=[min(c.x) max(c.x)];
disp(xlimit(1));
sprintf('%.30f',xlimit(1))
ylimit=[min(c.y) max(c.y)];

sprintf('%.30f',ylimit(1))
sprintf('%.30f',ylimit(2))

x_range=xlimit(2)-xlimit(1);
y_range=ylimit(2)-ylimit(1);
disp(x_range);
disp(y_range);
%fname='data1.ply';
%fid = fopen(fname, 'w');
%for i=1:length(c.x)
%   fprintf(fid,'%g %g %g\n',c.x(i),c.y(i),c.z(i));
%end   
%fclose(fid);
%fname='data2.ply';
%fid = fopen(fname, 'w');
%for i=1:length(d.x)
%       fprintf(fid,'%g %g %g\n',d.x(i),d.y(i),d.z(i));
%end  

%fclose(fid);
pt1=[c.x(:),c.y(:),c.z(:)];
pt2=[d.x(:),d.y(:),d.z(:)];
dem1=zeros(round(x_range)+1,round(y_range));
for i=1:length(c.x)
    %disp(round(c.x-xlimit(1)));
   
    dem1(round(c.x(i)-xlimit(1)+1),round(c.y(i)-ylimit(1)+1))=c.z(i);
end
for i=1:round(x_range+1)
    xarr(i)=i;
end

for i=1:round(y_range+1)
    yarr(i)=i;
end
figure('Name','Pcplot: Before landslide') ;
pcshow(pt1);
savefig('pcbefore.fig');
figure('Name','Pcplot: After landslide');
pcshow(pt2);

if length(yarr) ~= size(dem1,2) || length(xarr) ~= size(dem1,1)
disp(length(xarr));
disp(size(dem1,2));
disp(length(yarr));
disp(size(dem1,1));
end

figure('Name','DEM: Before landslide');
dem(yarr,xarr,dem1);     
savefig('dembefore.fig');
%----------dem222------------
xlimit2=[min(d.x) max(d.x)];
disp(xlimit2(1));
%sprintf('%.30f',xlimit(1))
ylimit2=[min(c.y) max(c.y)];
x_range2=xlimit2(2)-xlimit2(1);
y_range2=ylimit2(2)-ylimit2(1);

dem2=zeros(round(x_range2)+1,round(y_range2));
for i=1:length(d.x)
    %disp(round(c.x-xlimit(1)));
   
    dem2(round(d.x(i)-xlimit2(1)+1),round(d.y(i)-ylimit2(1)+1))=d.z(i);
end
for i=1:round(x_range2+1)
    xarr2(i)=i;
end
for i=1:round(y_range2+1)
    yarr2(i)=i;
end
figure('Name','DEM: After landslide');
dem(yarr2,xarr2,dem2);
savefig('demafter.fig');

%%%%%--------------saving dem as mat------
save('dem.mat','dem2')


%%%%%--------saving as tiff--------
%figure('Name','trial tiff');
%imwrite(dem2,'ls.tif','tif');
%imshow('ls.tiff')
%------------dod----------
xmini=min(xlimit(1),xlimit2(1));
xmaxi=max(xlimit(2),xlimit2(2));
ymini=min(ylimit(1),ylimit2(1));
ymaxi=max(ylimit(2),ylimit2(2));
dod_xrange=round(xmaxi-xmini);
dod_yrange=round(ymaxi-ymini);
%dem2=zeros(round(dod_xrange)+1,round(dod_yrange)+1);

for i=1:length(d.x)
    %disp(round(c.x-xlimit(1)));
   
    dod(round(d.x(i)-xmini+1),round(d.y(i)-ymini+1))=d.z(i);
end
for i=1:length(c.x)
    %disp(round(c.x-xlimit(1)));
   
    dod(round(c.x(i)-xmini+1),round(c.y(i)-ymini+1))=dod(round(c.x(i)-xmini+1),round(c.y(i)-ymini+1))-c.z(i)*(-1);
    %disp(dod(round(c.x(i)-xmini+1),round(c.y(i)-ymini+1)));
end
for i=1:round(dod_xrange+1)
    dodx(i)=i;
end
for i=1:round(dod_yrange+1)
    dody(i)=i;
end
demelevation=[min(dod(:)) max(dod(:))];
figure('Name','Difference of DEM');
dem(dody,dodx,dod);
count=1;
volume=0;
for i=1:length(dodx)
    for j=1:length(dody)
        trialx(count)=i+xmini;
        trialy(count)=j+ymini;
        trialz(count)=dod(i,j);
        if trialz(count)>0
            volume=volume+trialz(count);
        end
        count=count+1;
    end
end
%median=volume/(length(dodx)*length(dody))
volume=volume/14.63;
god=[trialx(:),trialy(:),trialz(:)];
figure('Name','Pcplot: DoD');
disp('median');
pcshow(god);
savefig('dod.fig');
%------------median---------
vert_median=zeros(1,1);
med=median(trialz,2)

vert_median(1,1)=med;
save('median.mat','vert_median')


%----------volume-----------
save('dod.mat','dod')
systemCommand = ['C:\Users\gurus\AppData\Local\Programs\Python\Python38\python.exe volume.py']
[sts1,vol ] =system(systemCommand)
%disp('trying to print');
%disp(vol);
%14.63 pts/msq 4.8737e+09
%sprintf('%.3f m3',median)



%-----------slope-----------
systemCommand = ['C:\Users\gurus\AppData\Local\Programs\Python\Python38\python.exe slope.py']
[sts2,slope ] =system(systemCommand)
avgslope=matfile('avgslope.mat')
asl=avgslope.avgslope;
disp(asl(1,1));
slope=matfile('slope.mat');
sl=slope.slope;
%whos -file slope.mat

figure('Name','Slope');

dem(yarr2,xarr2,sl);
savefig('slope.fig');
%disp(sl)

%--------------profile and plan curvature---------
systemCommand = ['C:\Users\gurus\AppData\Local\Programs\Python\Python38\python.exe curvature.py']
[sts2,curv ] =system(systemCommand)
prof_curv=matfile('prof_curv.mat');
pfc=prof_curv.prof_curv;
figure('Name','Profile Curvature');
dem(yarr2,xarr2,pfc);
savefig('prof_curv.fig');
plan_curv=matfile('plan_curv.mat');
plc=plan_curv.plan_curv;
figure('Name','Plan Curvature');
dem(yarr2,xarr2,plc);
savefig('plan_curv.fig');



%---------------roughness-------------
systemCmd = ['C:\Users\gurus\AppData\Local\Programs\Python\Python38\python.exe roughness.py']
[sts2,roughness] =system(systemCmd)
roughness=matfile('roughness.mat');
rgh=roughness.roughness;
figure('Name','Roughness');
dem(yarr2,xarr2,rgh);
savefig('rough.fig');

%disp(rgh);


%---------------hillshade-----------
systemCmd = ['C:\Users\gurus\AppData\Local\Programs\Python\Python38\python.exe hillshade.py']
[sts2,hillshade] =system(systemCmd)
hillshade=matfile('hillshade.mat');
hs=hillshade.hillshade;
figure('Name','Hillshade');
dem(yarr2,xarr2,hs);
savefig('hil_shade.fig');


%---------------dod probablistic assessment-----------
systemCmd = ['C:\Users\gurus\AppData\Local\Programs\Python\Python38\python.exe wilcoxson.py']
[sts2,wil] =system(systemCmd)
landslide_profile=matfile('landslide_profile.mat');
lprof=landslide_profile.landslide_profile;
%disp(lprof);
%disp(size(dem2));
affected_region=zeros(size(lprof,1),size(lprof,2));
cl_region=zeros(size(lprof,1),size(lprof,2));
for i=1:size(lprof,1)
    for j=1:size(lprof,2)
        if lprof(i,j)>0 & sl(i,j)>0.01 & pfc(i,j) 
            if rgh(i,j)>=2 & rgh(i,j)<7
                affected_region(i,j)=700;
                cl_region(i,j)=dem2(i,j);
            else if rgh(i,j)>=7 & rgh(i,j)<10
                    affected_region(i,j)=1200;
                    cl_region(i,j)=dem2(i,j);
                else if rgh(i,j)>=10
                        affected_region(i,j)=1500;
                        cl_region(i,j)=dem2(i,j);
                    
                    end
                end
            end
        
        end
        if affected_region(i,j)==0
            affected_region(i,j)=-300;
        end
    end
end
%disp(lprof);
%disp(affected_region);
figure('Name','Affected region');
dem(yarr2,xarr2,affected_region);
savefig('aff_region.fig');

%pcplot
alavu=size(affected_region,1)*size(affected_region,2);
%disp(size(affected_region,1));
%disp(size(affected_region,2));
%disp(alavu);
xpc=zeros(alavu,1);
ypc=zeros(alavu,1);
zpc=zeros(alavu,1);
zpcc=zeros(alavu,1);
for i=1:size(affected_region,1)
    for j=1:size(affected_region,2)
        xpc(((i-1)*size(affected_region,2)+j),1)=i;
        ypc(((i-1)*size(affected_region,2)+j),1)=j;
        zpc(((i-1)*size(affected_region,2)+j),1)=affected_region(i,j);
        zpcc(((i-1)*size(affected_region,2)+j),1)=cl_region(i,j);
    end
end
pt=[xpc(:),ypc(:),zpc(:)];
ptt=[xpc(:),ypc(:),zpcc(:)];
figure('Name','Pcplot: Affected classification') ;
pcshow(pt);
savefig('classification.fig')
figure('Name','Actual region');
dem(yarr2,xarr2,cl_region);
savefig('act_region.fig');
figure('Name','Pcplot: Actual region') ;
pcshow(ptt);
%disp(cl_region);
%--------volume of affected region------

systemCommand = ['C:\Users\gurus\AppData\Local\Programs\Python\Python38\python.exe affected_volume.py']
[sts1,aff_vol] =system(systemCommand)
ms1=msgbox(aff_vol,'Results');


%---------area of affected region-------
systemCommand = ['C:\Users\gurus\AppData\Local\Programs\Python\Python36\python.exe affected_area.py']
[sts1,aff_area] = system(systemCommand)
ms2=msgbox(aff_area,'Results');






%---------------clusters-------------
systemCmd = ['C:\Users\Monisha\AppData\Local\Programs\Python\Python36\python.exe cluster.py']
[sts2,cluster] =system(systemCmd)
X_clustered=matfile('X_clustered.mat');
cl=X_clustered.X_clustered;
cl_region=zeros(size(lprof,1),size(lprof,2));
for i=1:size(cl,1)
    for j=1:size(cl,2)
        if cl(i,j)>0 
            cl_region(i,j)=dem2(i,j)*2;
        end
    end
end
disp(cl);
%disp(cl_region);
%figure('Name','Cluster region');
%dem(yarr2,xarr2,cl_region);
%savefig('cl_region.fig');
end
