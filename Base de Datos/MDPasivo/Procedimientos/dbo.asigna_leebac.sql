USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[asigna_leebac]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[asigna_leebac] AS

DECLARE @ExecSQL varchar(100)

DECLARE curProcedimientos CURSOR FOR

SELECT 'GRANT SELECT ON ' + NAME + ' TO lee_bac' 
FROM SYSOBJECTS
WHERE TYPE = 'U'
AND LEFT(NAME,3) <> 'sys' 

OPEN curProcedimientos

FETCH NEXT FROM curProcedimientos

INTO @ExecSQL


WHILE @@FETCH_STATUS = 0

BEGIN

Exec(@ExecSQL)
IF @@ERROR <> 0
BEGIN
RETURN 1 
END

Print @ExecSQL

FETCH NEXT FROM curProcedimientos INTO @ExecSQL

END

CLOSE curProcedimientos
DEALLOCATE curProcedimientos


GO
