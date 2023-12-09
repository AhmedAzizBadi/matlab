function readwvrpwvfile


%select year,month,day
ye='2022';
mm='11';
dd='17';
%select year,month,day


%READ the WVR data
yy=ye(3:4);
netCDFFile=strcat('/dsk/cha967/tschmidt/HATPRO_DATA_SAVE/DAILY/',yy,mm,dd,'.IWV.ASC');
disp( ['WVR FILE' ': ' netCDFFile])
fid  = fopen(netCDFFile);
for k=1:7 
    tline = fgetl(fid);
    if(k==2)
    count=sscanf(tline(1:6),'%f',1);
    end
end
iwv=zeros(count,1)*NaN;
hh =zeros(count,1)*NaN;
mm =zeros(count,1)*NaN;
ss =zeros(count,1)*NaN;
rain=zeros(count,1)*NaN;
for k=1:count
str0 = fscanf(fid,'%s',6);
hh(k)  = fscanf(fid,'%f',1);str0 = fscanf(fid,'%s',1);
mm(k)  = fscanf(fid,'%f',1);str0 = fscanf(fid,'%s',1);
ss(k)  = fscanf(fid,'%f',1);str0 = fscanf(fid,'%s',1);
rain(k)= fscanf(fid,'%f',1);str0 = fscanf(fid,'%s',1);
iwv(k) = fscanf(fid,'%f',1);str0 = fscanf(fid,'%s',1);
ele    = fscanf(fid,'%f',1);str0 = fscanf(fid,'%s',1);
azi    = fscanf(fid,'%f',1);
end
st = fclose(fid);
%READ the WVR data


%calculate second from start of day sod
sod  = hh * 3600 + mm * 60 + ss ;
%calculate second from start of day sod

%calculate hour of the day
hour = sod/3600;
%calculate hour of the day

%qc: detect rain and remove
idx=rain==1;
iwv(idx)=NaN;
%qc: detect rain and remove

figure(1)
plot(hour,iwv);
xlabel('hour')
ylabel('iwv [kg/m^2]')
JpegFile=strcat('plot1.jpg');
Str=['print -djpeg' num2str(100) ' ' JpegFile];
disp(Str);eval(Str);

figure(2)
plot(hour,rain);
xlabel('hour')
ylabel('rain flag')
JpegFile=strcat('plot2.jpg');
Str=['print -djpeg' num2str(100) ' ' JpegFile];
disp(Str);eval(Str);






