USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_cond_vi]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[sp_cond_vi] 
(			@xTipope CHAR(03),
			@xRutCli     Numeric(9),
			@xCodCli     Numeric(9),
			@dFecini     Datetime,
			@dFecFin     Datetime,
			@xGarantia   CHAR(01),
			@nCondicion  CHAR(02) OUTPUT
)

AS

/* LD1-COR-035 FUSION CORPBANCA - ITAU --> REPORTE CARTERA VOLCKER RULE **/
/***********************************************************************/
/*SISTEMA: BACTRADERSUDA */

Begin

DECLARE @nTipCli     NUMERIC(5)
DECLARE @xRutBcch    Numeric(9)
DECLARE @xRutEst 	 Numeric(9)

SELECT @nTipCli = Isnull(cltipcli,0) FROM VIEW_CLiente WHERE clrut = @xRutCli AND clcodigo = @xCodCli
SELECT @xRutBcch = 97029000 -- Banco Central
SELECT @xRutEst = 97030000 -- Banco del Estado

SELECT  @nCondicion = CASE 	WHEN @xTipope = 'VI' AND
		     DATEDIFF(  DAY, @dFecini, @dFecFin) < 30 AND
		     @nTipCli  > 3   AND
		     @xRutCli <> @xRutBcch THEN '1'

				WHEN @xTipope = 'VI' AND
				     DATEDIFF(  DAY, @dFecini, @dFecFin) >= 30  AND
				     DATEDIFF(  DAY, @dFecini, @dFecFin) <= 89  AND
		     @nTipCli  > 3   AND
		     @xRutCli <> @xRutBcch THEN '2'
/*========================================================================*/
/* Venta con Pacto                                                        */
/* Terceros                                                               */
/* Mayores a 90 D¡as Hasta 1 a¤o                                          */
/*========================================================================*/
				WHEN @xTipope = 'VI' AND
				     (DATEDIFF(  DAY, @dFecini, @dFecFin) >= 90  AND
				     DATEDIFF( YEAR, @dFecini, @dFecFin) <= 1 ) AND
		     @nTipCli  > 3   AND
		     @xRutCli <> @xRutBcch THEN '3'

/*========================================================================*/
/* Venta con Pacto                                                        */
/* Terceros                                                               */
/* Mayores a 1 a¤o                                                        */
/*========================================================================*/
				WHEN @xTipope = 'VI' AND
				     DATEDIFF( YEAR, @dFecini, @dFecFin) > 1  AND
		     @nTipCli  > 3   AND
		     @xRutCli <> @xRutBcch THEN '4'
/*========================================================================*/
/* Venta con Pacto                                                        */
/* Instituciones Financieras                                              */
/* Menor a 30 días                                                        */
/*========================================================================*/
				WHEN @xTipope = 'VI' AND
				     DATEDIFF(  DAY, @dFecini, @dFecFin) < 30 AND
		     @nTipCli  <= 3   AND
		     @xRutCli <> @xRutBcch THEN '5'

/*========================================================================*/
/* Venta con Pacto                                                        */
/* Instituciones Financieras                                              */
/* Mayores a 30-89 d¡as                                                   */
/*========================================================================*/
				WHEN @xTipope = 'VI' AND
		     ( DATEDIFF(  DAY, @dFecini, @dFecFin)  >= 30       AND
		     DATEDIFF(  DAY, @dFecini, @dFecFin)  <= 89 )     AND
		     @nTipCli  <= 3   AND
		     @xRutCli <> @xRutBcch THEN '6'

/*========================================================================*/
/* Venta con Pacto                                                        */
/* Instituciones Financieras                                              */
/* Mayores a 90 d¡as hasta 1 a¤o                                          */
/*========================================================================*/
				WHEN @xTipope = 'VI' AND

		     ( DATEDIFF(  DAY, @dFecini, @dFecFin)  >= 90 AND
		     DATEDIFF( YEAR, @dFecini, @dFecFin)  <= 1 )  AND
		     @nTipCli  <= 3   AND
		     @xRutCli <> @xRutBcch THEN '7'

/*========================================================================*/
/* Venta con Pacto                                                        */
/* Instituciones Financieras                                              */
/* Mayores a 1 a¤o                                                        */
/*========================================================================*/
				WHEN @xTipope = 'VI' AND
				     DATEDIFF(  DAY, @dFecini, @dFecFin)>365 AND
		     @nTipCli  <= 3   AND
		     @xRutCli <> @xRutBcch THEN '8'



