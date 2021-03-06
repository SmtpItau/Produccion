USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ESFECDMA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_EsFecdma    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_EsFecdma    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_ESFECDMA]( @amd     CHAR(6)         ,
                            @dFecaux DATETIME OUTPUT )
AS
BEGIN
     DECLARE @dd  CHAR(2)
     DECLARE @mm  CHAR(2)
     DECLARE @aa  CHAR(2)
     SET ARITHIGNORE ON
     SELECT @dd = SUBSTRING(@amd,1,2)
     SELECT @mm = SUBSTRING(@amd,3,2)
     SELECT @aa = SUBSTRING(@amd,5,2)
     IF CONVERT(INTEGER,@aa) > 50
           SELECT @dFecaux = CONVERT( DATETIME, @dd+'/'+@mm+'/'+'19'+@aa , 103 )
     ELSE
           SELECT @dFecaux = CONVERT( DATETIME, @dd+'/'+@mm+'/'+'20'+@aa , 103 )
     SET ARITHIGNORE OFF
     IF @dFecaux IS NULL
           RETURN 1
     ELSE
           RETURN 0
END
GO
