unit unConfig;

interface

uses utils_dvalue, utils_dvalue_json, StrUtils, SysUtils, Messages,
  uCEFConstants, Forms, Windows;

const
  // APP��Ӧ��Ϣ
  YS_BROWSER_APP_SHOWDEVTOOLS = WM_APP + $101; // ��ʾ��������
  YS_BROWSER_APP_HIDEDEVTOOLS = WM_APP + $102; // ���ؿ�������
  YS_BROWSER_APP_REFRESH = WM_APP + $103; // ˢ��
  YS_BROWSER_APP_SHOW = WM_APP + $104; // ��ʾ����
  YS_BROWSER_APP_SHOWMODAL = WM_APP + $105; // modal��ʾ����
  YS_BROWSER_APP_CLOSEWIN = WM_APP + $110; // modal��ʾ����
  YS_BROWSER_APP_PHPERROR = WM_APP + $106; // php�쳣��Ϣ
  // YS_BROWSER_APP_PHPLOG = WM_APP + $107; // ��ʾPHP��־
  YS_BROWSER_APP_WINDOW_MSG = WM_APP + $108; // ���ڼ���Ϣ����
  YS_BROWSER_APP_RUNWORK = WM_APP + $109; // ��Ӧ����Work��Ϣ

  // �Ҽ��˵�������Ϣ
  YS_BROWSER_CONTEXTMENU_SHOWDEVTOOLS = MENU_ID_USER_FIRST + 1; // ��ʾ��������
  YS_BROWSER_CONTEXTMENU_HIDEDEVTOOLS = MENU_ID_USER_FIRST + 2; // ���ؿ�������
  YS_BROWSER_CONTEXTMENU_REFRESH = MENU_ID_USER_FIRST + 3; // ˢ��
  // YS_BROWSER_CONTEXTMENU_PHPLOG = MENU_ID_USER_FIRST + 4; // ��ʾPHP��־
  YS_BROWSER_CONTEXTMENU_RUNWORK = MENU_ID_USER_FIRST + 5; // ����Workerman

  // ��չ������Ϣ
  YS_BROWSER_EXTENSION_SHOW = 'extension_show'; // ��ʾ����
  YS_BROWSER_EXTENSION_SHOWMODAL = 'extension_showmodal'; // modal��ʾ����
  YS_BROWSER_EXTENSION_CLOSEWIN = 'extension_closeWin'; // �رմ���
  YS_BROWSER_EXTENSION_WINDOW_MSG = 'windows_msg';

var
  FIndexUrl: string; // ��������ַ
  FAppPath: string; // Ӧ��Ŀ¼
  FSkinFile: string; // Ƥ���ļ�·��
  FDataBaseFile: string; // ���ݿ��ļ�·��
  FDebug: Integer; // �Ƿ�������ģʽ
  FWidth: Integer; // �����ڿ��
  FHeight: Integer; // �����ڸ߶�
  FCaption: string; // �����ڱ���
  FHost: string; // ����IP
  FDataPort: Integer; // ���ݿ�˿�
  FWebPort: Integer; // web�˿�
  FIcon: string; // ����icon
  FStartup_Max: Integer; // �����������
  // FWsPort: Integer; // websocket����˿�
  // FWsPHPUrl: string; // websocket������PHP·��

  // abs���ݿ������

//procedure create_db_server(); stdcall; external 'server_db.dll';
//procedure db_server_start(iPort: Integer); stdcall; external 'server_db.dll';
//procedure db_server_stop(); stdcall; external 'server_db.dll';
//procedure free_db_server(); stdcall; external 'server_db.dll';

// websocket������
// procedure create_ws_server(); stdcall; external 'server_ws.dll';
//
// procedure ws_server_start(iPort: Integer;iHttpPort: Integer); stdcall; external 'server_ws.dll';
//
// procedure ws_server_stop(); stdcall; external 'server_ws.dll';
//
// procedure free_ws_server(); stdcall; external 'server_ws.dll';

function getWorkerman(): TDValue;
function getInit(): TDValue;
function getFinish(): TDValue;
function getWebServer(): TDValue;

implementation

const
  jsonConfigFile: string = 'config.json';

function getValue(key: string): string;
var
  lvData, lvTmp: TDValue;
begin
  if not FileExists(jsonConfigFile) then
  begin
    Result := '';
    Exit;
  end;

  lvData := TDValue.Create();
  try
    JSONParseFromUtf8NoBOMFile(jsonConfigFile, lvData);
    lvTmp := lvData.FindByName(key);
    if Assigned(lvTmp) then
      Result := lvTmp.AsString
    else
      Result := '';
  finally
    lvData.Free;
  end;
end;

function getConfigValue(key: string): TDValue;
var
  lvData, lvTmp: TDValue;
begin
  if not FileExists(jsonConfigFile) then
  begin
    Result := TDValue.Create(vntArray);
    Exit;
  end;

  lvData := TDValue.Create();
  try
    JSONParseFromUtf8NoBOMFile(jsonConfigFile, lvData);
    lvTmp := lvData.FindByName(key);
    if Assigned(lvTmp) then
      Result := lvTmp.Clone()
    else
      Result := TDValue.Create(vntObject);
  finally
    lvData.Free;
  end;
end;

function getWorkerman(): TDValue;
begin
  Result := getConfigValue('workerman');
end;

function getInit(): TDValue;
begin
  Result := getConfigValue('init');
end;

function getFinish(): TDValue;
begin
  Result := getConfigValue('finish');
end;

function getWebServer(): TDValue;
begin
  Result := getConfigValue('web_server');
end;

initialization

FAppPath := ExtractFilePath(Application.ExeName);
FIcon := FAppPath + unConfig.getValue('icon');
FSkinFile := FAppPath + unConfig.getValue('skin');
FDataBaseFile := FAppPath + unConfig.getValue('database');
FDebug := StrToIntDef(unConfig.getValue('debug'), 0);
FWidth := StrToIntDef(unConfig.getValue('width'), 1024);
FHeight := StrToIntDef(unConfig.getValue('height'), 800);
FCaption := unConfig.getValue('title');
FHost := unConfig.getValue('host');
FDataPort := StrToIntDef(unConfig.getValue('data_port'), 46151);
FWebPort := StrToIntDef(unConfig.getValue('web_port'), 46150);
FIndexUrl := Format('http://127.0.0.1:%d/%s',
  [FWebPort, unConfig.getValue('url')]);
FStartup_Max := StrToIntDef(unConfig.getValue('startup_max'), 0);
// FWsPort := StrToIntDef(unConfig.getValue('ws_port'), 46152);
// FWsPHPUrl := unConfig.getValue('ws_php_url');

finalization

end.
