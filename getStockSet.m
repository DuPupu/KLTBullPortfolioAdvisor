function [result,tickername]=getStockSet(highCapPreference)

ticker=struct('number',0,'name','','sector','');
[tno,tnm,tsc,cap]  = importCSV('HKEquity.csv');

stockAmount=length(tno);

for(i=1:stockAmount)
    ticker(i).number=tno(i);ticker(i).name=tnm(i);ticker(i).sector=tsc(i);ticker(i).cap=cap(i);
end

screenedTicker=[];

for(i=1:stockAmount)
    switch highCapPreference
        case -1
            if(ticker(i).cap<1E9)
               screenedTicker=[screenedTicker; ticker(i)];
                
            end
        case 1
            if(ticker(i).cap>=1E9)
               screenedTicker=[screenedTicker; ticker(i)];
            end
        otherwise
               screenedTicker=[screenedTicker; ticker(i)];
    end
end
ticker=screenedTicker;
stockAmount=length([ticker.cap]);
clc;

% 
secCount=1;
secName(1)=ticker(1).sector;
secNum(1)=0;
for(i=1:stockAmount)
    
    if(strcmp(ticker(i).sector,secName(secCount))~=1)
        secCount=secCount+1;
        secName(secCount)=ticker(i).sector;
        secNum(secCount)=0;
    end
        secNum(secCount)=secNum(secCount)+1;
end
clc;

Number=[1:secCount]';
SectorName=secName';
StockCount=secNum';
sector=table(Number,SectorName,StockCount);


fin=0;
SelectedSectorNumber=[];clc

% Select Sector Number
while (fin==0)
fprintf('    <strong>Select Your Favorite Sector</strong>\n\n\n');
disp(sector);
display(SelectedSectorNumber);
i=input('Enter the number(1,2,etc...) before the sector name to select\nPress <strong>ENTER</strong> if finished. > ','s')
clc;
if(str2double(i)>=0)
    if(str2double(i)<=41)
        SelectedSectorNumber=[ SelectedSectorNumber str2num(i)];
    else
        fin=1;
    end
else
    fin=1;
end
    
clc;
end

SelectedSectorNumber=unique(SelectedSectorNumber);

SelectedTickerNo=[];


tickername={''};
%string TickerName;





for(i=1:stockAmount)
    for(j=1:length(SelectedSectorNumber))
        if (strcmp(ticker(i).sector,SectorName(SelectedSectorNumber(j))))
            SelectedTickerNo(length(SelectedTickerNo)+1)=ticker(i).number;
            tickername(length(SelectedTickerNo))=ticker(i).name;
        end
    end
end

SelectedTickerName=cell(length(SelectedTickerNo),1);

% Get Stock Name in Selected Industries.

for(i=1:length(SelectedTickerNo))
    SelectedTickerName(i)={strcat(num2str(SelectedTickerNo(i)),'.HK')};
    for(j=length(SelectedTickerName{i})+1:7)
        SelectedTickerName(i)=strcat('0',SelectedTickerName(i));
    end
    
    
end
    result=SelectedTickerName;

end

