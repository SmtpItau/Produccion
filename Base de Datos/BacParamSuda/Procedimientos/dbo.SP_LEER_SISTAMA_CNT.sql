USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_SISTAMA_CNT]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_Sistama_Cnt    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/
CREATE PROCEDURE [dbo].[SP_LEER_SISTAMA_CNT]
AS BEGIN
 
SET NOCOUNT ON
 SELECT id_sistema, 
        nombre_sistema,
               operativo FROM SISTEMA_CNT 
  WHERE operativo='S' AND gestion ='N'
  ORDER BY nombre_sistema
SET NOCOUNT OFF
END

GO
