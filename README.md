# ClarionSemVersion
An opinionated SemVersion class for Clarion

Loosely adhering to the spec from http://semver.org.

The main purpose is to easily compare two versions in a variety of ways.

```
SemVer    SemVersion 
  CODE

IF SemVer.Compare('1.42.3', '=' , '1.42.3')
  Message('Yay, you have the same version!')
END

IF SemVer.Compare('1.42.0', '<' , '1.42.3')
  Message('Uh oh, your version is older!')
END
```

The Comparator supports basic operators: `=, <>, ~=, !=, <, >, <=, >=, =<, =>`

The class supports a simplified form of MAJOR.MINOR.PATCH.BUILD version format.
It only support numeric values in each component so for example 'v1.2.3' will not work. Similarly, '0.0.1-build22' will likely fail to do what you want.

There is also a Parse method which you can use that might be handy:

```
SemVer    SemVersion 
  CODE

  SemVer.Parse(SemVer.version1, '1.12.33')
  Console.WriteLine('major=' & SemVer.version1.major)
  Console.WriteLine('minor=' & SemVer.version1.minor)
  Console.WriteLine('patch=' & SemVer.version1.patch)
  Console.WriteLine('build=' & SemVer.version1.build)
```

This repo contains a few tests in the supplied ClaEvaluate console program. Fire it up and see if you can break something then submit a patch!! :)