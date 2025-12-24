unit worker;

interface

uses
  classes, 
  sysutils;

type
  TWorkerThread = class(TThread)
  private
    FThreadName: String;
    FCount: Integer;
  protected
    procedure Execute; override;
  public
    constructor Create(const AName: String; ACount: Integer);
  end;

implementation

constructor TWorkerThread.Create(const AName: String; ACount: Integer);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  FThreadName := AName;
  FCount := ACount;
end;

procedure TWorkerThread.Execute;
var
  I: Integer;
begin
  for I := 1 to FCount do
  begin
    if Terminated then Break;

    WriteLn(Format('[%s] Count: %d', [FThreadName, I]));
    Sleep(500);
  end;

  WriteLn(Format('[%s] Finished!', [FThreadName]));
end;

end.
