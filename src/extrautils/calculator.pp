unit Calculator;

interface

uses
  SysUtils;

type
  TCalculator = class
  public
    function Sum(FirstNum: Double; SecondNum: Double): Double;
  end;

implementation

function TCalculator.Sum(FirstNum: Double; SecondNum: Double): Double;
begin
  Result := FirstNum + SecondNum;
end;

end.
