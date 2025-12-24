program Main;

uses 
  SysUtils, Greeter, Calculator;

procedure ShowMessage;
var
  AGreeter: TGreeter;
begin
  AGreeter := TGreeter.Create;
  try
    AGreeter.SayHello;
  finally
    AGreeter.Free;
  end;
end;

procedure CalculateSum;
var
  ACalculator: TCalculator;
  AFirstNum, ASecondNum, ATotalNum: Double;
  AMessage: String;
begin
  ACalculator := TCalculator.Create;

  try
    AFirstNum := 5;
    ASecondNum := 5;
    ATotalNum := ACalculator.Sum(AFirstNum, ASecondNum);
    AMessage := Format('%s + %s = %s', [FloatToStr(AFirstNum), FloatToStr(ASecondNum), FloatToStr(ATotalNum)]);
    WriteLn(AMessage);
  finally
    ACalculator.Free;
  end;
end;

begin
  ShowMessage;
  CalculateSum;
end.
