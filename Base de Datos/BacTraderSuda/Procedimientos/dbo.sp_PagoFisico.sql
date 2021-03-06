USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_PagoFisico]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[sp_PagoFisico] ( @FechaPago DATETIME, @ForPago INT, @dFecha DATETIME OUTPUT)
AS

BEGIN
   SET NOCOUNT ON
   DECLARE @dFecSalida DATETIME, @nDiasValor INT

   Select @nDiasValor = diasvalor From View_forma_de_pago Where codigo = @ForPago
--   If @ForPago = 100 Or @ForPago = 4 Or @ForPago = 106 Or @ForPago = 104
   If @nDiasValor = 0
      Select @dFecSalida = @FechaPago
   Else begin
     Select @dFecSalida = Dateadd(DAY,@nDiasValor,@FechaPago)
     EXECUTE dbo.sp_diahabil @dFecSalida OUTPUT 
   end

   SELECT @dFecha = CONVERT(DATETIME,@dFecSalida,103)
   SET NOCOUNT OFF
END
-- Base de Datos --
GO
