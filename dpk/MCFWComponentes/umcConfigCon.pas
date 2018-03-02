unit umcConfigCon;

interface

uses
  System.Classes;

type
  TumcConfigCon = class
  private
    FOutrasConfiguracoes: TStrings;
    FDataBase: string;
    FPassword: string;
    FUserName: string;
    FServer: string;
    FSchema: string;
    procedure SetDataBase(const Value: string);
    procedure SetOutrasConfiguracoes(const Value: TStrings);
    procedure SetPassword(const Value: string);
    procedure SetSchema(const Value: string);
    procedure SetServer(const Value: string);
    procedure SetUserName(const Value: string);
  published
    property Server: string read FServer write SetServer;
    property DataBase: string read FDataBase write SetDataBase;
    property Schema: string read FSchema write SetSchema;
    property UserName: string read FUserName write SetUserName;
    property Password: string read FPassword write SetPassword;
    property OutrasConfiguracoes: TStrings read FOutrasConfiguracoes write SetOutrasConfiguracoes;
  end;

implementation

{ TumcConfigCon }

procedure TumcConfigCon.SetDataBase(const Value: string);
begin
  FDataBase := Value;
end;

procedure TumcConfigCon.SetOutrasConfiguracoes(const Value: TStrings);
begin
  FOutrasConfiguracoes := Value;
end;

procedure TumcConfigCon.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TumcConfigCon.SetSchema(const Value: string);
begin
  FSchema := Value;
end;

procedure TumcConfigCon.SetServer(const Value: string);
begin
  FServer := Value;
end;

procedure TumcConfigCon.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

end.
