clear
clc
setFlag(1, 0);
setFlag(2, 0);
setFlag(3, 0);
%setFlag(4, 1);
run = 1;
kp = 0.8;
ki = 0.03;
kd = 0.04;
PID = [kp ki kd];
ballColor = 'Red';
Errors = [0, 0];
XE = [];
YE = [];
try
    fig = CameraProjectFig;
    set(fig,'CloseRequestFcn',@my_closereq);
    writeRun(run);
    while run == 1
        PID = [kp ki kd];
        set(handles.KPIN,'String',kp);
        set(handles.KIIN,'String',ki);
        set(handles.KDIN,'String',kd);
        writePID(PID);
        writeColor(ballColor);
        run = readRun(run);
        pause(0.5);
    end
    writeRun(run);
catch e
    disp(e);
end
delete(fig)

function setFlag(flagNum, val)
    flagFile = fopen('Flag' + string(flagNum) + '.txt','w');
	fprintf(flagFile,'%d\n',val);
    fclose(flagFile);
end
function flag = getFlag(flagNum)
    flagFile = fopen('Flag' + string(flagNum) + '.txt', 'r');
    flag = fscanf(flagFile,'%d');
    fclose(flagFile);
end
function writeRun(run)
    file = fopen('run.txt','w');
	fprintf(file,'%d\n',run);
    fclose(file);
    setFlag(1, 1);
end
function retRun = readRun(run)
    try
        if getFlag(1) == 0
            RunFile = fopen('run.txt', 'r');
            retRun = fscanf(RunFile,'%d');
            fclose(RunFile);
            setFlag(1, 1);
        else
            retRun = run;
        end
    catch
        retRun = run;
    end
end
function writePID(PID)
    if getFlag(2) == 0
        PIDfile = fopen('PID.txt','w');
        fprintf(PIDfile,'%f\n',PID);
        fclose(PIDfile);
        setFlag(2, 1);
    end
end
function writeColor(BallColor)
    if getFlag(3) == 0
        BallColorfile = fopen('ballColor.txt','w');
        fprintf(BallColorfile,BallColor);
        fclose(BallColorfile);
        setFlag(3, 1);
    end
end
function retErrors = readErrors(Errors)
    try
        if getFlag(4) == 0
            ErrorsFile = fopen('Errors.txt', 'r');
            retErrors = fscanf(ErrorsFile,'%f');
            fclose(ErrorsFile);
            setFlag(4, 1);
        else
            retErrors = Errors;
        end
    catch
        retErrors = Errors;
    end
end
function my_closereq(src,callbackdata)
% Close request function 
% to display a question dialog box 
selection = questdlg('Close The Program?','Close!?','Yes','No','Yes');
switch selection
    case 'Yes'
        delete(gcf)
        run = 0;
        assignin('base','run',run);
        clear
        clc
    case 'No'
        return 
    end
end
