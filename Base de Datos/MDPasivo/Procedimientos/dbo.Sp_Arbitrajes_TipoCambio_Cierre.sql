USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Arbitrajes_TipoCambio_Cierre]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Arbitrajes_TipoCambio_Cierre]
            (   @fecha_proceso       DATETIME
	    ,   @tipo_cambio_cierre  NUMERIC(19,04) = 0 OUTPUT
            )
AS
BEGIN


   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET NOCOUNT ON
   SET DATEFORMAT dmy

   DECLARE @fecha_cierre  DATETIME
   DECLARE @dolar_cierre  NUMERIC(21,04)
   DECLARE @lFlag  INTEGER

   SELECT @fecha_cierre = @fecha_proceso - DATEPART(DAY,@fecha_proceso)

   WHILE 1 = 1
   BEGIN

      EXECUTE Sp_FechaHabil @fecha_cierre, 1, @lFlag OUTPUT

      IF @lFlag = 0  -- CUANDO NO ES FERIADO
      BEGIN
         BREAK
      END 

      EXECUTE Sp_PrevHabil @fecha_cierre,1,@fecha_cierre OUTPUT

   END

   SELECT @dolar_cierre = vmvalor FROM VALOR_MONEDA WITH (NOLOCK INDEX=PK_VALOR_MONEDA) WHERE vmcodigo = 994 AND vmfecha = @fecha_cierre

   SELECT @dolar_cierre = ISNULL(@dolar_cierre,1)

   SELECT @tipo_cambio_cierre = @dolar_cierre


END

GO
