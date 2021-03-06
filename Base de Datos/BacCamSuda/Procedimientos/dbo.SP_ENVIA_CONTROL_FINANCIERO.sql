USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENVIA_CONTROL_FINANCIERO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ENVIA_CONTROL_FINANCIERO](
      @tipo_Oper CHAR(1)  ,
      @Monto  NUMERIC(21,04) ,
      @tipo_cambio NUMERIC(12,04) ,
      @mercado CHAR(4)  ,
      @usuario CHAR(15) ,
      @sistema CHAR(03)
          )
AS 
BEGIN
 SET NOCOUNT ON
 
 INSERT INTO view_aprobacion_hedge( Tipo_Operacion ,
      Monto_Operacion ,
      Tipo_Cambio ,
      Mercado  ,
      Usuario  ,
      Sistema  
      )
 VALUES( CASE @tipo_Oper WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END ,
  @Monto       ,
  @Tipo_Cambio      ,
  @mercado      ,
  @usuario      ,
  @sistema
  )
 
 SET NOCOUNT OFF
END

GO
