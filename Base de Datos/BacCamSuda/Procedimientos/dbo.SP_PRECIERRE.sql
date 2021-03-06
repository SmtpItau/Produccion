USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PRECIERRE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PRECIERRE]
    ( @estado  CHAR(1) )
AS
BEGIN
 DECLARE @numero INTEGER
 SET NOCOUNT ON
 IF EXISTS( SELECT * FROM memo WHERE moestatus = 'R' OR moestatus = 'P')
  BEGIN
   SELECT @estado  = ''
   SELECT @numero  = 1
  END
 ELSE
  BEGIN
   SELECT @estado = ( CASE @estado WHEN 'B' THEN 'S' ELSE '' END )
   SELECT @numero  = 0
  END
 UPDATE  MEAC  
 SET  acpcierre = @estado
 
 --IF @estado = 'S' OR @estado = ''
 -- SELECT @numero  = 0
 --ELSE
 -- SELECT @numero  = 2
 SELECT @numero
SET NOCOUNT OFF
END



GO
