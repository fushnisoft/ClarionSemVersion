  MEMBER

  MAP
    MODULE('Clarion RTL')
      StrTok(*CSTRING instr, *CSTRING delimit),LONG,RAW,NAME('_strtok')
    END
  END

  INCLUDE('SemVersion.inc'),ONCE

SemVersion.Compare PROCEDURE(STRING pV1, STRING pComparator, STRING pV2) !,BYTE
  CODE

  ! Deal with the easy ones first
  IF Upper(pV1) = Upper(pV2) 
    IF InList(pComparator, '=', '<=', '>=', '=>', '=<')
      RETURN TRUE
    END
    IF InList(pComparator, '>','<')
      RETURN FALSE
    END
  END

  IF Upper(pV1) <> Upper(pV2) AND (pComparator = '<>' OR pComparator = '!=' OR pComparator = '~=') 
    RETURN TRUE
  END

  SELF.Parse(SELF.version1, pV1)
  SELF.Parse(SELF.version2, pV2)

  ! This is not the prettiest way but it seems to cover everything.
  IF inString('>', pComparator, 1, 1)
    IF SELF.version1.major <> SELF.version2.major
      RETURN Choose(SELF.version1.major > SELF.version2.major)
    END
    IF SELF.version1.minor <> SELF.version2.minor
      RETURN Choose(SELF.version1.minor > SELF.version2.minor)
    END
    IF SELF.version1.patch <> SELF.version2.patch
      RETURN Choose(SELF.version1.patch > SELF.version2.patch)
    END
    IF SELF.version1.build <> SELF.version2.build
      RETURN Choose(SELF.version1.build > SELF.version2.build)
    END
  END

  IF inString('<', pComparator, 1, 1)
    IF SELF.version1.major <> SELF.version2.major
      RETURN Choose(SELF.version1.major < SELF.version2.major)
    END
    IF SELF.version1.minor <> SELF.version2.minor
      RETURN Choose(SELF.version1.minor < SELF.version2.minor)
    END
    IF SELF.version1.patch <> SELF.version2.patch
      RETURN Choose(SELF.version1.patch < SELF.version2.patch)
    END
    IF SELF.version1.build <> SELF.version2.build
      RETURN Choose(SELF.version1.build < SELF.version2.build)
    END
  END

  RETURN FALSE

SemVersion.Parse   PROCEDURE(semVersion_Type pVersionGroup, STRING pVersionString, <STRING pDelimiter>)
nullStr      &CSTRING
delimiter    CSTRING(21)
version      CSTRING(21)
workStr      &CSTRING
  CODE
  delimiter = Choose(Omitted(pDelimiter), '.', pDelimiter)
  version   = pVersionString

  ! The "workStr &=""  means we could check for a NULL result if we want to. At the moment it doesn't.
  workStr &= strtok(version, delimiter)
  pVersionGroup.major = workStr

  workStr &= strtok(nullStr, delimiter)
  pVersionGroup.minor = workStr

  workStr &= strtok(nullStr, delimiter)
  pVersionGroup.patch = workStr

  workStr &= strtok(nullStr, delimiter)
  pVersionGroup.build = workStr
