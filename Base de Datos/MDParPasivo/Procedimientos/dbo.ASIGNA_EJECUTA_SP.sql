USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[ASIGNA_EJECUTA_SP]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[ASIGNA_EJECUTA_SP] AS

DECLARE @ExecSQL varchar(100)

DECLARE curProcedimientos CURSOR FOR

SELECT 'GRANT EXECUTE ON ' + NAME + ' TO ejecuta_sp' --

FROM SYSOBJECTS
WHERE TYPE = 'P' AND LEFT(NAME,2) <> 'dt' 


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
