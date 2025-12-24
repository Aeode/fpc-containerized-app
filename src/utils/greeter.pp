unit Greeter;

interface

uses 
  sysutils;

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
