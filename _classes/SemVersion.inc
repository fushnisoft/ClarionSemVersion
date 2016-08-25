semVersion_Type GROUP,TYPE
major LONG
minor LONG
patch LONG
build LONG
  END

SemVersion  CLASS(),TYPE,MODULE('SemVersion.Clw'),LINK('SemVersion.Clw',1)
version1 GROUP(semVersion_Type)
  END
version2 GROUP(semVersion_Type)
  END
Compare PROCEDURE(STRING pV1, STRING pComparator, STRING pV2) ,BYTE
Parse   PROCEDURE(semVersion_Type pVersionGroup, STRING pVersionString, <STRING pDelimiter>)
  END

! vim: set filetype=clarion: