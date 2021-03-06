USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_CAMPO_MONEDA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RETORNA_CAMPO_MONEDA]
   (   @cSistema       CHAR(3)   
   ,   @iMovimiento    VARCHAR(3)
   ,   @iTipMov        VARCHAR(5)
   ,   @iNumOper       NUMERIC(9)
   ,   @iCodCampo      NUMERIC(9)
   ,   @iMoneda        NUMERIC(9)   OUTPUT
   )
AS
BEGIN
   SET NOCOUNT ON

   DECLARE @iEntregamos   NUMERIC(1)

   SELECT @iEntregamos  = case when CHARINDEX('Entregamos' , descripcion_campo) > 0 then  1
                               else                                                      -1
                          end 
   FROM   bacparamsuda..CAMPO_CNT 
   WHERE  id_sistema      = @cSistema 
   AND    tipo_movimiento = @iMovimiento
   AND    tipo_operacion  = @iTipMov
   AND    codigo_campo    = @iCodCampo

   SELECT @iMoneda        = CASE WHEN @iEntregamos = 1 THEN ISNULL(venta_moneda,0)
                                 ELSE                       ISNULL(compra_moneda,0)
                            END
   FROM   bac_cnt_contabiliza
   WHERE  id_sistema      = @cSistema 
   AND    tipo_movimiento = @iMovimiento
   AND    tipo_operacion  = @iTipMov
   AND    operacion       = @iNumOper

END

GO
