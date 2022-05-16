USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOSTRAR_REGION]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Mostrar_Region    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[SP_MOSTRAR_REGION]
 ( @Codigo_Pais CHAR(5)='')
AS
BEGIN
   IF @Codigo_Pais = '' BEGIN
    SELECT codigo_region, codigo_pais, nombre FROM REGION
  ORDER BY nombre
  --WHERE @Codigo_Pais = Codigo_Pais 
   END
   ELSE BEGIN
    SELECT codigo_region, codigo_pais, nombre FROM REGION
  WHERE @Codigo_Pais = codigo_pais
   ORDER BY nombre
   END
END

GO
