  PROGRAM

  Include('ConsoleSupport.inc'),ONCE
  Include('SemVersion.inc'),ONCE

  MAP
Main    PROCEDURE()
TestCompare PROCEDURE(STRING pV1, STRING pComparator, STRING pV2, BYTE pShouldBe)
  END
Console   ConsoleSupport
SemVer    SemVersion 

  CODE
  Main()

Main                    PROCEDURE()
  CODE
  
  IF Console.Init() 
    Halt()
  END
  
  Console.WriteLine('======= Testing ClarionSemVer =======')
  SemVer.Parse(SemVer.version1, '1.12.33')
  Console.WriteLine('major=' & SemVer.version1.major)
  Console.WriteLine('minor=' & SemVer.version1.minor)
  Console.WriteLine('patch=' & SemVer.version1.patch)
  Console.WriteLine('build=' & SemVer.version1.build)


  Console.WriteLine('---- Equals or Not ----')
  TestCompare('1.0.0.0', '=', '1.0.0.0', TRUE)
  TestCompare('1.0.0.0', '!=', '1.0.0.0', FALSE)
  TestCompare('1.1.0.0', '=', '1.0.0.0', FALSE)
  TestCompare('1.1.0.0', '!=', '1.0.0.0', TRUE)
  TestCompare('1', '=', '1.0.0.0', FALSE)
  TestCompare('1', '<>', '1.0.0.0', TRUE)

  Console.WriteLine('---- Same versions ----')

  TestCompare('1.0.0.0', '>', '1.0.0.0', FALSE)
  TestCompare('1.0.0.0', '=>', '1.0.0.0', TRUE)
  TestCompare('1.0.0.0', '<', '1.0.0.0', FALSE)
  TestCompare('1.0.0.0', '=<', '1.0.0.0', TRUE)

  Console.WriteLine('---- Greater on the left ----')

  TestCompare('1.1.0.0', '>', '1.0.0.0', TRUE)
  TestCompare('1.1.0.0', '=>', '1.0.0.0', TRUE)
  TestCompare('1.1.0.0', '<', '1.0.0.0', FALSE)
  TestCompare('1.1.0.0', '=<', '1.0.0.0', FALSE)

  Console.WriteLine('---- Greater on the right ----')

  TestCompare('1.0.0.0', '>', '1.1.0.0', FALSE)
  TestCompare('1.0.0.0', '=>', '1.1.0.0', FALSE)
  TestCompare('1.0.0.0', '<', '1.1.0.0', TRUE)
  TestCompare('1.0.0.0', '=<', '1.1.0.0', TRUE)

  Console.WriteLine('---- Some other variants ----')
  TestCompare('1.2.0.0', '>', '1.0.55.123', TRUE)
  TestCompare('1.2.0.0', '<', '1.0.55.123', FALSE)
  TestCompare('1.0.123.456', '>', '1.5.0.0', FALSE)
  TestCompare('1.0.123.456', '<', '1.5.0.0', TRUE)
  TestCompare('0.0.0', '=', '0.0.0', TRUE)
  TestCompare('0.0.0', '!=', '0.0.0', FALSE)
  TestCompare('0.0.0', '>=', '0.0.0', TRUE)
  TestCompare('0.0.0', '<=', '0.0.0', TRUE)
  TestCompare('0.0.0', '>', '0.0.0', FALSE)
  TestCompare('0.0.0', '<', '0.0.0', FALSE)

  TestCompare('0.0.1', '=', '0.0.0', FALSE)
  TestCompare('0.0.1', '!=', '0.0.0', TRUE)
  TestCompare('0.0.1', '>=', '0.0.0', TRUE)
  TestCompare('0.0.1', '<=', '0.0.0', FALSE)
  TestCompare('0.0.1', '>', '0.0.0', TRUE)
  TestCompare('0.0.1', '<', '0.0.0', FALSE)

  TestCompare('0.0.1', '=', '0.0.2', FALSE)
  TestCompare('0.0.1', '!=', '0.0.2', TRUE)
  TestCompare('0.0.1', '>=', '0.0.2', FALSE)
  TestCompare('0.0.1', '<=', '0.0.2', TRUE)
  TestCompare('0.0.1', '>', '0.0.2', FALSE)
  TestCompare('0.0.1', '<', '0.0.2', TRUE)
  Console.ReadKey()

TestCompare   PROCEDURE(STRING pV1, STRING pComparator, STRING pV2, BYTE pShouldBe)
result BYTE
  CODE
  
  result = SemVer.Compare(pV1, pComparator, pV2)
  Console.WriteLine('Comparing ' & pV1 & ' ' & pComparator & ' ' & pV2 & ' ' & |
  Choose(result=pShouldBe, 'PASSED!', 'FAILED ): (Should be ' & Choose(pShouldBe, 'TRUE', 'FALSE') & ')'))
  
