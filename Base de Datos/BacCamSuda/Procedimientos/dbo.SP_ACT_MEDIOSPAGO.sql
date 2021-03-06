USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_MEDIOSPAGO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_ACT_MEDIOSPAGO]
   (   @NumeroOperacion   NUMERIC(9)
   ,   @fPagoEntregamos   INTEGER
   ,   @fPagoRecibimos    INTEGER
   ,   @ValutaEntregamos  DATETIME
   ,   @ValutaRecibimos   DATETIME
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = (SELECT acfecpro FROM BacCamSuda.dbo.MEAC with(nolock) )

   UPDATE BacCamSuda.dbo.MEMO
      SET moentre   = @fPagoEntregamos
      ,   movaluta1 = @ValutaEntregamos
      ,   morecib   = @fPagoRecibimos
      ,   movaluta2 = @ValutaRecibimos
    WHERE monumope  = @NumeroOperacion

   DECLARE @iFound          INTEGER
   DECLARE @TipoOperacion   CHAR(1)
   DECLARE @nCodMonOpe      INTEGER
   DECLARE @nCodMonCnv      INTEGER

       SET @iFound         = -1
   SELECT  @iFound         = 0
   ,       @TipoOperacion  = motipope
   ,       @nCodMonOpe     = ope.mncodmon
   ,       @nCodMonCnv     = cnv.mncodmon
   FROM    BacCamSuda.dbo.MEMOH                  with(nolock)
           LEFT JOIN BacParamSuda.dbo.MONEDA ope with(nolock) ON ope.mnnemo = mocodmon
           LEFT JOIN BacParamSuda.dbo.MONEDA cnv with(nolock) ON cnv.mnnemo = mocodcnv
   WHERE   monumope        = @NumeroOperacion

   IF @iFound = 0
   BEGIN
      UPDATE BacParamSuda.dbo.MDLBTR 
         SET forma_pago        = CASE WHEN @TipoOperacion = 'V' THEN @fPagoEntregamos  ELSE @fPagoRecibimos  END
         ,   fecha_vencimiento = CASE WHEN @TipoOperacion = 'V' THEN @ValutaEntregamos ELSE @ValutaRecibimos END
       WHERE fecha             = @dFechaProceso
         AND sistema           = 'BCC'
         AND numero_operacion  = @NumeroOperacion
         AND estado_envio      = 'P'
         AND moneda            = @nCodMonOpe

      UPDATE BacParamSuda.dbo.MDLBTR 
         SET forma_pago        = CASE WHEN @TipoOperacion = 'V' THEN @fPagoRecibimos  ELSE @fPagoEntregamos  END
         ,   fecha_vencimiento = CASE WHEN @TipoOperacion = 'V' THEN @ValutaRecibimos ELSE @ValutaEntregamos END
       WHERE fecha             = @dFechaProceso
         AND sistema           = 'BCC'
         AND numero_operacion  = @NumeroOperacion
         AND estado_envio      = 'P'
         AND moneda            = @nCodMonCnv
   END

END



GO
