USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERAL_LEE_MONEDA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_General_Lee_Moneda    fecha de la secuencia de comandos: 03/04/2001 15:18:03 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_General_Lee_Moneda    fecha de la secuencia de comandos: 14/02/2001 09:58:26 ******/
CREATE PROCEDURE [dbo].[SP_GENERAL_LEE_MONEDA]
              
AS
BEGIN
   SET NOCOUNT ON
      SELECT 
          mnglosa
         ,mnnemo
         ,mnrrda
      FROM 
         MONEDA
      WHERE 
         mnmx = 'C'
   SET NOCOUNT OFF
END
GO
