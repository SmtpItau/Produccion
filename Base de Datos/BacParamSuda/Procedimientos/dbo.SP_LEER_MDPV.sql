USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_MDPV]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_MDPV    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_MDPV    fecha de la secuencia de comandos: 14/02/2001 09:58:28 ******/
CREATE PROC [dbo].[SP_LEER_MDPV]
AS
BEGIN
        SELECT   pvcodigo    , 
   pvserie     ,
          pvporcentaje 
 FROM   PORCENTAJE_VARIACION
 ORDER BY pvserie
 END
 
GO
