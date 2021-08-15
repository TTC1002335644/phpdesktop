unit unCmdCli;

{
  workerman��cliģʽ�£�����������쳣�����̽��˳��������������̣�������ͣ����
}

interface

uses
  Dialogs, SysUtils, utils_dvalue, Windows, Generics.Collections, Forms,
  Classes,
  ShellAPI, OtlTask, OtlTaskControl, OtlEventMonitor, OtlComm, OtlCommon;

const
  MSG_FINISH_TASK = 1; // �˳�����

type
  TCmdCli = class
  private
    FWorkerman: TDValue;
    listProgress: TList<Cardinal>;
    listTask: TList<IOmniTaskControl>;
    OmniEventMonitor: TOmniEventMonitor;
    // ����task����������Ϣ
    procedure OmniEventMonitorTaskMessage(const task: IOmniTaskControl;
      const msg: TOmniMessage);
    procedure runCmdLine(cmdLine: string);
    // ����flash  cmd.exe����
    procedure clearFlash();
    procedure setFlash();
    // ��ʼ����������
    procedure init();
    // ����web����
    procedure startWebServer();
    // �������н���
    procedure finish();
  public
    constructor Create;
    destructor Destroy; override;
    // ����workerman����
    procedure runWork();
    // �ر�workerman����
    procedure killWork();

    // �߳�������exe���ػ�
    procedure runTask(const task: IOmniTask);
  end;

var
  cmdCli: TCmdCli;

implementation

uses
  unConfig;

{ TCmdCli }

procedure TCmdCli.clearFlash;
var
  fileName: string;
begin
  fileName := unConfig.FAppPath + 'cmd.exe';
  DeleteFile(PWideChar(fileName));
end;

constructor TCmdCli.Create;
begin
  inherited;

  listProgress := TList<Cardinal>.Create;
  listTask := TList<IOmniTaskControl>.Create;
  FWorkerman := unConfig.getWorkerman();
  OmniEventMonitor := TOmniEventMonitor.Create(nil);
  OmniEventMonitor.OnTaskMessage := OmniEventMonitorTaskMessage;

//  Self.init;
  Self.startWebServer;
  Self.runWork;
  Self.setFlash;
end;

destructor TCmdCli.Destroy;
begin
  Self.killWork;
  FWorkerman.Free;
  OmniEventMonitor.Free;
  listTask.Free;
  listProgress.Free;

//  Self.finish();

  inherited;
end;

procedure TCmdCli.finish;
var
  i: Integer;
  FTmpValue: TDValue;
  strCmdLine: string;
begin
  FTmpValue := unConfig.getFinish();
  try
    if not Assigned(FTmpValue) then
      Exit;

    for i := 0 to FTmpValue.Count - 1 do
    begin
      strCmdLine := FTmpValue.Items[i].AsString;
      Self.runCmdLine(strCmdLine);
    end;
  finally
    FTmpValue.Free;
  end;

end;

procedure TCmdCli.init;
var
  i: Integer;
  FTmpValue: TDValue;
  strCmdLine: string;
begin
  FTmpValue := unConfig.getInit();
  try
    if not Assigned(FTmpValue) then
      Exit;

    for i := 0 to FTmpValue.Count - 1 do
    begin
      strCmdLine := FTmpValue.Items[i].AsString;
      Self.runCmdLine(strCmdLine);
    end;
  finally
    FTmpValue.Free;
  end;

  Application.ProcessMessages;
  Sleep(2000);
  Application.ProcessMessages;
end;

procedure TCmdCli.killWork;
var
  i, iCount: integer;
begin
  iCount := listTask.Count - 1;
  for i := iCount downto 0 do
  begin
    listTask.Items[i].Comm.Send(1);
    OmniEventMonitor.Detach(listTask.Items[i]);
    //listTask.Items[i].Terminate(0)
  end;
  listTask.Clear;

  iCount := listProgress.Count - 1;
  for i := iCount downto 0 do
  begin
    TerminateProcess(listProgress.Items[i], 0);
    listProgress.Remove(listProgress.Items[i]);
    Application.ProcessMessages;
  end;
end;

