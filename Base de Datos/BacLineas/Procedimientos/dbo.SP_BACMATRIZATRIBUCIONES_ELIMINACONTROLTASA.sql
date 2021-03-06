USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_ELIMINACONTROLTASA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_ELIMINACONTROLTASA]
         (
            @sistema              CHAR   (03)		,
            @codigo_producto      CHAR   (05)		,   
            @FormaPago            NUMERIC(03) = 0	,
            @Moneda               NUMERIC(03) = 0
         )
AS 
BEGIN
 SET NOCOUNT ON

 DELETE
   FROM LINEA_TASA
  WHERE Id_Sistema         = @sistema 
    AND Codigo_Producto    = @codigo_producto
    AND codigo        	   = @FormaPago
    AND mncodmon           = @Moneda

 SET NOCOUNT OFF
END
GO
