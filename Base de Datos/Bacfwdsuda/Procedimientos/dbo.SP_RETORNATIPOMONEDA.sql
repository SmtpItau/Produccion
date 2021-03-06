USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNATIPOMONEDA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RETORNATIPOMONEDA]
   (   @iMoneda   NUMERIC(5)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iEstadoMoneda   INT

   -- D: Moneda Debil
   -- M: Moneda Fuerte

   SELECT @iEstadoMoneda = CASE WHEN mnrrda = 'D' THEN 0 ELSE 1 END
   FROM   bacparamsuda..MONEDA 
   WHERE  mncodmon       = @iMoneda

   SELECT @iEstadoMoneda

END
GO
