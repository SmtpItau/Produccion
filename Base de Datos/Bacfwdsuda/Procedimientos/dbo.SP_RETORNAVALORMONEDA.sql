USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNAVALORMONEDA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RETORNAVALORMONEDA]
   (   @iMoneda   NUMERIC(5)   
   ,   @dFecha    DATETIME
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iValorMoneda   NUMERIC(21,4)
   SELECT  @iValorMoneda   = 0.0

   SELECT  @iValorMoneda   = ISNULL(vmvalor,0.0)
   FROM    bacparamsuda..VALOR_MONEDA
   WHERE   vmfecha         = @dFecha
   AND     vmcodigo        = @iMoneda

   SELECT  @iValorMoneda

END

GO
