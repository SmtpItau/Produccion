USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENVIA_CONTROL_OVERNIGHT]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ENVIA_CONTROL_OVERNIGHT](
      @usuario CHAR(15) ,
      @sistema CHAR(03)
          )
AS 
BEGIN
  
 SET NOCOUNT ON
 DECLARE @Monto   NUMERIC(21,04) ,
  @mercado CHAR(20) 
 
 SELECT  @monto = ( achedgeactualfuturo + achedgeactualspot )
 FROM meac
 INSERT INTO view_aprobacion_hedge( Tipo_Operacion ,
      Monto_Operacion ,
      Tipo_Cambio ,
      Mercado  ,
      Usuario  ,
      Sistema  
      )
 VALUES( ''  ,
  @Monto  ,
  0  ,
  'SPOT'  ,
  @usuario ,
  @sistema
  )
 
 SET NOCOUNT OFF
END

GO
