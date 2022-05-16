USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACSWAPPARAMETROS_TRAECARTERA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BACSWAPPARAMETROS_TRAECARTERA    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_BACSWAPPARAMETROS_TRAECARTERA    fecha de la secuencia de comandos: 14/02/2001 09:58:22 ******/
CREATE PROCEDURE [dbo].[SP_BACSWAPPARAMETROS_TRAECARTERA]
AS
BEGIN
   SET NOCOUNT ON
   SET ROWCOUNT 1
   
   SELECT 
          rcrut       
         ,rcdv 
         ,rcnombre                                           
 
   FROM ENTIDAD
   SET ROWCOUNT 0
   SET NOCOUNT OFF
END
GO