/*========================================================================*/
/* Venta con Pacto/Recompra/Recompra Anticipada                           */
/* Banco Central (Repos)       */
/*========================================================================*/
				WHEN @xTipope = 'VI' AND
		     @xRutCli = @xRutBcch THEN '9'



/*------------------ CONDICION DE INTERBANCARIOS-------------------------------------
-------------------------------------------------------------------------------------*/
/*----- Banco Americano hasta 1 ano sin garantia--*/
				WHEN @xTipope = 'IB' AND
		     DATEDIFF( Year, @dFecini, @dFecFin ) <=1 AND
		     @nTipCli  = 1    AND
				     @xGarantia = 'N' AND
		     @xRutCli <> @xRutBcch AND
				     @xRutCli <> @xRutEst THEN '1'

/*----- Banco  Americano hasta 1 ano con garantia--*/
				WHEN @xTipope = 'IB' AND
		     DATEDIFF( Year, @dFecini, @dFecFin ) <=1 AND
		     @nTipCli  = 1    AND
				     @xGarantia = 'S' AND
		     @xRutCli <> @xRutBcch AND
				     @xRutCli <> @xRutEst THEN '2'


/*----- Banco  Americano mas 1 ano sin garantia--*/
				WHEN @xTipope = 'IB' AND
		     DATEDIFF( Year, @dFecini, @dFecFin ) >1 AND
		     @nTipCli  = 1    AND
				     @xGarantia = 'N' AND
		     @xRutCli <> @xRutBcch AND
				     @xRutCli <> @xRutEst THEN '3'

/*----- Banco  Americano mas 1 ano con garantia--*/
				WHEN @xTipope = 'IB' AND
		     DATEDIFF( Year, @dFecini, @dFecFin ) >1 AND
		     @nTipCli  = 1    AND
				     @xGarantia = 'S' AND
		     @xRutCli <> @xRutBcch AND
				     @xRutCli <> @xRutEst THEN '4'

/*----- Banco NO Americano hasta 1 ano sin garantia--*/
				WHEN @xTipope = 'IB' AND
		     DATEDIFF( Year, @dFecini, @dFecFin ) <=1 AND
		     @nTipCli  = 2    AND
				     @xGarantia = 'N' AND
		     @xRutCli <> @xRutBcch AND
				     @xRutCli <> @xRutEst THEN '5'

/*----- Banco NO Americano hasta 1 ano con garantia--*/
				WHEN @xTipope = 'IB' AND
		     DATEDIFF( Year, @dFecini, @dFecFin ) <=1 AND
		     @nTipCli  = 2    AND
				     @xGarantia = 'S' AND
		     @xRutCli <> @xRutBcch AND
				     @xRutCli <> @xRutEst THEN '6'

/*----- Banco NO Americano mas 1 ano sin garantia--*/
				WHEN @xTipope = 'IB' AND
		     DATEDIFF( Year, @dFecini, @dFecFin ) > 1 AND
		     @nTipCli  = 2    AND
				     @xGarantia = 'N' AND
		     @xRutCli <> @xRutBcch AND
				     @xRutCli <> @xRutEst THEN '7'

/*----- Banco NO Americano mas 1 ano con garantia--*/
				WHEN @xTipope = 'IB' AND
		     DATEDIFF( Year, @dFecini, @dFecFin ) > 1 AND
		     @nTipCli  = 2    AND
				     @xGarantia = 'S' AND
		     @xRutCli <> @xRutBcch AND
				     @xRutCli <> @xRutEst THEN '8'

/*----- FINACIERA hasta 1 ano sin garantia--*/
				WHEN @xTipope = 'IB' AND
		     DATEDIFF( Year, @dFecini, @dFecFin )<=1 AND
		     @nTipCli  = 3    AND
				     @xGarantia = 'N' AND
		     @xRutCli <> @xRutBcch AND
				     @xRutCli <> @xRutEst THEN '9'

/*----- FINACIERA hasta 1 ano con garantia--*/
				WHEN @xTipope = 'IB' AND
		     DATEDIFF( Year, @dFecini, @dFecFin )<=1 AND
		     @nTipCli  = 3    AND
				     @xGarantia = 'S' AND
		     @xRutCli <> @xRutBcch AND
				     @xRutCli <> @xRutEst THEN '10'

/*----- FINACIERA mas 1 ano sin garantia--*/
				WHEN @xTipope = 'IB' AND
		             DATEDIFF( Year, @dFecini, @dFecFin ) >1 AND
		     @nTipCli  = 3    AND
				     @xGarantia = 'N' AND
		     @xRutCli <> @xRutBcch AND
				     @xRutCli <> @xRutEst THEN '11'

