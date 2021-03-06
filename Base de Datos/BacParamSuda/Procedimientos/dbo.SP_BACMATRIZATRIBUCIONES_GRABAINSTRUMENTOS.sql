USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_GRABAINSTRUMENTOS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_GRABAINSTRUMENTOS]
         (@Usuario  char(15),
   @Codigo_Producto char(5),
   @Incodigo  char(5),
   @Plazo_Desde  numeric(5,0),
   @Plazo_Hasta  numeric(5,0),
   @MontoInicio  numeric(19,4),
   @MontoFinal  numeric(19,4)) 
AS 
BEGIN
 SET NOCOUNT ON
 
 INSERT INTO MATRIZ_ATRIBUCION_INSTRUMENTO
         (Usuario,
   Codigo_Producto,
   Incodigo,
   Plazo_Desde,
   Plazo_Hasta,
   MontoInicio,
   MontoFinal)
  VALUES
         (@Usuario,
   @Codigo_Producto,
   @Incodigo,
   @Plazo_Desde,
   @Plazo_Hasta,
   @MontoInicio,
   @MontoFinal)
 IF @@ERROR = 0 
    BEGIN
  SELECT 'OK'
    END
 ELSE
    BEGIN
  SELECT 'NO OK'
    END
        
 SET NOCOUNT OFF
END
GO
