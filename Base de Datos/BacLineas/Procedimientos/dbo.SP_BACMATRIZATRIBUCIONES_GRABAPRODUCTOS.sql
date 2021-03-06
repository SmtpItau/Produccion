USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_GRABAPRODUCTOS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_GRABAPRODUCTOS]
                  (
                     @Usuario             CHAR   (  15)      ,
                     @id_Sistema          CHAR   (  03)      ,
                     @Codigo_Producto     CHAR   (  05)      ,
                     @Plazo_Desde         NUMERIC( 5,0)      ,
                     @Plazo_Hasta         NUMERIC( 5,0)      ,
                     @MontoInicio         NUMERIC(19,4)      ,
                     @MontoFinal          NUMERIC(19,4)	     ,
		     @MontoOcupado 	  NUMERIC(19,4)
                  ) 
AS 
BEGIN
 SET NOCOUNT ON
 INSERT INTO MATRIZ_ATRIBUCION_INSTRUMENTO
         (Usuario                     ,
          Id_Sistema                  ,
          Codigo_Producto             ,   
          Plazo_Desde                 ,
          Plazo_Hasta                 ,
          Monto_Maximo_Operacion      ,
          Monto_Maximo_Acumulado      ,
	  acumulado_diario
          )
  VALUES
         (@Usuario            ,
          @id_Sistema         ,
          @Codigo_Producto    ,
          @Plazo_Desde        ,
          @Plazo_Hasta        ,
          @MontoInicio        ,
          @MontoFinal	      ,
          @MontoOcupado
         ) 
 SET NOCOUNT OFF
END
GO
