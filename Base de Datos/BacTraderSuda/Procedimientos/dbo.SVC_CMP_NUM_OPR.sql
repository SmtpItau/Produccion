USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_CMP_NUM_OPR]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_CMP_NUM_OPR]
   (   @NUMERO_OPER NUMERIC(10)
	,	@sOrigen		VARCHAR(01)  --> Corresponde al proceso  que se este generando 
	
   )
AS
BEGIN


   IF NOT EXISTS(SELECT 1 FROM MDMO WHERE MONUMOPER = @NUMERO_OPER)
   BEGIN
      SELECT -1, 'No existe ese nùmero de operación'
      RETURN
   END IF EXISTS(SELECT 1 FROM MDMO WHERE MONUMOPER = @NUMERO_OPER AND MOTIPOPER <> 'FLI')
   BEGIN
      SELECT -2, 'Operaciòn no es Liquidez Intraday'
      RETURN
	END IF EXISTS(SELECT 1 FROM MDMO WHERE monumoper = @numero_oper AND mostatreg ='P')
	BEGIN
		SELECT -4, 'Operaciòn no ha sido aprobada'
		RETURN
   END  IF NOT EXISTS(SELECT 1 FROM MDMO,MDVI WHERE MONUMOPER = @NUMERO_OPER and VINUMOPER = @NUMERO_OPER and MONUMOPER = VINUMOPER AND MOTIPOPER = 'FLI')
   BEGIN
      SELECT -3, 'No Existe ese Número de Operación'
      RETURN
   END

	IF @sOrigen ='E'  --> Esta consulta es solo para la eliminacion
	BEGIN
		IF  EXISTS( SELECT 1 FROM pagos_fli WHERE panumoper = @NUMERO_OPER )
		BEGIN
			SELECT -5, 'Operacion ya tiene pagos, no se puede anular'
			RETURN
		END
END

	SELECT 0, 'OK'

END


GO
