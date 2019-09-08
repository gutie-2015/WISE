clc;clear all;close all
markers = ["lef","lbd","lelb","lelb1","lps","lie","lie1","ref","rbd","relb","relb1","rps","rie","rie1"];
subjectID = ["1330","1390","1490","1430","1950","1660","1160","1970","1580","1440","1110","1770","1250","1240","1610","1840","1130","1490","1940","1390","1410","1710","1380","1630"];
SID = 2420;
% addpath('F:\github\wearable-jacket\matlab\WISE_KNT')
addpath('C:\Users\fabio\github\wearable-jacket\matlab\WISE_KNT') % fabio address
% cd(strcat('F:\github\wearable-jacket\matlab\kinect+imudata\',num2str(SID)));
cd(strcat('C:\Users\fabio\github\wearable-jacket\matlab\kinect+imudata\',num2str(SID))); % fabio address
list = dir();
spike_files=dir('*.txt');

%
%fprintf( fid, '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n','Timestamp','Kinect left shoulder flex.-ext.',...
% 'WISE left shoulder flex.-ext.','Kinect left shoulder abd.-add.','WISE left shoulder abd.-add.','Kinect left shoulder int.- ext.',...
% 'WISE left shoulder int.- ext.','Kinect left elbow flex.-ext.','WISE left elbow flex.-ext.','WISE left forearm pro.- sup.',...
% 'Kinect right shoulder flex.-ext.','WISE right shoulder flex.-ext.','Kinect right shoulder Abd.-Add.','WISE right shoulder abd.-add.',...
% 'Kinect right shoulder int.-ext.','WISE right shoulder int.-ext.','Kinect right elbow flex.-ext.','WISE right elbow flex.-ext.',...
% 'WISE right forearm pro.-sup.');

circleth = 0:1*pi/180:2*pi;
circlero = 10*ones(size(circleth));

MS = 5;
font = 15;



figure(1)
sgtitle(strcat(num2str(SID),' Kinect+WISE',' errors vs angles'));
subplot(1,2,1)
polarscatter(circleth,circlero,MS,'r','filled','DisplayName','10� Limit cirlce');
hold on
rlim([0 40])

subplot(1,2,2)
polarscatter(circleth,circlero,MS,'r','filled');
hold on
rlim([0 40])

figure(2)
sgtitle(strcat(num2str(SID),' Kinect+WISE',' errors distribution'));

tf = strcat(num2str(SID));
trfile = strcat(tf,'.txt');
fid = fopen(trfile,'wt');
        
for i = 1:length(spike_files)
    f1 = strsplit(spike_files(i).name,'.');
    f2 = strsplit(string(f1(1)),'_');
    if length(f2)>=2
    if f2(2) == "WISE+KINECT" && f2(1)==num2str(SID)
        if f2.length()>=5 && f2(3)== "testing"
            typ = f2(5);
        
        data = importWISEKINECT(spike_files(i).name);
        len = size(data,1);
        textvars = data(1,:);
        Time = zeros(len-1,1);
        lfe = zeros(len-1,2);
        lbd = zeros(len-1,2);
        lie = zeros(len-1,2);
        lelbfe = zeros(len-1,2);
        lfps = zeros(len-1,1);
        rfe = zeros(len-1,2);
        rbd = zeros(len-1,2);
        rie = zeros(len-1,2);
        relbfe = zeros(len-1,2);
        rfps = zeros(len-1,1);
        for j = 2:len 
        Time(j-1) = str2double(data(j,1));
        lfe(j-1,:) = [str2double(data(j,2)) str2double(data(j,3))];
        lbd(j-1,:) = [str2double(data(j,4)) str2double(data(j,5))];
        lie(j-1,:) = [str2double(data(j,6)) str2double(data(j,7))];
        lelbfe(j-1,:) = [str2double(data(j,8)) str2double(data(j,9))];
        lfps(j-1) = str2double(data(j,10));
        rfe(j-1,:) = [str2double(data(j,11)) str2double(data(j,12))];
        rbd(j-1,:) = [str2double(data(j,13)) str2double(data(j,14))];
        rie(j-1,:) = [str2double(data(j,15)) str2double(data(j,16))];
        relbfe(j-1,:) = [str2double(data(j,17)) str2double(data(j,18))];
        rfps(j-1) = str2double(data(j,19));
        end

        fopen(trfile,'a+');
%         rmse1 = NaN;
%         rmse2 = NaN;
%         PWise = NaN(7,1);
%         PKinect = NaN(7,1);
%         WLoc = NaN(7,1);
%         KLoc = NaN(7,1);
        
        switch(typ)

            case markers(1)
                err = abs(lfe(:,1)-lfe(:,2));
                
                figure(1)
                subplot(1,2,1)
                polarscatter(lfe(:,2)*pi/180,err,MS,'k','filled','DisplayName','Flex-Ext');  
                
                err = lfe(:,1)-lfe(:,2);
                
                k = 1;
                ind = [];
                Bin = [];
                err = lfe(:,1)-lfe(:,2);
                d = lfe(:,1)-lfe(:,2);

                while ~isempty(err)
                        ind = find(err(:)==err(1));
                        Bin(k,1) = err(1);
                        err(ind) = [];
                        ind = [];
                        k=k+1;
                end

                len = length(Bin);

                [muHat,sigmaHat] = normfit(d);
                pd = fitdist(d,'Normal');



                figure(2)
                subplot(5,2,1)
                hold on
                title(strcat("Mu = ",num2str(muHat)," ",num2str(pd.mu)," ","S = ",num2str(sigmaHat)," ",num2str(pd.sigma)," "))
                h=histogram(d);
                h.NumBins = len;
                histfit(d,len);

                [muHat,sigmaHat] = normfit(err);
                y = gaussmf(err,[sigmaHat muHat]);
                figure(2)
                
                scatter(err,y,MS,'k','filled')
                
                
                    
            case markers(2)
                err = abs(lbd(:,1)-lbd(:,2));
                figure(1)
                subplot(1,2,1)
                polarscatter(lbd(:,2)*pi/180,err,MS,'b','filled','DisplayName','Abd-Add');
                
                err = lbd(:,1)-lbd(:,2);
                
                [muHat,sigmaHat] = normfit(err);
                y = gaussmf(err,[sigmaHat muHat]);
                figure(2)
                subplot(5,2,3)
                scatter(err,y,MS,'b','filled')
                
                figure(3)
                subplot(5,2,3)
                histogram(err)
                
            case markers(3)
                err = abs(lelbfe(:,1)-lelbfe(:,2));
                figure(1)
                subplot(1,2,1)
                polarscatter(lelbfe(:,2)*pi/180,err,MS,'g','filled','DisplayName','Elb Flex-Ext');
                
                err = lelbfe(:,1)-lelbfe(:,2);
                
                [muHat,sigmaHat] = normfit(err);
                y = gaussmf(err,[sigmaHat muHat]);
                figure(2)
                subplot(5,2,5)
                scatter(err,y,MS,'g','filled')

            case markers(4)
                err = abs(lelbfe(:,1)-lelbfe(:,2));
                figure(1)
                subplot(1,2,1)
                polarscatter(lelbfe(:,2)*pi/180,err,MS,'m','filled','DisplayName','Elb Flex-Ext 2');
                
                err = lelbfe(:,1)-lelbfe(:,2);
                
                [muHat,sigmaHat] = normfit(err);
                y = gaussmf(err,[sigmaHat muHat]);
                figure(2)
                subplot(5,2,7)
                scatter(err,y,MS,'m','filled')

            case markers(5)

            case markers(6)
                
                lie(lie==666) = NaN;
                [Row] = find(isnan(lie(:,1)));
                lie(Row,:) = [];
                
                err = abs(lie(:,1)-lie(:,2));
                figure(1)
                subplot(1,2,1)
                polarscatter(lie(:,2)*pi/180,err,MS,'c','filled','DisplayName','Int-Ext Rot.');
                legend('Location','Best','FontWeight','bold','FontSize',font);
                
                err = lie(:,1)-lie(:,2);
                
                [muHat,sigmaHat] = normfit(err);
                y = gaussmf(err,[sigmaHat muHat]);
                
                figure(2)
                subplot(5,2,9)
                scatter(err,y,MS,'c','filled')
       
            case markers(7)

            case markers(8)
                err = abs(rfe(:,1)-rfe(:,2));
                figure(1)
                subplot(1,2,2)
                polarscatter(rfe(:,2)*pi/180,err,MS,'k','filled');
                
                err = rfe(:,1)-rfe(:,2);
                
                
                [muHat,sigmaHat] = normfit(err);
                y = gaussmf(err,[sigmaHat muHat]);
                figure(2)
                subplot(5,2,2)
                scatter(err,y,MS,'k','filled')

            case markers(9)
                err = abs(rbd(:,1)-rbd(:,2));
                figure(1)
                subplot(1,2,2)
                polarscatter(rbd(:,2)*pi/180,err,MS,'b','filled');
                
                err = rbd(:,1)-rbd(:,2);
                
                [muHat,sigmaHat] = normfit(err);
                y = gaussmf(err,[sigmaHat muHat]);
                figure(2)
                subplot(5,2,4)
                scatter(err,y,MS,'b','filled')
 
            case markers(10)
                err = abs(relbfe(:,1)-relbfe(:,2));
                figure(1)
                subplot(1,2,2)
                polarscatter(relbfe(:,2)*pi/180,err,MS,'g','filled');
                
                err = relbfe(:,1)-relbfe(:,2);
                
                [muHat,sigmaHat] = normfit(err);
                y = gaussmf(err,[sigmaHat muHat]);
                figure(2)
                subplot(5,2,6)
                scatter(err,y,MS,'g','filled')

            case markers(11)
                err = abs(relbfe(:,1)-relbfe(:,2));
                figure(1)
                subplot(1,2,2)
                polarscatter(relbfe(:,2)*pi/180,err,MS,'m','filled');
                
                err = relbfe(:,1)-relbfe(:,2);
                
                [muHat,sigmaHat] = normfit(err);
                y = gaussmf(err,[sigmaHat muHat]);
                figure(2)
                subplot(5,2,8)
                scatter(err,y,MS,'m','filled')
  
            case markers(12)
     
            case markers(13)
                
                rie(rie==666) = NaN;
                [Row] = find(isnan(rie(:,1)));
                rie(Row,:) = [];
                Time(length(rie)+1:length(Time)) = [];
                
                err = abs(rie(:,1)-rie(:,2));
                figure(1)
                subplot(1,2,2)
                polarscatter(rie(:,2)*pi/180,err,MS,'c','filled');
                
                err = rie(:,1)-rie(:,2);
                
                figure(2)
                subplot(5,2,10)
                [muHat,sigmaHat] = normfit(err);
                y = gaussmf(err,[sigmaHat muHat]);
                figure(2)
                scatter(err,y,MS,'c','filled')
     
            case markers(14)
          

        end
               
    fclose(fid);
    end
    end

   end 
end

