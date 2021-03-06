USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FINDBASEMONEDA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_FindBaseMoneda    fecha de la secuencia de comandos: 03/04/2001 15:18:03 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_FindBaseMoneda    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_FINDBASEMONEDA] --998
               ( @parcodmoneda NUMERIC(03) )
AS
BEGIN
 SELECT  
  'Base' = ISNULL(mnbase,0)
 FROM 
  MONEDA
 WHERE 
  ISNULL(mnmx,'')<> 'C'
 AND  mncodmon = @parcodmoneda
END
/*
Sp_FindBaseMoneda 913
*/
GO
