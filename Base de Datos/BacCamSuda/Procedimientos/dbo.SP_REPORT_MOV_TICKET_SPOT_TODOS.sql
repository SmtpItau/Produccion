USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORT_MOV_TICKET_SPOT_TODOS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_REPORT_MOV_TICKET_SPOT_TODOS]
   (   @_NUM_OPERACION   NUMERIC(10)  = 0 )
AS
BEGIN 
      SET NOCOUNT ON

      DECLARE @_NUM_OPERACION_ESPEJO NUMERIC(10)
      DECLARE @VAR_MON_1             VARCHAR(1)  
      DECLARE @_IS_STRONG_MON_1      NUMERIC(1)      

      CREATE TABLE #TempMesa 
         (   codigo       CHAR(6)
         ,   descripcion  CHAR(60)
         )
      
     SET @VAR_MON_1 = (SELECT mnrrda FROM VIEW_MONEDA 
                                           INNER JOIN TBL_MOVTICKETSPOT MOV ON  view_moneda.mncodmon = MOV.CodMoneda1
                                     WHERE Numero_Operacion = @_NUM_OPERACION) 

     SET @_IS_STRONG_MON_1 = CASE WHEN @VAR_MON_1 = 'M' THEN 1
                                  WHEN @VAR_MON_1 = 'S' THEN 1
                                  WHEN @VAR_MON_1 = 'D' THEN 0
                             END

     INSERT INTO #TempMesa 
         EXECUTE bacparamsuda.dbo.SP_CARGAMESAS

     SELECT 'Numero Operacion'   = Numero_Operacion 
      ,     'Producto'           = PROD.descripcion
      ,     'Tipo Operación'     = CASE WHEN Tipo_Operacion  = 'V' THEN 'VENTA'
                                        WHEN Tipo_Operacion  = 'C' THEN 'COMPRA' 
                                   END
      ,     'Usuario'            = Usuario 
      ,     'Mesa Origen'        = MESAORIG.descripcion
      ,     'Cartera Origen'     = 0
      ,     'Mesa Destino'       = MESADEST.descripcion
      ,     'Cartera Destino'    = 0
      ,     'Fecha Proceso'      = convert(nvarchar(10), Fecha_Operacion,105) 
      ,     'Hora'               = Hora 
      ,     'Fecha Emision'      = convert(nvarchar(10), getdate(),105)  
      ,     'Estado Operacion'   = CASE WHEN Estado_Operacion  = 'V' THEN 'VIGENTE' WHEN Estado_Operacion  = 'A' THEN 'ANULADA' END
      ,     'Moneda Operación'   = MDA1.mnnemo
      ,     'Glosa Moneda Oper'  = MDA1.mnglosa
      ,     'Monto Operacion '   = MontoMoneda1
      ,     'Moneda Contraparte' = MDA2.mnnemo
      ,     'Glosa Moneda Cont.' = MDA2.mnglosa 
      ,     'MontoMoneda2'       = MontoMoneda2
      ,     'Paridad'            = Paridad
      ,     'Tipo Cambio'        = TipoCambio 
      ,     'Monto en Dólares'   = CASE WHEN MDA1.mnrrda IN('M', 'S') THEN MontoMoneda1 * Paridad
                                        ELSE                               MontoMoneda1 / Paridad 
                                   END
      ,     'Monto en Pesos'     = CASE WHEN MDA1.mnrrda IN('M', 'S') THEN MontoMoneda1 * Paridad * TipoCambio
                                        ELSE                              (MontoMoneda1 / Paridad)* TipoCambio 
                                   END                      
     FROM TBL_MOVTICKETSPOT
          INNER JOIN VIEW_MONEDA       MDA1      ON MDA1.mncodmon        = CodMoneda1
          INNER JOIN VIEW_MONEDA       MDA2      ON MDA2.mncodmon        = CodMoneda2
          INNER JOIN #TempMesa MESAORIG          ON MESAORIG.codigo      = CodMesaOrigen
          INNER JOIN #TempMesa MESADEST          ON MESADEST.codigo      = CodMesaDestino
          INNER JOIN BacParamSuda..PRODUCTO PROD ON PROD.Id_Sistema      = 'BCC' AND PROD.codigo_producto = Tbl_movTicketSpot.Codigo_Producto
     WHERE (Numero_Operacion = @_NUM_OPERACION OR @_NUM_OPERACION = 0)

     DROP TABLE #TempMesa     

END


GO
