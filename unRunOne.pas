unit unRunOne;

interface

(* �����Ƿ��Ѿ����У���������򼤻��� *)
function AppHasRun(AppHandle: THandle; MapFileName: string): Boolean;

implementation

uses
  Windows, Forms, Messages;

type
  //�����ڴ�
  PShareMem = ^TShareMem;
  TShareMem = record
    AppHandle: THandle; //�������ľ��
  end;

var
  hMapFile: THandle;
  PSMem: PShareMem;

procedure CreateMapFile(MapFileName: string);
begin
  hMapFile := OpenFileMapping(FILE_MAP_ALL_ACCESS, False, PChar(MapFileName));
  if hMapFile = 0 then
  begin
    hMapFile := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0,
      SizeOf(TShareMem), PChar(MapFileName));
    PSMem := MapViewOfFile(hMapFile, FILE_MAP_WRITE or FILE_MAP_READ, 0, 0, 0);
    if PSMem = nil then
    begin
      CloseHandle(hMapFile);
      Exit;
    end;
    PSMem^.AppHandle := 0;
  end
  else
  begin
    PSMem := MapViewOfFile(hMapFile, FILE_MAP_WRITE or FILE_MAP_READ, 0, 0, 0);
    if PSMem = nil then
    begin
      CloseHandle(hMapFile);
    end
  end;
end;

procedure FreeMapFile;
begin
  UnMapViewOfFile(PSMem);
  CloseHandle(hMapFile);
end;

// MapFileName ��ǰֵֻ��������һ�����̣�ÿ��Ӧ��ȡһ����ͬ��ֵ
function AppHasRun(AppHandle: THandle; MapFileName: string): Boolean;
var
  TopWindow: HWnd;
begin
  //�������
  CreateMapFile(MapFileName);

  Result := False;
  if PSMem <> nil then
  begin
    if PSMem^.AppHandle <> 0 then
    begin
      SendMessage(PSMem^.AppHandle, WM_SYSCOMMAND, SC_RESTORE, 0);
      TopWindow := GetLastActivePopup(PSMem^.AppHandle);
      if (TopWindow <> 0) and (TopWindow <> PSMem^.AppHandle) and
        IsWindowVisible(TopWindow) and IsWindowEnabled(TopWindow) then
        begin
        SetForegroundWindow(TopWindow);
        end;
//      MessageBox(0, '�ó����Ѿ������У�','��ʾ', MB_OK+MB_ICONINFORMATION);
      Application.Terminate;
      Result := True;
    end
    else
      PSMem^.AppHandle := AppHandle;
  end;
end;

initialization
//  CreateMapFile;

finalization
  FreeMapFile;

end.
