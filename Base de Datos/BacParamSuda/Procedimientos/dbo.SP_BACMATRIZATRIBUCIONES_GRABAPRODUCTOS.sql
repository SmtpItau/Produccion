USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_GRABAPRODUCTOS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_GRABAPRODUCTOS]
         (@Usuario  char(15),
   @Codigo_Producto char(5),
   @Plazo_Desde  numeric(5,0),
   @Plazo_Hasta  numeric(5,0),
   @MontoInicio  numeric(19,4),
   @MontoFinal  numeric(19,4)) 
AS 
BEGIN
 SET NOCOUNT ON
 
 INSERT INTO MATRIZ_ATRIBUCION
         (Usuario,
   Codigo_Producto,
   Plazo_Desde,
   Plazo_Hasta,
   MontoInicio,
   MontoFinal)
  VALUES
         (@Usuario,
   @Codigo_Producto,
   @Plazo_Desde,
   @Plazo_Hasta,
   @MontoInicio,
   @MontoFinal) 
 SET NOCOUNT OFF
END
-- SP_BacMatrizAtribuciones_GRABAPRODUCTOS 7,1,30,1,7.000
-- SELECT * FROM Matriz_Atribucion
GO
