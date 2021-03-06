USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_AJUSTAR_CaCAJA_ANULACION]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_AJUSTAR_CaCAJA_ANULACION] ( @NUM_CONTRATO numeric(20))
AS BEGIN
	SET NOCOUNT ON
	Declare @TOTAL  numeric(20,10)
	Declare @TOTAL_TRUNCADO numeric(20,10)
	Declare @DEC numeric(1)
	Declare @DIF numeric(20,10)
        DECLARE @COD_MON numeric (5)

	select @TOTAL = SUM(CaCajMtoMon1) 
	from dbo.CaCaja
	Where CaNumContrato = @NUM_CONTRATO AND CaCajOrigen = 'PA'

        SELECT @COD_MON = CaCajMdaM1 
        FROM dbo.CaCaja
        Where CaNumContrato = @NUM_CONTRATO AND CaCajOrigen = 'PA'

	Select  @DEC = mndecimal 
	from lnkbac.BacParamsuda.dbo.moneda 
	WHERE mncodmon = @COD_MON

	UPDATE dbo.CaCaja
	SET CaCajMtoMon1 = dbo.FN_TRUNCATE_DECIMALS(CaCajMtoMon1 , @DEC)
	Where CaNumContrato = @NUM_CONTRATO AND CaCajOrigen = 'PA'


	select @TOTAL_TRUNCADO = SUM(CaCajMtoMon1) 
	from dbo.CaCaja
	Where CaNumContrato = @NUM_CONTRATO AND CaCajOrigen = 'PA'

	Set @DIF = round((@TOTAL - @TOTAL_TRUNCADO), @DEC)

	IF (Select COUNT(CaCajMtoMon1) from dbo.CaCaja Where CaNumContrato = @NUM_CONTRATO ) > 1
	BEGIN
	     Update dbo.CaCaja
	     SET CaCajMtoMon1 = CaCajMtoMon1 + @DIF
	     WHERE CaNumContrato = @NUM_CONTRATO AND CaCajOrigen = 'PA' AND CaNumEstructura = 1 
	END
	ELSE BEGIN
	    Update dbo.CaCaja
	    SET CaCajMtoMon1 = CaCajMtoMon1 + @DIF
	    WHERE CaNumContrato = @NUM_CONTRATO AND CaCajOrigen = 'PA'
	END
	SET NOCOUNT OFF
END

GO
