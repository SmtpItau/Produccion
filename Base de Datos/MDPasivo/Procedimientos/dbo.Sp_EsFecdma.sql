USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_EsFecdma]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_EsFecdma]( @amd     CHAR(6)         ,
                            @dFecaux DATETIME OUTPUT )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON
     

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
