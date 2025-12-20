unit Greeter;

interface

type
  TGreeter = class
    procedure SayHello;
  end;

implementation

procedure TGreeter.SayHello;
begin
  WriteLn('Hello, world!');
end;

end.
