USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SADP_LEEROPERACIONES]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SADP_LEEROPERACIONES]  
 ( @cUsuario   VARCHAR(15)  
 , @cOrigen   VARCHAR(5) = ''  
 , @iMoneda   INT   = 0  
 , @cEstado   VARCHAR(5) = ''  
 , @nFolio    NUMERIC(9) = 0  
    ,   @iMedioPago   INT   = 0  
    ,   @sTipOperacion  VARCHAR(10)   
 )  
AS  
BEGIN  
   
 SET NOCOUNT ON  
  
 DECLARE @dFecha   DATETIME  
  SET @dFecha   = ( SELECT dfechaproceso FROM BacParamSuda.dbo.SADP_CONTROL with(nolock) )  
  
  
 IF  RTRIM(LTRIM(@cOrigen))='FFMM' OR LTRIM(RTRIM(@cOrigen))='GPI'  
 BEGIN  
   EXECUTE SP_SADP_CARGA_DATOS_FILIALES @dFecha , @cUsuario  
 END   
  
	SELECT	/*01*/ 'Glosa_Estado'	= ee.sDescripcion
		,	/*02*/ 'Estado'			= dp.cEstado
		,	/*03*/ 'Origen'			= dp.cModulo
		,	/*04*/ 'Contrato'		= dp.nContrato
		,	/*05*/ 'GlosaMoneda'	= mn.mnnemo
		,	/*06*/ 'iMoneda'		= dp.iMoneda
		,	/*07*/ 'cGlosaPago'		= fp.glosa
		,	/*08*/ 'iFormaPago'		= dp.iFormaPago
		,	/*09*/ 'Usuario'		= dp.sUsuario
		,	/*10*/ 'Firma1'			= dp.sFirma1
		,	/*11*/ 'Firma2'			= dp.sFirma2
		,	/*12*/ 'IdPago'			= dp.Id_Detalle_Pago
		,	/*13*/ 'Cliente'		= BacParamSuda.dbo.fxCliente(md.rut_cliente,md.codigo_cliente,md.sistema)
		,	/*14*/ 'Monto'			= dp.nMonto
		,	/*15*/ 'Beneficiario'	= UPPER( dp.sNomBeneficiario )
		,   /*16*/ 'TipOper'		= UPPER( spm.Producto)
		,	/*17*/ 'Secuencia'		= md.Secuencia
		,   /*18*/ 'Referencia'     = dp.vNumTransferencia
		,   /*19*/ 'Razon'          = dp.cObservaciones
		
		,   /*20*/ 'Color'			= CASE	  WHEN iFormaPago = 222 THEN 'CN' 
											  WHEN iFormaPago = 0   THEN 'SFP'
											  ELSE 
									  			 CASE WHEN iFormaPago IN(134,128,103)	AND sCtaCte =''          THEN 'SCTA'
									  			 
									  				  WHEN iFormaPago IN(134,128)		AND sSwift  =''          THEN 'SSWF'
									  				  WHEN iFormaPago IN(134,128,5,103) AND sNomBeneficiario ='' THEN 'SNB'
									  				  WHEN iFormaPago IN(134,128,5,103) AND iRutBeneficiario =0  THEN 'SRB'
												 ELSE 'CN'									  		  
									  			 END
									  END											  		  
		
 FROM BacParamSuda.dbo.MDLBTR       md with(nolock)  
   INNER JOIN BacParamSuda.dbo.SADP_DETALLE_PAGOS dp with(nolock) ON dp.nContrato = md.numero_operacion AND dp.cModulo = md.sistema AND dp.iMoneda = md.moneda AND md.Secuencia=dp.isecuencia  
   LEFT  JOIN BacParamSuda.dbo.SADP_ESTADOSENVIO se with(nolock) ON se.sCodigo   = dp.cEstado  
   LEFT  JOIN BacParamSuda.dbo.MONEDA    mn with(nolock) ON mn.mncodmon = dp.iMoneda   
   LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO  fp with(nolock) ON fp.codigo = dp.iFormaPago  
   LEFT  JOIN BacParamSuda.dbo.SADP_ESTADOSENVIO ee with(nolock) ON ee.sCodigo   = dp.cEstado  
   LEFT  JOIN bacparamsuda.dbo.SADP_PRODUCTO_MODULOEXTERNO spm ON spm.Modulo=md.sistema AND spm.Codigo=md.tipo_mercado      
 WHERE (md.fecha    = @dFecha)  
 AND  (md.numero_operacion = @nFolio OR @nFolio = 0)  
 AND     (md.tipo_mercado  = @sTipOperacion  OR @sTipOperacion  = '')  
 AND  (dp.cModulo    = @cOrigen OR @cOrigen = '')  
 AND  (dp.iMoneda    = @iMoneda OR @iMoneda = 0 )  
 AND  (dp.cEstado    = @cEstado OR @cEstado = '')  
	AND     (dp.iFormaPago			= @iMedioPago OR @iMedioPago =-1)
 AND NOT (dp.sUsuario   = @cUsuario AND dp.sFirma1 = @cUsuario AND dp.sFirma2 = @cUsuario)  
 AND     (dp.cModulo   NOT IN('BCC', 'BTR', 'BEX', 'BFW', 'PCS', 'OPT'))  
	AND     (dp.cEstado			NOT IN('APM')) --> , 'OP'))
 ORDER BY dp.cModulo, dp.nContrato, dp.iMoneda, dp.iFormaPago, dp.cEstado  
  
END  
/*
Execute dbo.SADP_LEEROPERACIONES 'ADMINISTRA', 'FFMM', 0, '', 0, 0, ''
truncate table mdlbtr  
truncate table sadp_detalle_pagos  
select * from BacParamSuda.dbo.SADP_DETALLE_PAGOS where iformapago=134

 update BacParamSuda.dbo.SADP_DETALLE_PAGOS set SCTACTE='' 
 where ncontrato = 1449040
 
*/
GO