procedure TCmdCli.OmniEventMonitorTaskMessage(const task: IOmniTaskControl;
  const msg: TOmniMessage);
var
  hProcess: Cardinal;
begin
  hProcess := msg.MsgData.AsCardinal;
  listProgress.Add(hProcess);
end;

procedure TCmdCli.runTask(const task: IOmniTask);
var
  zAppName: array [0 .. 512] of char;
  zCurDir: array [0 .. 255] of char;
  FileName, WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  iExitCode: Cardinal;
  iVisibility: integer;

  MsgData: TOmniValue;
  msgID: word;

  //�������̷߳���������Ϣ���Ƿ����˳��ź�
  procedure revTaskMsg();
  begin
    task.Comm.Receive(msgID, MsgData);
    if msgID = MSG_FINISH_TASK then
      Abort;//��ֹ��ǰ����
  end;

begin
  FileName := task.Param.Item[0].AsString;
  iVisibility := task.Param.Item[1].AsInteger;

  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb := Sizeof(StartupInfo);

  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := iVisibility;
  while True do
  begin
    CreateProcess(nil, zAppName, { pointer to command line string }
      nil, { pointer to process security attributes }
      nil, { pointer to thread security attributes }
      False, { handle inheritance flag }
      CREATE_NEW_CONSOLE or { creation flags }
      NORMAL_PRIORITY_CLASS, nil, { pointer to new environment block }
      nil, { pointer to current directory name }
      StartupInfo, { pointer to STARTUPINFO }
      ProcessInfo);

    // ���ػ�ID�Ŵ������߳�
    task.Comm.Send(0, ProcessInfo.hProcess);

    while True do
    begin
      Sleep(100);
      GetExitCodeProcess(ProcessInfo.hProcess, iExitCode);
      revTaskMsg();

      if iExitCode <> STILL_ACTIVE then
        Break;
    end;

    revTaskMsg();
  end;
end;

procedure TCmdCli.runWork;
var
  arrPHPCmd: TDValue;
  i: integer;
  progress: TProcessInformation;
  strCmdLine: string;
  task: IOmniTaskControl;
begin
  if FWorkerman.FindByPath('enable').AsInteger <> 1 then
    Exit;

  arrPHPCmd := FWorkerman.FindByPath('servers').AsArray;
  if not Assigned(arrPHPCmd) then
    Exit;

  for i := 0 to arrPHPCmd.Count - 1 do
  begin
    strCmdLine := arrPHPCmd.Items[i].AsString;
    task := CreateTask(runTask, 'runTask');
    task.Param.Add(strCmdLine);
    if FDebug = 1 then // ���Կɲ鿴������־
      task.Param.Add(SW_SHOWNORMAL)
    else // �ǵ���ģʽ���ؿ���̨
      task.Param.Add(SW_HIDE);
    OmniEventMonitor.Monitor(task); // ��������
    listTask.Add(task);
    task.Run; // ��������
  end;
end;

procedure TCmdCli.setFlash;
var
  listStr: TStringList;
begin
  listStr := TStringList.Create;
  listStr.SaveToFile(unConfig.FAppPath + 'cmd.exe');
  listStr.Free;
  //�������flash���ʱ���кڴ�����������
  SetEnvironmentVariable('ComSpec', pchar(GetCurrentDir+'/cmd.exe'));
end;

procedure TCmdCli.startWebServer;
var
  i: Integer;
  FTmpValue: TDValue;
  strCmdLine: string;
begin
  FTmpValue := unConfig.getWebServer();
  try
    if not Assigned(FTmpValue) then
      Exit;

    for i := 0 to FTmpValue.Count - 1 do
    begin
      strCmdLine := FTmpValue.Items[i].AsString;
      Self.runCmdLine(strCmdLine);
    end;
  finally
    FTmpValue.Free;
  end;

end;

procedure TCmdCli.runCmdLine(cmdLine: string);
var
  zAppName: array [0 .. 512] of char;
  zCurDir: array [0 .. 255] of char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  Self.clearFlash;
  ShellExecute(0,'open',PWideChar(cmdLine), nil, PChar(unConfig.FAppPath), SW_HIDE);
end;

initialization

finalization

end.
