program main;

uses
{$IFDEF UNIX}
  cthreads,
{$ENDIF}
  sysutils, 
  greeter, 
  calculator, 
  worker;

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

procedure DemoThreads;
var
  Thread1, Thread2, Thread3: TWorkerThread;
begin
  WriteLn;
  WriteLn('Starting threads...');

  Thread1 := TWorkerThread.Create('Thread-1', 5);
  Thread2 := TWorkerThread.Create('Thread-2', 5);
  Thread3 := TWorkerThread.Create('Thread-3', 5);

  WriteLn('Main thread waiting...');

  Sleep(3000);

  WriteLn('All threads completed!');
end;

begin
  ShowMessage;
  CalculateSum;
  DemoThreads;
end.
