USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROCPAR]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PROCPAR]
 ( @szPar CHAR(30))
AS
BEGIN
 SELECT SysColumns.Name, SysColumns.Type, SysColumns.Prec, SysColumns.Length
  FROM  SysObjects, SysColumns
  WHERE SysObjects.Name = @szPar
  AND SysObjects.Id = SysColumns.Id
  ORDER BY SysColumns.ColId
END

GO
