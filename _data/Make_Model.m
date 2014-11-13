close all
clear all
clc

[UVdata, UVtext, UValldata] = xlsread('uv-vis 2.xlsx'); % all cells in spreadsheet saved as cell arrays in "alldata"
[m1,n1] = size(UValldata);
% 752 is the last row with numerical info
Wavelengths = UVdata(2:752,1);

[Mobdata, Mobtext, Moballdata] = xlsread('mobility.xlsx');

DEV = struct();
figure
hold on
for i = 1:length(Moballdata)-1
    DEV(i).File = [Moballdata{i,1}, ['.tif']];
    DEV(i).Mob = Moballdata{i,2};
    DEV(i).UV = UVdata(2:752,i+2);
    plot(Wavelengths,DEV(i).UV,'r')
end

for i = 1:length(DEV)
    DEV(i).Seg = [DEV(i).File(1:end-4), 'S.mat'];
    Segmented = AUTO_THRESH(DEV(i).File);
    save(DEV(i).Seg,'Segmented');
    if i ==10
        imtool(Segmented);
    end
end


return

disp(n1)
first_blank_vec = cellfun(@isnan,alldata(12,3:end)); %vector of 0's and 1's that say whether there is a value for "BP" in that column
last_filled = find(first_blank_vec,1,'first')+1; %returns the last column in "DIPPED", +1 is because I want last filled, not first blank
disp(last_filled)
OFET = struct(); % initialize the structure
for i = 3:last_filled %columns of spin coated devices, assumes that a plurality of devices are spun
    for j = 1:29 % rows of process variables
        cat = alldata(j,2); % category = name of process variable in row j
        cellji = alldata(j,i); % store value of that process variable in cellji
        OFET(i-2).(cat{1})=cellji{1}; %store the value of cellji in the OFET structure at i-2 because we started at 3
    end
    OFET(i-2).CoatProc='Spun';
end

[m,n] = size(OFET);
first_blank_vec = cellfun(@isnan,alldata(43,3:end)); %vector of 0's and 1's that say whether there is a value for "BP" in that column
last_filled = find(first_blank_vec,1,'first')+1; %returns the last column in "DIPPED", +1 is because I want last filled, not first blank
disp(last_filled)
for i = 3:last_filled
    for j = 33:60
        cat = alldata(j,2);
        cellji = alldata(j,i);
        OFET(i-2+n).(cat{1})=cellji{1};
    end
    OFET(i-2+n).CoatProc='Dipped';
end

[m,n]=size(OFET);
first_blank_vec = cellfun(@isnan,alldata(74,3:end)); %vector of 0's and 1's that say whether there is a value for "BP" in that column
last_filled = find(first_blank_vec,1,'first')+1; %returns the last column in "DIPPED", +1 is because I want last filled, not first blank

for i = 3:last_filled
    for j = 64:91
        cat = alldata(j,2);
        cellji = alldata(j,i);
        OFET(i-2+n).(cat{1})=cellji{1};
    end
    OFET(i-2+n).CoatProc='Dropped';
end

save('OFET.mat','OFET');