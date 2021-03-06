USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABACORTES_FLI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABACORTES_FLI]
   (   @RutCartera    NUMERIC(9)
   ,   @Documento     NUMERIC(9)
   ,   @Correlativo   NUMERIC(9)
   ,   @Ventana       NUMERIC(9)
   ,   @Usuario       VARCHAR(15)
   ,   @Operacion     NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nNonCompra   FLOAT
   DECLARE @nNomVenta    FLOAT

   --  (comtocort * cocantcortd), nominal_compra

   SELECT nominal_compra
      ,   nominal_venta
      ,   comtocort
      ,   cocantcortd
      ,   cocantcorto
      ,   documento
      ,   correlativo
      ,   ventana 
      ,   CortesVendidos    = (nominal_venta / comtocort)
      ,   CortesDisponibles =  cocantcortd - (nominal_venta / comtocort)
      ,   MontoCorte        = comtocort
   FROM   DETALLE_FLI
          INNER JOIN MDCO ON conumdocu = documento and cocorrela = correlativo
   WHERE  usuario      = @Usuario
   and    ventana      = @Ventana
   and    marca        = 'S'
   AND    documento    = @Documento
   AND    correlativo  = @Correlativo

END


GO
