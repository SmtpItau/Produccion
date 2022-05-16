USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_TC_OPCIONES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_TC_OPCIONES](  @numero_operacion NUMERIC(10),
          @tc_calculo  NUMERIC(12,4) )
AS
BEGIN
SET NOCOUNT ON
UPDATE  mfca 
SET tc_calculo_mes_actual = @tc_calculo
WHERE canumoper = @numero_operacion
SET NOCOUNT OFF
END

GO
