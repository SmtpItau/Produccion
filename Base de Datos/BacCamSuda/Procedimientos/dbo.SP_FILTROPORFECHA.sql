USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTROPORFECHA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FILTROPORFECHA]
 (    @FECHAINICIO DATETIME,
      @FECHAVENCIMIENTO DATETIME)
AS   
BEGIN
 SET NOCOUNT ON
 
 SELECT  LINEA_TRANSACCION.numerooperacion
               ,LINEA_TRANSACCION.rut_cliente
               ,LINEA_TRANSACCION.id_sistema
               ,'GLOSA'    =    (    SELECT PRODUCTO.id_sistema
                                           ,PRODUCTO.nombre_sistema 
                                       FROM PRODUCTO 
                                      WHERE PRODUCTO.id_sistema    = SISTEMA_CNT.id_sistema )
                                           ,LINEA_TRANSACCION.tipo_operacion
                                           ,LINEA_TRANSACCION.fechainicio
                                           ,LINEA_TRANSACCION.fechavencimiento
                                           ,LINEA_TRANSACCION.montotransaccion
                                           ,LINEA_TRANSACCION.operador
     FROM LINEA_TRANSACCION 
       WHERE LINEA_TRANSACCION.fechainicio = @FECHAINICIO  
        AND LINEA_TRANSACCION.fechavencimiento = @FECHAVENCIMIENTO
   
 SET NOCOUNT OFF       
END
GO