/*----- FINACIERA mas 1 ano con garantia--*/
				WHEN @xTipope = 'IB' AND
		             DATEDIFF( Year, @dFecini, @dFecFin ) >1 AND
		     @nTipCli  = 3    AND
				     @xGarantia = 'S' AND
		     @xRutCli <> @xRutBcch AND
				     @xRutCli <> @xRutEst THEN '12'

/*----- BANCO CENTRAL hasta 1 ano sin garantia--*/
				WHEN @xTipope = 'IB' AND
				     DATEDIFF( Year, @dFecini, @dFecFin ) <=1 AND
				     @xGarantia = 'N' AND
		     @xRutCli = @xRutBcch THEN '13'

/*----- BANCO CENTRAL hasta 1 ano con garantia--*/
				WHEN @xTipope = 'IB' AND
				     DATEDIFF( Year, @dFecini, @dFecFin ) <=1 AND
				     @xGarantia = 'S' AND
		     @xRutCli = @xRutBcch THEN '4'

/*-----BANCO CENTRAL mas 1 ano sin garantia--*/
				WHEN @xTipope = 'IB' AND
				     DATEDIFF( Year, @dFecini, @dFecFin ) >1 AND
				     @xGarantia = 'N' AND
		     @xRutCli = @xRutBcch THEN '15'

/*----- BANCO CENTRAL mas 1 ano con garantia--*/
				WHEN @xTipope = 'IB' AND
				     DATEDIFF( Year, @dFecini, @dFecFin ) >1 AND
				     @xGarantia = 'S' AND
		     @xRutCli = @xRutBcch THEN '16'

/*----- BANCO ESTADO hasta 1 ano sin garantia--*/
				WHEN @xTipope = 'IB' AND
				     DATEDIFF( Year, @dFecini, @dFecFin ) <=1 AND
				     @xGarantia = 'N' AND
		     @xRutCli = @xRutEst THEN '17'

/*----- BANCO ESTADO hasta 1 ano con garantia--*/
				WHEN @xTipope = 'IB' AND
				     DATEDIFF( Year, @dFecini, @dFecFin ) <=1 AND
				     @xGarantia = 'S' AND
		     @xRutCli = @xRutEst THEN '18'

/*-----BANCO ESTADO mas 1 ano sin garantia--*/
				WHEN @xTipope = 'IB' AND
				     DATEDIFF( Year, @dFecini, @dFecFin ) >1 AND
				     @xGarantia = 'N' AND
		     @xRutCli = @xRutEst THEN '19'

/*----- BANCO ESTADO mas 1 ano con garantia--*/
				WHEN @xTipope = 'IB' AND
				     DATEDIFF( Year, @dFecini, @dFecFin ) >1 AND
				     @xGarantia = 'S' AND
		     @xRutCli = @xRutEst THEN '20'

/*========================================================================*/
/* Condiciones de Compra con Pacto                                        */
/*========================================================================*/
/* Compra con Pacto/Reventa/Reventa Anticipada                            */
/* Tercero                                                                */
/* a Mas de un año                                                        */
/*========================================================================*/
				WHEN @xTipope = 'CI' AND
		                     DATEDIFF( YEAR, @dFecini, @dFecFin) > 1 AND
		     @nTipCli  > 3   THEN '1'

/*========================================================================*/
/* Compra con Pacto/Reventa/Reventa Anticipada                            */
/* Instituciones Financieras                                              */
/* Mas de un Año                                           */
/*========================================================================*/
				WHEN @xTipope = 'CI' AND
		                     DATEDIFF( YEAR, @dFecini, @dFecFin) > 1 AND
		     @nTipCli  <= 3  THEN '2'

/*========================================================================*/
/* Compra con Pacto/Reventa/Reventa Anticipada                            */
/* Terceros                                                               */
/* Menos de un año                                                        */
/*========================================================================*/
				WHEN @xTipope = 'CI' AND
		     DATEDIFF( YEAR, @dFecini, @dFecFin) <= 1 AND
		     @nTipCli  > 3  THEN '3'

/*========================================================================*/
/* Compra con Pacto/Reventa/Reventa Anticipada                            */
/* Instituciones Financieras                                              */
/* Menos de un año                                                        */
/*========================================================================*/
				WHEN @xTipope = 'CI' AND
		     DATEDIFF( YEAR, @dFecini, @dFecFin) <= 1 AND
		     @nTipCli  <= 3  THEN '4' END


	SELECT  @nCondicion = Isnull(@nCondicion,'0')
End

GO
