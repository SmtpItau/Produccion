USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULA_MOV_TICKET_SPOT]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_ANULA_MOV_TICKET_SPOT]
       (
         @_NUM_OPERACION NUMERIC(10)
       )
AS
BEGIN 

      DECLARE  @_NUM_OPERACION_ESPEJO NUMERIC(10)     
      DECLARE @_FECHA_OPERACION DATETIME
      DECLARE @_COD_MONEDA NUMERIC
      DECLARE @_COD_MESA NUMERIC
      DECLARE @_COD_MESA_CONTRAPARTE NUMERIC
   
  
      SET @_NUM_OPERACION_ESPEJO = (SELECT Numero_Operacion
			        FROM Tbl_movTicketSpot
                                WHERE Numero_Relacion_Operacion = @_NUM_OPERACION)
      
      UPDATE Tbl_movTicketSpot
      SET Estado_Operacion = 'A' 
      WHERE Numero_Operacion = @_NUM_OPERACION OR Numero_Relacion_Operacion = @_NUM_OPERACION

      SELECT @_FECHA_OPERACION = Fecha_Operacion,
             @_COD_MESA = CodMesaOrigen,
             @_COD_MESA_CONTRAPARTE = CodMesaDestino,
             @_COD_MONEDA = CodMoneda1
      FROM   Tbl_movTicketSpot
      WHERE  Numero_Operacion = @_NUM_OPERACION 

      
             
select * from Tbl_movTicketSpot

      EXECUTE SP_UPDATE_POS_TICKET_SPOT @_FECHA_OPERACION, @_COD_MESA, @_COD_MONEDA
      EXECUTE SP_UPDATE_POS_TICKET_SPOT @_FECHA_OPERACION, @_COD_MESA_CONTRAPARTE, @_COD_MONEDA

END



GO
