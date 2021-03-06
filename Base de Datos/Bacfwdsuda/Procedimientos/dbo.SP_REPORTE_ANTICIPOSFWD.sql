USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTE_ANTICIPOSFWD]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_REPORTE_ANTICIPOSFWD]
(

/*DATOS DE ENTRADA DEL FORMULARIO*/
 @nMtoOriAnt 		FLOAT  		 		-- 0  Monto Origen Anticipar
,@nMontoCompensacion	FLOAT  		 		-- 1  Monto Compensacion
,@cModalidad		INT 	 		-- 2  Total=1, Parcial=0
,@nSpotTran 		FLOAT 		 		-- 3  Spot Transferencia
,@nPtosFwd      	FLOAT		 		-- 4  Ptos. Forward Transferencia
,@nTasaDcto     	FLOAT 		 		-- 5  Tasa Descuento Transferencia

,@nMTMTran		FLOAT		 		-- 6  MTM Transferencia 
,@nResVta		FLOAT 		 		-- 7  Resultado Venta
,@nResTra		FLOAT 		 		-- 8  Resultado Trading

,@nFPgoNominal		VARCHAR(30) = 'NO APLICA' 	-- 9 Forma de Pago Mto Origen
,@nFPgoCNominal		VARCHAR(30) = 'NO APLICA'       -- 10 Forma de Pago Contramoneda
,@nFPgoCompensacion	VARCHAR(30) = 'NO APLICA'	-- 11 Forma de Pago Compensación
,@nNumOpe		INT 	 		-- 12 Numero de Operación	
,@Usuario       	VARCHAR(15)   = 'ADMINISTRA' 	-- 13 Usuario
,@fPorcentaje       	FLOAT  	      = 100		-- 14 Porcentaje
,@vMoneda       	VARCHAR(5)			-- 15 Moneda
,@fParidad       	FLOAT  	      = 0		-- 16 Paridad
,@fPrecioFwd       	FLOAT	      = 0		-- 17 Precio Forward
,@nMonto2		FLOAT	      = 0		-- 18 Monto 2
)

AS
BEGIN

declare @dFechaProceso as char(10)

SELECT @dFechaProceso = CONVERT(CHAR(10),acfecproc,103)   FROM MFAC

select  
 	 'clnombre'		= cli.clnombre --
	,'nNumOpe'  		= @nNumOpe --
	,'NomProducto'  	= 'ANTICIPO DE ' + prod.descripcion --
	,'FecProceso'		= @dFechaProceso --
	,'FechaHoy'  		= CONVERT(CHAR(10),@dFechaProceso,103)--
	,'cHora'		= CONVERT(CHAR(10),GETDATE(),108)--
	,'nNominal' 		= @nMtoOriAnt--
	,'nValAnt'		= @nMontoCompensacion 	--
	,'nSpotTran' 		= @nSpotTran 	--
	,'nPtosFwd' 		= @nPtosFwd  --  
	,'nTasaDcto' 		= @nTasaDcto --  
	,'nResAntTran' 		= @nMTMTran --
	,'nResVta' 		= @nResVta	--
	,'nResTra' 		= @nResTra	--
	,'nFPgoMda1' 		= @nFPgoNominal	--
	,'nFPgoMda2' 		= @nFPgoCNominal	--
	,'nFPgoComp' 		= @nFPgoCompensacion	--
	,'cUsuario'		= @Usuario--

	,'MTMSaldo'		= (CASE WHEN @cModalidad = 1 THEN 0 ELSE ( fRes_Obtenido * (100 - @fPorcentaje) / 100) END) --@nSaldoMTM --
	,'MTMAnticipo'		= @nMontoCompensacion --> (CASE WHEN @cModalidad = 1 THEN fRes_Obtenido ELSE ( fRes_Obtenido * @fPorcentaje / 100)  END) --
	,'MTMCartera' 		= fRes_Obtenido --
	,'NemoMon1' 		= mon1.mnnemo  --
	,'NemoMon2' 		= mon2.mnnemo --
	,'EquivalenteCartera' 	= camtomon2
	,'EquivalenteAnticipo'  = @nMonto2  --> (CASE WHEN @cModalidad = 1 THEN camtomon2 ELSE  @nMonto2 END)---@nAntMtoEqui
	,'EquivalenteSaldo'  	= (CASE WHEN @cModalidad = 1 THEN 0 ELSE ( camtomon2 * (100 - @fPorcentaje ) / 100) END) -- @nSalMtoEqui
	,'FInicio'  	  	= CONVERT( CHAR(10), cafecha, 103 )  --
	,'FTermino' 	  	= CONVERT(CHAR(10), cafecvcto,103) --
	,'MarktoMarket'  	= fRes_Obtenido --
	,'PrecioFuturo'		= catipcam ---0---caprecal ---catasausd --preguntar a que campo corresponde
	,'TipoCambio'		= catipcam --
	,'Spread'		= caspread --
	,'SalMtoOrigen'  	= (CASE WHEN @cModalidad = 1 THEN 0 ELSE ( camtomon1 * (100 - @fPorcentaje ) / 100) END) -------@nSalMtoOri--
	,'MtoOrigen'    	= camtomon1 --
	,'catipoper' 	  	= CASE catipoper  WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END--
	,'catipmoda' 	  	= CASE catipmoda  WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END--
	,'TipoAntic' 	  	= CASE @cModalidad  WHEN  0  THEN 'PARCIAL' ELSE 'TOTAL' END--
	,'CodProd'		= cacodpos1
	,'MdaPago'		= @vMoneda
	,'ResultadoMesa'	= Resultado_Mesa
	,'Paridad'		= @fParidad
	,'PrecioForward'	= @fPrecioFwd
	FROM  MFCA 
		LEFT JOIN bacparamsuda..CLIENTE cli ON cacodigo  = cli.clrut AND cacodcli = cli.clcodigo 
		LEFT JOIN view_moneda mon1 	    ON mon1.mncodmon = cacodmon1
		LEFT JOIN view_moneda mon2 	    ON mon2.mncodmon = cacodmon2
		LEFT JOIN view_forma_de_pago pagm1  ON pagm1.codigo  = cafpagomn
		LEFT JOIN view_forma_de_pago pagm2  ON pagm2.codigo  = cafpagomx
		LEFT JOIN view_producto	     prod   ON prod.codigo_producto  = cacodpos1
	WHERE canumoper  = @nNumOpe


END


GO
