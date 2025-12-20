program Main;

uses
  sysutils, greeter;

var 
  App: TGreeter;

begin
  App := TGreeter.Create;
  try
    App.SayHello;
  finally
    App.Free;
  end;

end.
