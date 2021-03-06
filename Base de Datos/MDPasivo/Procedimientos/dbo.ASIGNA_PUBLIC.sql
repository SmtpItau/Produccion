USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[ASIGNA_PUBLIC]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[ASIGNA_PUBLIC] AS

DECLARE @ExecSQL varchar(100)

DECLARE curProcedimientos CURSOR FOR

SELECT 'GRANT SELECT ON ' + NAME + ' TO PUBLIC' 
FROM SYSOBJECTS
WHERE XTYPE = 'V' AND UID = 1

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
