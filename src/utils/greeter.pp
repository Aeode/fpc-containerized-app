unit Greeter;

interface

uses 
  SysUtils;

type
  TGreeter = class
  public
    procedure SayHello;
  end;

implementation

procedure TGreeter.SayHello;
begin
  WriteLn('Hello from Greeter');
end;

end.
