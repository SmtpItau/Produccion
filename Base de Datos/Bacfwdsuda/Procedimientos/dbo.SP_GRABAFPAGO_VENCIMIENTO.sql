USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAFPAGO_VENCIMIENTO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAFPAGO_VENCIMIENTO]
   (   @numero_operacion NUMERIC(10)
   ,   @forma_pago       NUMERIC(5) 
   ,	@nMonedaPago		NUMERIC(9) = 0 
   )
AS
BEGIN
   SET NOCOUNT ON

   DECLARE @MiFechaVcto   DATETIME
   DECLARE	@MiFecha		DATETIME
   DECLARE	@MiDiasValor	INT
   DECLARE	@Miestado		INT

   SELECT  @MiFecha    = acfecproc 
   FROM    MFAC

   SELECT @MiDiasValor = diasvalor 
   FROM   BacParamSuda..FORMA_DE_PAGO
   WHERE  codigo       = @forma_pago

   EXECUTE BacTraderSuda..SP_BUSCA_FECHA_HABIL @MiFecha , @MiDiasValor , @MiFechaVcto OUTPUT

   SELECT @Miestado         = -1
   SELECT @Miestado         = 0
   FROM   bacparamsuda..MDLBTR    
   WHERE  sistema           = 'BFW' 
   and    numero_operacion  = @numero_operacion
   and    estado_envio      = 'P'

   IF @Miestado = 0
   BEGIN
      UPDATE bacparamsuda..MDLBTR 
      SET    forma_pago        = @forma_pago
      ,      fecha_vencimiento = @MiFechaVcto
      WHERE  sistema           = 'BFW' 
      and    numero_operacion  = @numero_operacion
      and    estado_envio      = 'P'
   END

   UPDATE  MFCA 
   SET     cafpagomn = @forma_pago
	,		cacalcmpdol	= @nMonedaPago
   WHERE   canumoper = @numero_operacion


END

GO
