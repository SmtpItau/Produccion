USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_MOV_TICKET_SPOT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_MOV_TICKET_SPOT] 
(   
    @_Fecha_Operacion DateTime,
    @_Tipo_Operacion Varchar(1),
    @_Codigo_Producto char(4),
    @_CodCarteraOrigen Smallint,
    @_CodMesaOrigen Smallint,
    @_CodCarteraDestino Smallint,
    @_CodMesaDestino Smallint,
    @_CodMoneda1 Smallint,
    @_MontoMoneda1 Float,
    @_CodMoneda2 Smallint,
    @_MontoMoneda2 Float,
    @_TipoCambio Float,
    @_Paridad Float,
    @_Precio Float,
    @_Hora Varchar(8),
    @_Usuario Varchar(10),
    @_Estado_Operacion varchar(1)

)

AS
BEGIN
    SET NOCOUNT ON

    DECLARE @_Numero_Operacion Numeric(10)
    DECLARE @_Numero_Relacion_Operacion Numeric(10)
    CREATE TABLE #Temp (VALOR SMALLINT)
    
    INSERT INTO #Temp EXECUTE sp_numeroTICKETMesa
    INSERT INTO #Temp EXECUTE sp_numeroTICKETMesa

    SET @_Numero_Operacion = (SELECT MIN(VALOR) FROM #Temp)
    SET @_Numero_Relacion_Operacion = (SELECT MAX(VALOR) FROM #Temp)   
     
    INSERT INTO Tbl_movTicketSpot  
   (    Numero_Operacion, 
        Numero_Relacion_Operacion,
        Fecha_Operacion,
        Tipo_Operacion,
        Codigo_Producto,
        CodCarteraOrigen,
        CodMesaOrigen,
        CodCarteraDestino,
        CodMesaDestino,
        CodMoneda1,
        MontoMoneda1,
        CodMoneda2,
        MontoMoneda2,
        TipoCambio,
        Paridad,
        Precio,
        Hora,
        Usuario,
        Estado_Operacion
   )
   VALUES 
  (    
      @_Numero_Operacion,
      0,
      @_Fecha_Operacion,
      @_Tipo_Operacion,
      @_Codigo_Producto,
      @_CodCarteraOrigen,
      @_CodMesaOrigen,
      @_CodCarteraDestino,
      @_CodMesaDestino,
      @_CodMoneda1,
      @_MontoMoneda1,
      @_CodMoneda2,
      @_MontoMoneda2,
      @_TipoCambio,
      @_Paridad,
      @_Precio,
      @_Hora,
      @_Usuario,
      @_Estado_Operacion
  )
  
-- > se graba la contra operacion
    INSERT INTO Tbl_movTicketSpot  
   (
        Numero_Operacion, 
	Numero_Relacion_Operacion,
        Fecha_Operacion,
        Tipo_Operacion,
        Codigo_Producto,
        CodCarteraOrigen,
        CodMesaOrigen,
        CodCarteraDestino,
        CodMesaDestino,
        CodMoneda1,
        MontoMoneda1,
        CodMoneda2,
        MontoMoneda2,
        TipoCambio,
        Paridad,
        Precio,
        Hora,
        Usuario,
        Estado_Operacion   
   )
   VALUES 
  (    
      @_Numero_Relacion_Operacion,
      @_Numero_Operacion,
      @_Fecha_Operacion,
      CASE @_Tipo_Operacion WHEN 'C' THEN 'V' ELSE 'C' END,
      @_Codigo_Producto,
      @_CodCarteraDestino,
      @_CodMesaDestino,
      @_CodCarteraOrigen,
      @_CodMesaOrigen,
      @_CodMoneda1,
      @_MontoMoneda1,
      @_CodMoneda2,
      @_MontoMoneda2,
      @_TipoCambio,
      @_Paridad,
      @_Precio,
      @_Hora,
      @_Usuario,
      @_Estado_Operacion
  )

   EXECUTE dbo.SP_UPDATE_POS_TICKET_SPOT @_Fecha_Operacion, @_CodMesaOrigen, @_CodMoneda1
   EXECUTE dbo.SP_UPDATE_POS_TICKET_SPOT @_Fecha_Operacion, @_CodMesaDestino, @_CodMoneda1
	
END

GO
