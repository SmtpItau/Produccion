USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_SALDOS_PROYECTADOS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SONDA S.A.
-- Create date: 13-02.2020
-- Description:	interfaz saldos proyectados BTR, SWP	
-- =============================================
-- 20200916 - AJUSTE DE VALOR "CFT_ID"

--EXEC SP_INTERFAZ_SALDOS_PROYECTADOS
CREATE PROCEDURE [dbo].[SP_INTERFAZ_SALDOS_PROYECTADOS] (@dFecProceso as datetime = '')
AS BEGIN 
SET NOCOUNT ON 
SET DATEFORMAT DMY
 
DECLARE @SEP  VARCHAR(1) 
    SET @SEP  = ';'--','
DECLARE @Con_Linea_Encabezado VARCHAR(1)	-- PLL-20200512
    SET @Con_Linea_Encabezado = 'Y'			-- PLL-20200512

--declare @dFecProceso datetime
--set @dFecProceso ='20211130'--aqui btr
--set @dFecProceso ='20211005'--aqui swap, swap murex 
IF @dFecProceso = '1900-01-01'
BEGIN 	
	SELECT @dFecProceso = fechaproc 
	FROM BacSwapSuda..SwapGeneral
END 
--SELECT @dFecProceso


select *   
into #TEMP_TBL_CAJA_DERIVADOS  
from BacParamSuda.dbo.TBL_CAJA_DERIVADOS  where 1 = 2


--select '@dFecProceso'=@dFecProceso
/*******************CALCULO T+2 PROYECCION***********************/
declare @dFecLiquida    DATETIME 
set @dFecLiquida = @dFecProceso
--SELECT '@dFecLiquida' = @dFecLiquida
INSERT INTO #TEMP_TBL_CAJA_DERIVADOS
exec SP_GENERA_LIQUIDACION_PROYECCION @dFecLiquida,0

exec BacSwapSuda..SP_FECHA_PROXIMA_HABIL_FER_INTERNACIONALES @dFecLiquida,@dFecLiquida OUTPUT,1,0,0   
--SELECT '@dFecLiquida' = @dFecLiquida
INSERT INTO #TEMP_TBL_CAJA_DERIVADOS
exec SP_GENERA_LIQUIDACION_PROYECCION @dFecLiquida,0

exec BacSwapSuda..SP_FECHA_PROXIMA_HABIL_FER_INTERNACIONALES @dFecLiquida,@dFecLiquida OUTPUT,1,0,0 
--SELECT '@dFecLiquida' = @dFecLiquida
INSERT INTO #TEMP_TBL_CAJA_DERIVADOS
exec SP_GENERA_LIQUIDACION_PROYECCION @dFecLiquida,0


--SELECT '#TEMP_TBL_CAJA_DERIVADOS' AS TABLA,* FROM #TEMP_TBL_CAJA_DERIVADOS ORDER BY fechaLiquidacion


--select * from BacSwapSuda..SwapGeneral
--select '@dFecProceso'=@dFecProceso, '@dFecLiquida' = @dFecLiquida

-->>RESCATE CARTERA VIGENTE HE HISTORICA 
--SWAP
select *       
into #tmp_cartera
from   BacSwapSuda..cartera   with(nolock)      
where  FechaLiquidacion  between @dFecProceso and @dFecLiquida--=@dFecProceso
	union      
select *      
from   BacSwapSuda..carterahis   with(nolock)      
where  FechaLiquidacion   between @dFecProceso and @dFecLiquida--=@dFecProceso


select * 
into #tmp_TBL_CAJA_DERIVADOS
from #tmp_cartera

/*
SELECT * FROM BacSwapSuda..cartera WHERE numero_operacion = 11582
SELECT * FROM BacSwapSuda..carterahis WHERE numero_operacion = 11582
*/
                                      
  


--RENTA FIJA

select 
	 fecha_pagomañana
	,mofecpro
	,mofecven
	,moforpagi
	,moforpagv
	,momonpact
	,monumoper
	,morutcli
	,motipoper
	,movalant
	,movalcomp
	,movalinip
	,movalven
	,movalvenp
	,movpresen
	,mocodcli
	,mostatreg
	,mocorrela
	,monumdocu
	,moinstser
	,momonemi
	,mofecvenp
into #tmp_mdmo
from bactradersuda.dbo.mdmo with(nolock)
where mofecpro = @dFecProceso
union all
select 
	fecha_pagomañana
	,mofecpro
	,mofecven
	,moforpagi
	,moforpagv
	,momonpact
	,monumoper
	,morutcli
	,motipoper
	,movalant
	,movalcomp
	,movalinip
	,movalven
	,movalvenp
	,movpresen
	,mocodcli
	,mostatreg
	,mocorrela
	,monumdocu
	,moinstser
	,momonemi
	,mofecvenp
from bactradersuda.dbo.mdmh with(nolock)
where mofecpro = @dFecProceso



--select '#tmp_cartera' as tabla,FechaLiquidacion,* from #tmp_cartera
/*******************CALCULO T+2 PROYECCION***********************/
CREATE TABLE #VM_BAC_USER_SALIDA
	(USR_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
	REG_SALIDA			Varchar(1000))

select	idEntidad 
		,sENT_Generico 
		,sENT_Descripcion               
		,bVisible 
		,bEsBanco 
into #tmp_SADP_Entidades
from DB_SADP_Filiales..SADP_Entidades


select 
	idEntidad 
	,idModulo 
	,sMOD_Generico 
	,sMOD_Descripcion                         
	,bMOD_Detalle 
	,sMOD_Origen
into #tmp_SADP_Modulos
from DB_SADP_Filiales..SADP_Modulos

select 
	idEntidad 
	,vRELFP_FormaPago                                   
	,idFormaPago 
	,sRELFP_Descripcion
into #tmp_SADP_RelacionFormaPago
from DB_SADP_Filiales..SADP_RelacionFormaPago


select  
	idEntidad 
	,idModulo 
	,idTipoOperacion 
	,sTOPER_Generico 
	,sTOPER_Descripcion             
	,idTipoMovimiento 
	,bTOPER_Aperturable 
	,bTOPER_DatosExtras 
	,sTOPER_TipoMercado 
	,sTOPER_MensajeEnvio 
	,sTOPER_MensajeRecibe 
	,sTOPER_AccionSADP 
	,sTOPER_VerCobroConcilia 
	,sTOPER_VerPagoConcilia
into #tmp_SADP_TipoOperaciones
from DB_SADP_Filiales..SADP_TipoOperaciones

select  
	idCodBanco 
	,sBAN_Nombre                                                                                          
	,iBAN_Rut    
	,iBAN_Dv 
	,sBAN_CodSwift   
	,sBAN_Direccion                                                                                       
	,iBAN_CtaContable 
	,bBAN_esNacional 
	,vBAN_CodFFMM 
	,vBAN_CodCDB 
	,vBAN_CodAGV 
	,vBAN_CodParticipe
into #tmp_SADP_Bancos
from DB_SADP_Filiales..SADP_Bancos


select  
	idEntidad 
	,idModulo 
	,idTipoOperacion 
	,idCodMoneda 
	,iVPD_RutCliente 
	,iVPD_CodCliente 
	,idFormaPago 
	,idCodBanco 
	,sVPD_NumCuenta  
	,sVPD_RutBeneficiario 
	,sVPD_DvBeneficiario 
	,sVPD_NombreBeneficiario
into #tmp_sadp_ValoresDefectos
from DB_SADP_Filiales..sadp_ValoresDefectos

 CREATE table #tblOperaciones  
        (
            [idEntidad] [smallint] NOT NULL,
            [idModulo] [smallint] NOT NULL,
            [idTipoOperacion] [smallint] NOT NULL,
            [iOPE_Operacion] [int] NOT NULL,
            [iDETOPE_Correlativo] [tinyint] NOT NULL,
            [idFormaPago] [smallint] NOT NULL,
            [fDETOPE_MontoPago] [decimal](21, 4) NOT NULL,
            [dDETOPE_FechaLiquidacion] [datetime] NOT NULL,
            [iDETOPE_RutBeneficiario] [int] NOT NULL,
            [sDETOPE_dvBeneficiario] [varchar](1) NOT NULL,
            [sDETOPE_Beneficiario] [varchar](80) NOT NULL,
            [idCodBanco] [smallint] NOT NULL,
            [sDETOPE_NumeroCuenta] [varchar](20) NOT NULL,
            [idEstado] [tinyint] NOT NULL,
            [iDETOPE_BancoReceptor] [smallint] NOT NULL,
            [iDETOPE_BancoIntermediario] [smallint] NOT NULL,
            [iDETOPE_Moneda] [smallint] NOT NULL,
            [iDETOPE_CodCli] [smallint] NOT NULL,
            [DiasValor] [tinyint] NOT NULL,
            [idMensaje] [smallint] NOT NULL,
            [iRegistro] [int] NOT NULL,
            [Agrupada] [bit] NULL DEFAULT 0,
            [Referencia] [int] NULL DEFAULT 0,
            [Monto2] [decimal](21, 4) NULL DEFAULT 0,
            [Moneda2] [Varchar](3) NULL DEFAULT '',
            [Valuta2] [datetime] NULL DEFAULT '',
            [Cantidad] [int] NULL DEFAULT 0,
            [iForPagoOrig] [smallint] NULL DEFAULT 0,
			--swap murex
			[modalidad]	[varchar](1)	NULL DEFAULT '',
			[tipo]		[varchar](20)	NULL DEFAULT ''
	)



	CREATE table #tblOperacionesFinal  
	(
		[IdEntidad]			[int]			NOT NULL,
		[FechaProceso]		[varchar](8)	NOT NULL,
		[TipoCaja]			[char](1)		NOT NULL,
		[Modulo]			[varchar](3)	NOT NULL,
		[TipoProducto]		[varchar](3)	NOT NULL,
		[TipoOperacion]		[char](1)		NOT NULL,
		[NumOperacion]		[int]			NOT NULL,
		[MontoOrigen]		[numeric](19,4) NOT NULL,
		[MonedaOrigen]		[numeric](3)	NOT NULL,
		[Precio]			[numeric](19,4) NOT NULL,
		[Moneda_2]			[numeric](3)	NOT NULL,
		[MontoMoneda_2]		[numeric](19,4) NOT NULL,
		[FechaVencimiento]	[varchar](8)	NOT NULL,
		[FechaValuta]		[varchar](8)	NOT NULL,
		[NroFlujo]			[numeric]		NOT NULL,
		[NombreCliente]		[varchar](80)		NOT NULL,
		[RutCliente]		[numeric]		NOT NULL,
		[DVRutCliente]		[char](1)		NOT NULL,
		[CodigoCliente]		[numeric]		NOT NULL,
		[TipoCliente]		[numeric]		NOT NULL,
		[NombreBeneficiario][varchar](80)		NOT NULL,
		[RutBeneficiario]	[numeric]		NOT NULL,
		[DVRutBeneficiario]	[char](1)		NOT NULL,
		[CodigoBeneficiario][numeric]		NOT NULL,
		[Modalidad]			[char](1)		NOT NULL,
		[CodFormaPago]		[numeric]		NOT NULL,
		[idCodBanco]		[numeric]		NOT NULL,
		[NumeroCuenta]		[varchar](20)		NOT NULL,
		[idBancoReceptor]	[numeric]		NOT NULL,
		[idBancoIntermediario][numeric]		NOT NULL,
		[Estado]			[char](1)		NOT NULL,
		[FILLER1]			[char](1)		NOT NULL,
		[FILLER2]			[char](1)		NOT NULL,
		[FILLER3]			[char](1)		NOT NULL,
		[FILLER4]			[char](1)		NOT NULL,
		[FILLER5]			[char](1)		NOT NULL,
	)	
	


/*SWAP MUREX************************************************************/
	DECLARE @idEntidad SMALLINT 
	DECLARE @idModuloPCS SMALLINT	        
	DECLARE @idValDefault SMALLINT 
	/*
	DECLARE @dFecProceso datetime
	set @dFecProceso = '2016-11-02'	
	--*/

	SET @idValDefault = -1 
	
	SET @idEntidad = (
	        SELECT idEntidad
	        FROM   #tmp_SADP_Entidades se WITH(NOLOCK)
	        WHERE  se.sENT_Generico = 'BANCO'
	    )	
	
	SET @idModuloPCS = (
	        SELECT idModulo	
	        FROM   #tmp_SADP_Modulos WITH (NOLOCK)
	        WHERE  idEntidad = @idEntidad
	        AND sMOD_Generico = 'PCS'
	    ) 
		

	/*RENTA FIJA*************************************************************/
	--DECLARE @idEntidad SMALLINT ;
	DECLARE @idModuloBTR SMALLINT;	        
	--DECLARE @idValDefault SMALLINT ;
	SET @idValDefault = -1 ;
		
	
	SET @idEntidad = (
		SELECT idEntidad
	        FROM   #tmp_SADP_Entidades se WITH(NOLOCK)
	        WHERE  se.sENT_Generico = 'BANCO'
	    )			
	
	SET @idModuloBTR = (
	        SELECT idModulo
	        FROM   #tmp_SADP_Modulos WITH (NOLOCK)
	        WHERE  idEntidad = @idEntidad
	               AND sMOD_Generico = 'BTR'
	    ) ;
	
	INSERT INTO #tblOperaciones
		  (
		    idEntidad,
		    idModulo,
		    idTipoOperacion,
		    iOPE_Operacion,
		    iDETOPE_Correlativo,
		    idFormaPago,
		    fDETOPE_MontoPago,
		    dDETOPE_FechaLiquidacion,
		    iDETOPE_RutBeneficiario,
		    sDETOPE_dvBeneficiario,
		    sDETOPE_Beneficiario,
		    idCodBanco,
		    sDETOPE_NumeroCuenta,
		    idEstado,
		    iDETOPE_BancoReceptor,
		    iDETOPE_BancoIntermediario,
		    iDETOPE_Moneda,
		    iDETOPE_CodCli,
		    DiasValor,
		    idMensaje,
		    iRegistro,iForPagoOrig
		  )
		SELECT 	@idEntidad,
			@idModuloBTR,
			sto.idTipoOperacion,
			monumoper,
			1,
			srfp.idFormaPago,
			SUM(
				CASE 
					WHEN motipoper = 'VP' THEN movalven
					WHEN motipoper = 'CP' THEN movalcomp
					WHEN motipoper = 'CI' THEN movpresen
					WHEN motipoper = 'VI' THEN movalinip
					WHEN motipoper = 'RC' THEN movalvenp
					WHEN motipoper = 'RCA'THEN movalant
					WHEN motipoper = 'RV' THEN movalvenp
					WHEN motipoper = 'RVA' THEN movalant
				END
			),
			CASE 
				WHEN motipoper = 'VP' THEN fecha_pagomañana
				WHEN motipoper = 'CP' THEN fecha_pagomañana
				WHEN motipoper = 'CI' THEN mofecpro
				WHEN motipoper = 'VI' THEN mofecpro
				WHEN motipoper = 'RC' THEN mofecpro
				WHEN motipoper = 'RCA'THEN mofecpro
				WHEN motipoper = 'RV' THEN mofecpro
				WHEN motipoper = 'RVA' THEN mofecpro
			END,
			c.Clrut,
			c.Cldv,
			c.Clnombre,
			CASE 
				WHEN c.cltipcli = 1 THEN sb.idCodBanco
				ELSE @idValDefault
			END,
			'',
			1,
			@idValDefault,
			@idValDefault,
			CASE momonpact
				WHEN 13 THEN 13
				ELSE 999
			END,
			c.Clcodigo,
			fdp.diasvalor,
			--sto.sTOPER_MensajeEnvio,	COC-2013-06-03
			CASE 
				WHEN c.cltipcli = 1 THEN sto.sTOPER_MensajeEnvio
				ELSE @idValDefault
			END,
			0, -->ROW_NUMBER() OVER(ORDER BY monumoper) AS Registro
			CASE 
				WHEN motipoper = 'CP' THEN moforpagi
				WHEN motipoper = 'VP' THEN moforpagi
				WHEN motipoper = 'VI' THEN moforpagi
				WHEN motipoper = 'CI' THEN moforpagi
				WHEN motipoper = 'RC' THEN moforpagv
				WHEN motipoper = 'RV' THEN moforpagv
				WHEN motipoper = 'RCA'THEN moforpagv
				WHEN motipoper = 'RVA'THEN moforpagv
			END

		FROM   #tmp_mdmo m WITH(NOLOCK)
		       INNER JOIN bacparamsuda.dbo.CLIENTE c WITH(NOLOCK)
				ON  c.Clrut = m.morutcli
				AND c.Clcodigo = m.mocodcli
		       INNER JOIN bacparamsuda.dbo.FORMA_DE_PAGO fdp WITH(NOLOCK)
				ON  fdp.codigo = m.moforpagi
		       INNER JOIN #tmp_SADP_TipoOperaciones sto WITH(NOLOCK)
				ON  sto.idEntidad = 1
				AND sto.idModulo = @idModuloBTR
				AND sto.sTOPER_Generico = m.motipoper
		       INNER JOIN #tmp_SADP_RelacionFormaPago srfp
				ON  srfp.idEntidad = sto.idEntidad
				AND srfp.vRELFP_FormaPago = (
					CASE 
						WHEN motipoper = 'CP' THEN moforpagi
						WHEN motipoper = 'VP' THEN moforpagi
						WHEN motipoper = 'VI' THEN moforpagi
						WHEN motipoper = 'CI' THEN moforpagi
						WHEN motipoper = 'RC' THEN moforpagv
						WHEN motipoper = 'RV' THEN moforpagv
						WHEN motipoper = 'RCA' THEN moforpagv
						WHEN motipoper = 'RVA' THEN moforpagv
					END
		                )
			LEFT JOIN #tmp_SADP_Bancos sb
				ON  sb.iBAN_Rut = c.Clrut
		WHERE  m.mostatreg = ''
		AND motipoper IN ('CP', 'VP', 'VI', 'CI', 'RCA', 'RVA', 'RC', 'RV')
		and m.mofecpro = @dFecProceso
		AND m.mofecven between @dFecProceso and @dFecLiquida--= @dFecProceso	---> JBH, 13-02-2013
		GROUP BY
			mofecpro,
			motipoper,
			monumoper,
			idFormaPago,
			moforpagi,
			moforpagv,
			clrut,
			Clcodigo,
			cltipcli,
			CASE momonpact
				WHEN 13 THEN 13
				ELSE 999
			END,
			c.Clnombre,
			c.Cldv,
			fdp.diasvalor,
			sto.idTipoOperacion,
			fecha_pagomañana,
			idCodBanco,
			sto.sTOPER_MensajeEnvio,
			CASE 
				WHEN motipoper = 'CP' THEN moforpagi
				WHEN motipoper = 'VP' THEN moforpagi
				WHEN motipoper = 'VI' THEN moforpagi
				WHEN motipoper = 'CI' THEN moforpagi
				WHEN motipoper = 'RC' THEN moforpagv
				WHEN motipoper = 'RV' THEN moforpagv
				WHEN motipoper = 'RCA' THEN moforpagv
				WHEN motipoper = 'RVA' THEN moforpagv
			END
 
	/*********  INI PM  *****/
	---JBH, 20-02-2014 Esta sección no se debe modificar ni bloquear porque esta función siempre recibe la fecha de proceso del SADP.
		INSERT INTO #tblOperaciones
		  (
		    idEntidad,
		    idModulo,
		    idTipoOperacion,
		    iOPE_Operacion,
		    iDETOPE_Correlativo,
		    idFormaPago,
		    fDETOPE_MontoPago,
		    dDETOPE_FechaLiquidacion,
		    iDETOPE_RutBeneficiario,
		    sDETOPE_dvBeneficiario,
		    sDETOPE_Beneficiario,
		    idCodBanco,
		    sDETOPE_NumeroCuenta,
		    idEstado,
		    iDETOPE_BancoReceptor,
		    iDETOPE_BancoIntermediario,
		    iDETOPE_Moneda,
		    iDETOPE_CodCli,
		    DiasValor,
		    idMensaje,
		    iRegistro,iForPagoOrig
		  )
		SELECT 	@idEntidad,
			@idModuloBTR,
			sto.idTipoOperacion,
			m.monumoper,
			1,
			srfp.idFormaPago,
			SUM(
				CASE 
					WHEN m.motipoper = 'VP' THEN m.movalven
					WHEN m.motipoper = 'CP' THEN m.movalcomp
					WHEN m.motipoper = 'CI' THEN m.movpresen
					WHEN m.motipoper = 'VI' THEN m.movalinip
					WHEN m.motipoper = 'RC' THEN m.movalvenp
					WHEN m.motipoper = 'RCA' THEN m.movalant
					WHEN m.motipoper = 'RV' THEN m.movalvenp
					WHEN m.motipoper = 'RVA' THEN m.movalant
				END
			),
			CASE 
				WHEN m.motipoper = 'VP' THEN m.fecha_pagomañana
				WHEN m.motipoper = 'CP' THEN m.fecha_pagomañana
				WHEN m.motipoper = 'CI' THEN m.mofecpro
				WHEN m.motipoper = 'VI' THEN m.mofecpro
				WHEN m.motipoper = 'RC' THEN m.mofecpro
				WHEN m.motipoper = 'RCA' THEN m.mofecpro
				WHEN m.motipoper = 'RV' THEN m.mofecpro
				WHEN m.motipoper = 'RVA' THEN m.mofecpro
			END,
			c.Clrut,
			c.Cldv,
			c.Clnombre,
			CASE 
				WHEN c.cltipcli = 1 THEN sb.idCodBanco
				ELSE @idValDefault
			END,
			'',
			1,
			@idValDefault,
			@idValDefault,
			CASE m.momonpact
				WHEN 13 THEN 13
				ELSE 999
			END,
			c.Clcodigo,
			fdp.diasvalor,
			--sto.sTOPER_MensajeEnvio,	COC-2013-06-03
			CASE 
				WHEN c.cltipcli = 1 THEN sto.sTOPER_MensajeEnvio
				ELSE @idValDefault
			END,
			0, 
			CASE 
				WHEN m.motipoper = 'CP' THEN m.moforpagi
				WHEN m.motipoper = 'VP' THEN m.moforpagi
				WHEN m.motipoper = 'VI' THEN m.moforpagi
				WHEN m.motipoper = 'CI' THEN m.moforpagi
				WHEN m.motipoper = 'RC' THEN m.moforpagv
				WHEN m.motipoper = 'RV' THEN m.moforpagv
				WHEN m.motipoper = 'RCA' THEN m.moforpagv
				WHEN m.motipoper = 'RVA' THEN m.moforpagv
			END

		FROM   #tmp_mdmo m WITH(NOLOCK)
		       INNER JOIN bactradersuda.dbo.mdmoPM PM WITH(NOLOCK)	-- (PM)
				ON  m.monumoper = PM.monumoper
				AND m.mocorrela = PM.mocorrela		---JBH, 24-10-2013
				AND m.monumdocu = PM.monumdocu		---JBH, 05-09-2014
		       INNER JOIN bacparamsuda.dbo.CLIENTE c WITH(NOLOCK)
				ON  c.Clrut = m.morutcli
				AND c.Clcodigo = m.mocodcli
		       INNER JOIN bacparamsuda.dbo.FORMA_DE_PAGO fdp WITH(NOLOCK)
				ON  fdp.codigo = m.moforpagi
		       INNER JOIN db_SADP_Filiales.dbo.SADP_TipoOperaciones sto WITH(NOLOCK)
				ON  sto.idEntidad = 1
				AND sto.idModulo = @idModuloBTR
				AND sto.sTOPER_Generico = m.motipoper
		       INNER JOIN #tmp_SADP_RelacionFormaPago srfp
				ON  srfp.idEntidad = sto.idEntidad
				AND srfp.vRELFP_FormaPago = (
					CASE 
						WHEN m.motipoper = 'CP' THEN m.moforpagi
						WHEN m.motipoper = 'VP' THEN m.moforpagi
						WHEN m.motipoper = 'VI' THEN m.moforpagi
						WHEN m.motipoper = 'CI' THEN m.moforpagi
						WHEN m.motipoper = 'RC' THEN m.moforpagv
						WHEN m.motipoper = 'RV' THEN m.moforpagv
						WHEN m.motipoper = 'RCA' THEN m.moforpagv
						WHEN m.motipoper = 'RVA' THEN m.moforpagv
					END
		                )
			LEFT JOIN #tmp_SADP_Bancos sb
				ON  sb.iBAN_Rut = c.Clrut
		WHERE  m.mostatreg = ''
		AND m.motipoper IN ('CP', 'VP', 'VI', 'CI', 'RCA', 'RVA', 'RC', 'RV')
		AND m.fecha_pagomañana between @dFecProceso and @dFecLiquida--= @dFecProceso
		AND m.monumoper NOT IN  (select iOPE_Operacion from #tblOperaciones)
		GROUP BY
			m.mofecpro,
			m.motipoper,
			m.monumoper,
			idFormaPago,
			m.moforpagi,
			m.moforpagv,
			clrut,
			Clcodigo,
			cltipcli,
			CASE m.momonpact
				WHEN 13 THEN 13
				ELSE 999
			END,
			c.Clnombre,
			c.Cldv,
			fdp.diasvalor,
			sto.idTipoOperacion,
			m.fecha_pagomañana,
			idCodBanco,
			sto.sTOPER_MensajeEnvio,
			CASE 
				WHEN m.motipoper = 'CP' THEN m.moforpagi
				WHEN m.motipoper = 'VP' THEN m.moforpagi
				WHEN m.motipoper = 'VI' THEN m.moforpagi
				WHEN m.motipoper = 'CI' THEN m.moforpagi
				WHEN m.motipoper = 'RC' THEN m.moforpagv
				WHEN m.motipoper = 'RV' THEN m.moforpagv
				WHEN m.motipoper = 'RCA' THEN m.moforpagv
				WHEN m.motipoper = 'RVA' THEN m.moforpagv
			END


	/*********  FIN PM  *****/



	/*********  ICOL  / ICAP  (INICIO) *****/
	INSERT INTO #tblOperaciones
		(
			idEntidad,
			idModulo,
			idTipoOperacion,
			iOPE_Operacion,
			iDETOPE_Correlativo,
			idFormaPago,
			fDETOPE_MontoPago,
			dDETOPE_FechaLiquidacion,
			iDETOPE_RutBeneficiario,
			sDETOPE_dvBeneficiario,
			sDETOPE_Beneficiario,
			idCodBanco,
			sDETOPE_NumeroCuenta,
			idEstado,
			iDETOPE_BancoReceptor,
			iDETOPE_BancoIntermediario,
			iDETOPE_Moneda,
			iDETOPE_CodCli,
			DiasValor,
			idMensaje,
			iRegistro,
			iForPagoOrig
		)
	SELECT 	@idEntidad,
		@idModuloBTR,
		sto.idTipoOperacion,
		monumoper,
		1,
		srfp.idFormaPago,
		---movalvenp,	
		movalinip,	---JBH, 15-02-2013
		mofecpro,
		c.Clrut,
		c.Cldv,
		c.Clnombre,
		CASE 
			WHEN c.cltipcli = 1 THEN sb.idCodBanco
			ELSE @idValDefault
		END,
		'',
		1,
		@idValDefault,
		@idValDefault,
		CASE momonemi
			WHEN 13 THEN 13
			ELSE 999
		END,
		c.Clcodigo,
		fdp.diasvalor,
		sto.sTOPER_MensajeEnvio,
		0, 
		moforpagi 
		FROM   #tmp_mdmo m WITH(NOLOCK)
		INNER JOIN bacparamsuda.dbo.CLIENTE c WITH(NOLOCK)
			ON  c.Clrut = m.morutcli
			AND c.Clcodigo = m.mocodcli
		INNER JOIN bacparamsuda.dbo.FORMA_DE_PAGO fdp WITH(NOLOCK)
			ON  fdp.codigo = m.moforpagi
		INNER JOIN db_SADP_Filiales.dbo.SADP_TipoOperaciones sto WITH(NOLOCK)
			ON  sto.idEntidad = 1
			AND sto.idModulo = @idModuloBTR
			AND sto.sTOPER_Generico = m.moinstser	
		INNER JOIN #tmp_SADP_RelacionFormaPago srfp
			ON  srfp.idEntidad = sto.idEntidad
			AND srfp.vRELFP_FormaPago = moforpagi  
		LEFT JOIN db_SADP_Filiales.dbo.SADP_Bancos sb
			ON  sb.iBAN_Rut = c.Clrut
		WHERE  m.mostatreg = ''
		AND motipoper = 'IB'
		AND moinstser IN ('ICAP', 'ICOL')
		AND m.monumoper NOT IN (SELECT iOPE_Operacion FROM #tblOperaciones)  ---> Verifica que el número no se haya agregado ya, JBH, 27-01-2014

	/******  JBH, 13-02-2013 Operaciones CI al vcto.(VCI)/VI al vcto.(VVI) *******/
	INSERT INTO #tblOperaciones
		(
			idEntidad,
			idModulo,
			idTipoOperacion,
			iOPE_Operacion,
			iDETOPE_Correlativo,
			idFormaPago,
			fDETOPE_MontoPago,
			dDETOPE_FechaLiquidacion,
			iDETOPE_RutBeneficiario,
			sDETOPE_dvBeneficiario,
			sDETOPE_Beneficiario,
			idCodBanco,
			sDETOPE_NumeroCuenta,
			idEstado,
			iDETOPE_BancoReceptor,
			iDETOPE_BancoIntermediario,
			iDETOPE_Moneda,
			iDETOPE_CodCli,
			DiasValor,
			idMensaje,
			iRegistro,
			iForPagoOrig
		)
		SELECT 	@idEntidad,
			@idModuloBTR,
			sto.idTipoOperacion,
			monumoper,
			1,
			srfp.idFormaPago,
			SUM(
				CASE 
					WHEN motipoper = 'CI' THEN movalvenp	---movpresen
					WHEN motipoper = 'VI' THEN movalvenp	---movalinip
				END
			),
			/*
			CASE 
			WHEN motipoper = 'CI' THEN mofecpro
			WHEN motipoper = 'VI' THEN mofecpro
			END*/
			m.mofecvenp,
			c.Clrut,
			c.Cldv,
			c.Clnombre,
			CASE 
				WHEN c.cltipcli = 1 THEN sb.idCodBanco
				ELSE @idValDefault
			END,
			'',
			1,
			@idValDefault,
			@idValDefault,
			CASE momonpact
				WHEN 13 THEN 13
				ELSE 999
			END,
			c.Clcodigo,
			fdp.diasvalor,
			sto.sTOPER_MensajeEnvio,
			0, -->ROW_NUMBER() OVER(ORDER BY monumoper) AS Registro
			CASE 
				WHEN motipoper = 'VI' THEN moforpagv
				WHEN motipoper = 'CI' THEN moforpagv
			END

		FROM   #tmp_mdmo m WITH(NOLOCK)
		INNER JOIN bacparamsuda.dbo.CLIENTE c WITH(NOLOCK)
			ON  c.Clrut = m.morutcli
			AND c.Clcodigo = m.mocodcli
		INNER JOIN bacparamsuda.dbo.FORMA_DE_PAGO fdp WITH(NOLOCK)
			ON  fdp.codigo = m.moforpagv
		INNER JOIN #tmp_SADP_TipoOperaciones sto WITH(NOLOCK)
			ON  sto.idEntidad = 1
			AND sto.idModulo = @idModuloBTR
			AND sto.sTOPER_Generico = 'V' + m.motipoper		---> Agregado para calzar con las nuevos tipos de oper.
		INNER JOIN #tmp_SADP_RelacionFormaPago srfp
			ON  srfp.idEntidad = sto.idEntidad
			AND srfp.vRELFP_FormaPago = (
							CASE 
								WHEN motipoper = 'VI' THEN moforpagv
								WHEN motipoper = 'CI' THEN moforpagv
							END
							)
		LEFT JOIN #tmp_SADP_Bancos sb
			ON  sb.iBAN_Rut = c.Clrut	
		WHERE  m.mostatreg = ''
		AND motipoper IN ('VI', 'CI')
		and m.mofecpro = @dFecProceso
		AND m.mofecven between @dFecProceso and @dFecLiquida--= @dFecProceso
		AND m.monumoper NOT IN (SELECT iOPE_Operacion FROM #tblOperaciones)		---> Valida que el número no exista ya, JBH, 27-01-2014
		GROUP BY
		mofecpro,
		mofecvenp,
		motipoper,
		monumoper,
		idFormaPago,
		moforpagi,
		moforpagv,
		clrut,
		Clcodigo,
		cltipcli,
		CASE momonpact
			WHEN 13 THEN 13
			ELSE 999
		END,
		c.Clnombre,
		c.Cldv,
		fdp.diasvalor,
		sto.idTipoOperacion,
		fecha_pagomañana,
		idCodBanco,
		sto.sTOPER_MensajeEnvio,
		CASE 
			WHEN motipoper = 'VI' THEN moforpagv
			WHEN motipoper = 'CI' THEN moforpagv
		END

	/** Fin Operaciones CI al vcto. JBH 13-02-2013  **/

	/*********  ICOL  / ICAP  (VCTO) *****/		
	---> Cambios por JBH, 15-10-2015 uso tabla MDRS en vez de mdmo/mdmh
	
	INSERT INTO #tblOperaciones
	(
		idEntidad,
		idModulo,
		idTipoOperacion,
		iOPE_Operacion,
		iDETOPE_Correlativo,
		idFormaPago,
		fDETOPE_MontoPago,
		dDETOPE_FechaLiquidacion,
		iDETOPE_RutBeneficiario,
		sDETOPE_dvBeneficiario,
		sDETOPE_Beneficiario,
		idCodBanco,
		sDETOPE_NumeroCuenta,
		idEstado,
		iDETOPE_BancoReceptor,
		iDETOPE_BancoIntermediario,
		iDETOPE_Moneda,
		iDETOPE_CodCli,
		DiasValor,
		idMensaje,
		iRegistro,
		iForPagoOrig
	)
	SELECT 	@idEntidad,
		@idModuloBTR,
		sto.idTipoOperacion,
		rs.rsnumoper,			---> JBH, 14-10-2015
		1,
		srfp.idFormaPago,
		rs.rsvppresenx,			---> JBH, 14-10-2015
		rs.rsfecha,				---> JBH, 14-10-2015
		rs.rsrutcli,			---> JBH, 14-10-2015
		c.Cldv,
		c.Clnombre,
		-1,
		c.Clctacte,
		1,
		@idValDefault,
		@idValDefault,
		rs.rsmonemi,			---> JBH, 14-10-2015
		rs.rscodcli,			---> JBH, 14-10-2015
		fdp.diasvalor,
		sto.sTOPER_MensajeEnvio,
		0,
		rs.rsforpagv			---> JBH, 14-10-2015
	FROM   BacTraderSuda.dbo.mdrs rs WITH (NOLOCK)		---> JBH, 14-10-2015
	INNER JOIN bacparamsuda.dbo.CLIENTE c WITH (NOLOCK)
		ON  c.clrut = rs.rsrutcli
		AND c.clcodigo = rs.rscodcli
	INNER JOIN #tmp_SADP_RelacionFormaPago srfp WITH (NOLOCK)
		ON  srfp.idEntidad = 1
		AND srfp.vRELFP_FormaPago = rs.rsforpagv
	INNER JOIN #tmp_SADP_TipoOperaciones sto
		ON  sto.idEntidad = @idEntidad
		AND sto.idModulo = @idModuloBTR
		AND sto.sTOPER_Generico = 'V' + rs.rsinstser
	INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO fdp WITH (NOLOCK)
		ON  fdp.codigo = rs.rsforpagv
	WHERE rs.rsfecha = @dFecProceso
	and rs.rsfecvcto between @dFecProceso and @dFecLiquida--= @dFecProceso
	AND rs.rsinstser IN ('ICAP','ICOL')
	AND rs.rstipoper = 'VC'

	
	--> ASIGNAR VALORES POR DEFECTO

	UPDATE	#tblOperaciones
	SET		idCodBanco		= v.idCodBanco,
			idFormaPago		= v.idFormaPago, --> Incluir la FPago
			sDETOPE_NumeroCuenta	= v.sVPD_NumCuenta,
			iDETOPE_RutBeneficiario = v.sVPD_RutBeneficiario,
		    sDETOPE_dvBeneficiario	= v.sVPD_DvBeneficiario,
		    sDETOPE_Beneficiario	= v.sVPD_NombreBeneficiario
	FROM   	#tblOperaciones tbl
		INNER JOIN #tmp_sadp_ValoresDefectos v
			ON  v.iVPD_RutCliente	= tbl.iDETOPE_RutBeneficiario
			AND v.iVPD_CodCliente	= tbl.iDETOPE_CodCli
			AND v.idCodMoneda		= tbl.iDETOPE_Moneda
			--AND v.idFormaPago		= tbl.idFormaPago
			AND v.idTipoOperacion	= tbl.idTipoOperacion
	WHERE	tbl.idEntidad = @idEntidad
	AND	tbl.idModulo = @idModuloBTR
	
	/*RENTA FIJA************************************************************/


	/*SWAP************************************************************/
	--DECLARE @idEntidad SMALLINT 
	--DECLARE @idModuloPCS SMALLINT	        
	--DECLARE @idValDefault SMALLINT 
	
	
	SET @idValDefault = -1 
	
	SET @idEntidad = (
	        SELECT idEntidad
	        FROM   #tmp_SADP_Entidades se WITH(NOLOCK)
	        WHERE  se.sENT_Generico = 'BANCO'
	    )			
	
	SET @idModuloPCS = (
	        SELECT idModulo
	        FROM   #tmp_SADP_Modulos WITH (NOLOCK)
	        WHERE  idEntidad = @idEntidad
	        AND sMOD_Generico = 'PCS'
	    ) 
	
	/**********************    INSERTA EN TABLA FINAL  ********************/
	---> JBH, PRD-24048, 17-08-2015
	
	INSERT INTO #tblOperaciones
	  (
	    idEntidad,
	    idModulo,
	    idTipoOperacion,
	    iOPE_Operacion,
	    iDETOPE_Correlativo,
	    idFormaPago,
	    fDETOPE_MontoPago,
	    dDETOPE_FechaLiquidacion,
	    iDETOPE_RutBeneficiario,
	    sDETOPE_dvBeneficiario,
	    sDETOPE_Beneficiario,
	    idCodBanco,
	    sDETOPE_NumeroCuenta,
	    idEstado,
	    iDETOPE_BancoReceptor,
	    iDETOPE_BancoIntermediario,
	    iDETOPE_Moneda,
		iDETOPE_CodCli,
	    DiasValor,
	    idMensaje,
	    iRegistro,
		iForPagoOrig
	  )
	SELECT @idEntidad,
	       @idModuloPCS,
	       sto.idTipoOperacion,
	       Numero_Operacion,
	       tbl.Correlativo,               --    numero_flujo
	       ISNULL(srfp.idFormaPago, -1),
	       ABS(MontoM1),                  --    Pagamos_Monto
	       FechaLiquidacion,
	       Tbl.Rut_Contraparte,           --    Rut_Cliente,
	       c.Cldv,
	       c.Clnombre,
	       ISNULL(sb.idCodBanco,c.CodBancoReceptor),
	       c.Clctacte,
	       1,
	       @idValDefault,
	       @idValDefault,
	       tbl.MonedaM1,                  --    Pagamos_Moneda,
	       tbl.Codigo_Contraparte,        --    tbl.Codigo_Cliente
	       fdp.diasvalor,
			CASE WHEN ISNULL(sb.idCodBanco,-1) = -1 THEN -1
			ELSE  CASE WHEN Tbl.MontoM1  < 0 THEN 299    -- Pagamos_Monto
					ELSE 298 
				END
			END , -->sto.sTOPER_MensajeEnvio,
	       1,
	       tbl.FormaPago1                                                                 -- Pagamos_Documento          
	FROM   #TEMP_TBL_CAJA_DERIVADOS Tbl WITH(NOLOCK)
	INNER JOIN bacparamsuda.dbo.CLIENTE c WITH (NOLOCK)
	            ON  c.clrut = tbl.Rut_Contraparte                                         -- Rut_Cliente
	            AND c.clcodigo = tbl.Codigo_Contraparte                                   -- Codigo_Cliente 
	LEFT JOIN #tmp_SADP_RelacionFormaPago srfp WITH (NOLOCK)
	            ON  srfp.idEntidad = @idEntidad
	            AND srfp.vRELFP_FormaPago = tbl.FormaPago1                                -- Pagamos_documento
	INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO fdp WITH (NOLOCK)
	            ON  fdp.codigo = tbl.FormaPago1                                           -- Pagamos_documento
	INNER JOIN #tmp_SADP_TipoOperaciones sto
	            ON  sto.idEntidad = @idEntidad
	            AND sto.idModulo = @idModuloPCS
	            AND sto.sTOPER_Generico = 'V' + RTRIM(CONVERT(VARCHAR(5), tbl.Producto))  -- tipo_swap
	                + CASE 
	                       WHEN Tbl.MontoM1 < 0.0 THEN 'P'                                -- Pagamos_Monto
	                       ELSE 'C'
	                  END
	LEFT JOIN #tmp_SADP_Bancos sb ON sb.iBAN_Rut = c.Clrut 
	WHERE  Tbl.MontoM1  <> 0.0                                                            -- Pagamos_Monto
    AND tbl.Modalidad_Pago = 'C'                                                      -- solo comenzados incluye anticipos
	AND tbl.Modulo = 'PCS'						---> JBH, PRD-24048, 18-08-2015
	--AND tbl.fechaLiquidacion = @dFecProceso		---> JBH, PRD-24048, 18-08-2015


	-->Revisar las Entregas Físicas
	IF EXISTS(SELECT 1 FROM #TEMP_TBL_CAJA_DERIVADOS WITH(NOLOCK) WHERE fechaLiquidacion = @dFecProceso
				AND Modalidad_Pago = 'E')
	BEGIN
		--> Hay operaciones con Entrega Física
		-->Primero, la pata en MX (USD/EUR)
		INSERT INTO #tblOperaciones
		(
			idEntidad,
			idModulo,
			idTipoOperacion,
			iOPE_Operacion,
			iDETOPE_Correlativo,
			idFormaPago,
			fDETOPE_MontoPago,
			dDETOPE_FechaLiquidacion,
			iDETOPE_RutBeneficiario,
			sDETOPE_dvBeneficiario,
			sDETOPE_Beneficiario,
			idCodBanco,
			sDETOPE_NumeroCuenta,
			idEstado,
			iDETOPE_BancoReceptor,
			iDETOPE_BancoIntermediario,
			iDETOPE_Moneda,
			iDETOPE_CodCli,
			DiasValor,
			idMensaje,
			iRegistro,
			iForPagoOrig
		)
		SELECT 
		@idEntidad,
		@idModuloPCS,
		sto.idTipoOperacion,
		Numero_Operacion,
		tbl.Correlativo,               --    numero_flujo
		ISNULL(srfp.idFormaPago, -1),
		ABS(MontoM1),                  --    Pagamos_Monto
		FechaLiquidacion,
		Tbl.Rut_Contraparte,           --    Rut_Cliente,
		c.Cldv,
		c.Clnombre,
		ISNULL(sb.idCodBanco,c.CodBancoReceptor),
		c.Clctacte,
		1,
		@idValDefault,
		@idValDefault,
		tbl.MonedaM1,                  --    Pagamos_Moneda,
		tbl.Codigo_Contraparte,        --    tbl.Codigo_Cliente
		fdp.diasvalor,
		CASE WHEN ISNULL(sb.idCodBanco,-1) = -1 THEN -1
			ELSE  CASE WHEN Tbl.MontoM1  < 0 THEN 299    -- Pagamos_Monto
						ELSE 298 
					END
		END , -->sto.sTOPER_MensajeEnvio,
		1,
		tbl.FormaPago1                                                                 -- Pagamos_Documento          
		FROM   #TEMP_TBL_CAJA_DERIVADOS Tbl WITH(NOLOCK)
		INNER JOIN bacparamsuda.dbo.CLIENTE c WITH (NOLOCK)
			ON  c.clrut = tbl.Rut_Contraparte                                         -- Rut_Cliente
			AND c.clcodigo = tbl.Codigo_Contraparte                                   -- Codigo_Cliente 
		LEFT JOIN #tmp_SADP_RelacionFormaPago srfp WITH (NOLOCK)
			ON  srfp.idEntidad = @idEntidad
			AND srfp.vRELFP_FormaPago = tbl.FormaPago1                                -- Pagamos_documento
		INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO fdp WITH (NOLOCK)
			ON  fdp.codigo = tbl.FormaPago1                                           -- Pagamos_documento
		INNER JOIN #tmp_SADP_TipoOperaciones sto
			ON  sto.idEntidad = @idEntidad
			AND sto.idModulo = @idModuloPCS
			AND sto.sTOPER_Generico = 'V' + RTRIM(CONVERT(VARCHAR(5), tbl.Producto))  -- tipo_swap
				+ CASE 
						WHEN Tbl.MontoM1 < 0.0 THEN 'P'                                -- Pagamos_Monto
						ELSE 'C'
					END
		LEFT JOIN #tmp_SADP_Bancos sb ON sb.iBAN_Rut = c.Clrut 
		WHERE  Tbl.MontoM1  <> 0.0                                                            -- Pagamos_Monto
		AND tbl.Modalidad_Pago = 'E'                                                      -- solo comenzados incluye anticipos
		AND tbl.Modulo = 'PCS'						
		--AND tbl.fechaLiquidacion = @dFecProceso		

		-->Luego, la pata en CLP
		INSERT INTO #tblOperaciones
		(
			idEntidad,
			idModulo,
			idTipoOperacion,
			iOPE_Operacion,
			iDETOPE_Correlativo,
			idFormaPago,
			fDETOPE_MontoPago,
			dDETOPE_FechaLiquidacion,
			iDETOPE_RutBeneficiario,
			sDETOPE_dvBeneficiario,
			sDETOPE_Beneficiario,
			idCodBanco,
			sDETOPE_NumeroCuenta,
			idEstado,
			iDETOPE_BancoReceptor,
			iDETOPE_BancoIntermediario,
			iDETOPE_Moneda,
			iDETOPE_CodCli,
			DiasValor,
			idMensaje,
			iRegistro,
			iForPagoOrig
		)
		SELECT 
		@idEntidad,
		@idModuloPCS,
		sto.idTipoOperacion,
		Numero_Operacion,
		tbl.Correlativo,               --    numero_flujo
		ISNULL(srfp.idFormaPago, -1),
		ABS(MontoM2),                  --    Pagamos_Monto
		FechaLiquidacion,
		Tbl.Rut_Contraparte,           --    Rut_Cliente,
		c.Cldv,
		c.Clnombre,
		ISNULL(sb.idCodBanco,c.CodBancoReceptor),
		c.Clctacte,
		1,
		@idValDefault,
		@idValDefault,
		tbl.MonedaM2,                  --    Pagamos_Moneda,
		tbl.Codigo_Contraparte,        --    tbl.Codigo_Cliente
		fdp.diasvalor,
		CASE WHEN ISNULL(sb.idCodBanco,-1) = -1 THEN -1
			ELSE  CASE WHEN Tbl.MontoM2  < 0 THEN 299    -- Pagamos_Monto
						ELSE 298 
					END
		END , -->sto.sTOPER_MensajeEnvio,
		1,
		tbl.FormaPago2                                                                 -- Pagamos_Documento          
		FROM   #TEMP_TBL_CAJA_DERIVADOS Tbl WITH(NOLOCK)
		INNER JOIN bacparamsuda.dbo.CLIENTE c WITH (NOLOCK)
			ON  c.clrut = tbl.Rut_Contraparte                                         -- Rut_Cliente
			AND c.clcodigo = tbl.Codigo_Contraparte                                   -- Codigo_Cliente 
		LEFT JOIN #tmp_SADP_RelacionFormaPago srfp WITH (NOLOCK)
			ON  srfp.idEntidad = @idEntidad
			AND srfp.vRELFP_FormaPago = tbl.FormaPago2                                -- Pagamos_documento
		INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO fdp WITH (NOLOCK)
			ON  fdp.codigo = tbl.FormaPago2                                           -- Pagamos_documento
		INNER JOIN #tmp_SADP_TipoOperaciones sto
			ON  sto.idEntidad = @idEntidad
			AND sto.idModulo = @idModuloPCS
			AND sto.sTOPER_Generico = 'V' + RTRIM(CONVERT(VARCHAR(5), tbl.Producto))  -- tipo_swap
				+ CASE 
						WHEN Tbl.MontoM2 < 0.0 THEN 'P'                                -- Pagamos_Monto
						ELSE 'C'
					END
		LEFT JOIN #tmp_SADP_Bancos sb ON sb.iBAN_Rut = c.Clrut 
		WHERE  Tbl.MontoM2  <> 0.0                                                            -- Pagamos_Monto
		AND tbl.Modalidad_Pago = 'E'                                                      -- solo comenzados incluye anticipos
		AND tbl.Modulo = 'PCS'						
		--AND tbl.fechaLiquidacion = @dFecProceso		
	END

	
	--> ASIGNAR VALORES POR DEFECTO

	UPDATE	#tblOperaciones
	SET		idCodBanco				= v.idCodBanco,
			idFormaPago				= v.idFormaPago, --> Incluir la FPago
			sDETOPE_NumeroCuenta	= v.sVPD_NumCuenta,
			iDETOPE_RutBeneficiario = v.sVPD_RutBeneficiario,
		    sDETOPE_dvBeneficiario	= v.sVPD_DvBeneficiario,
		    sDETOPE_Beneficiario	= v.sVPD_NombreBeneficiario
	FROM   #tblOperaciones tbl
	       INNER JOIN #tmp_sadp_ValoresDefectos v
	            ON  v.iVPD_RutCliente	= tbl.iDETOPE_RutBeneficiario
	            AND v.iVPD_CodCliente	= tbl.iDETOPE_CodCli
	            AND v.idCodMoneda		= tbl.iDETOPE_Moneda
				AND v.idTipoOperacion	= tbl.idTipoOperacion
	WHERE	tbl.idEntidad = @idEntidad
	AND		tbl.idModulo = @idModuloPCS
	/*SWAP************************************************************/


	

	--	CREATE table #tblOperacionesFinal  aqui
	--select * from #tblOperacionesFinal
	--select '#tblOperaciones' as tabla,* from #tblOperaciones

	insert into #tblOperacionesFinal
	select distinct --'#tblOperacionesFinal  ' as tabla,
		'IdEntidad'			= op.idEntidad			--[int]			NOT NULL,
		,'FechaProceso'		= convert(char(8),convert(datetime,@dFecProceso),112)		--[varchar](8)	NOT NULL,
		,'TipoCaja'			= 'I'				--[char](1)		NOT NULL,
		,'Modulo'			= 'PCS'				--[varchar](3)	NOT NULL,
		,'TipoProducto'		= tp.sTOPER_Generico--[varchar](3)	NOT NULL,
		,'TipoOperacion'	= (case CAJ.Tipo_Flujo when 1 then 'R' else 'P' end)--[char](1)		NOT NULL,
		,'NumOperacion'		= iOPE_Operacion	--[int]			NOT NULL,
		,'MontoOrigen'		= fDETOPE_MontoPago	--[numeric](19,4) NOT NULL,
		,'MonedaOrigen'		= iDETOPE_Moneda	--[numeric](3)	NOT NULL,
		,'Precio'			= 0--[numeric](19,4) NOT NULL,
		,'Moneda_2'			= iDETOPE_Moneda--Moneda2--[numeric](3)	NOT NULL,
		,'MontoMoneda_2'	= Monto2--[numeric](19,4) NOT NULL,
		,'FechaVencimiento'	= convert(char(8),convert(datetime,dDETOPE_FechaLiquidacion),112)--[varchar](8)	NOT NULL,
		,'FechaValuta'		= convert(char(8),convert(datetime,dDETOPE_FechaLiquidacion),112)--Valuta2 [varchar](8)	NOT NULL,
		,'NroFlujo'			= iDETOPE_Correlativo--''--[numeric]		NOT NULL,

		,'NombreCliente'	= sDETOPE_Beneficiario--[varchar]		NOT NULL,
		,'RutCliente'		= iDETOPE_RutBeneficiario--[numeric]		NOT NULL,
		,'DVRutCliente'		= sDETOPE_dvBeneficiario--[char](1)		NOT NULL,
		,'CodigoCliente'	= iDETOPE_CodCli--[numeric]		NOT NULL,
		,'TipoCliente'		= 0--[numeric]		NOT NULL,
		
		,'NombreBeneficiario'	=sDETOPE_Beneficiario--[varchar]		NOT NULL,
		,'RutBeneficiario'		=iDETOPE_RutBeneficiario--[numeric]		NOT NULL,
		,'DVRutBeneficiario'	=sDETOPE_dvBeneficiario--[char](1)		NOT NULL,
		,'CodigoBeneficiario'	=0--[numeric]		NOT NULL,
		
		,'Modalidad'			= modalidad--[char](1)		NOT NULL,
		,'CodFormaPago'			= idFormaPago--[numeric]		NOT NULL,
		,'idCodBanco'			= idCodBanco--[numeric]		NOT NULL,
		,'NumeroCuenta'			= sDETOPE_NumeroCuenta--[varchar]		NOT NULL,
		,'idBancoReceptor'		= 0--[numeric]		NOT NULL,
		,'idBancoIntermediario'	= 0--[numeric]		NOT NULL,
	
		,'Estado'			= 'V'--[char](1)		NOT NULL,
		,'FILLER1'			= ''--[char](1)		NOT NULL,
		,'FILLER2'			= ''--[char](1)		NOT NULL,
		,'FILLER3'			= ''--[char](1)		NOT NULL,
		,'FILLER4'			= ''--[char](1)		NOT NULL,
		,'FILLER5'			= ''--[char](1)		NOT NULL,
	from #tblOperaciones op
	inner join DB_SADP_Filiales..SADP_TipoOperaciones tp on tp.idEntidad		= op.idEntidad
														and tp.idModulo		= op.idModulo
														and tp.idTipoOperacion=op.idTipoOperacion
	inner join BACPARAMSUDA..TBL_CAJA_DERIVADOS_DETALLE CAJ on caj.Numero_Operacion = op.iOPE_Operacion
														and caj.fechaLiquidacion = op.dDETOPE_FechaLiquidacion
	

	--inner join #tmp_cartera	ca on ca.numero_operacion = caj.Numero_Operacion
	where op.idModulo=5--swap
	--iOPE_Operacion = 10377


	---renta fija
	--select * from #tblOperaciones op where idModulo = 3
	insert into #tblOperacionesFinal
	select distinct --'#tblOperacionesFinal  ' as tabla,
		'IdEntidad'			= op.idEntidad			--[int]			NOT NULL,
		,'FechaProceso'		= convert(char(8),convert(datetime,@dFecProceso),112)		--[varchar](8)	NOT NULL,
		,'TipoCaja'			= 'I'				--[char](1)		NOT NULL,
		,'Modulo'			= 'BTR'				--[varchar](3)	NOT NULL,
		,'TipoProducto'		= SUBSTRING(tp.sTOPER_Generico,1,3)--[varchar](3)	NOT NULL,--REVISAR TIPO GENERICOS POR LARGO MAYORES A 3
		,'TipoOperacion'	= ''--(case CAJ.Tipo_Flujo when 1   then 'R' else 'P' end)--[char](1)		NOT NULL,
		,'NumOperacion'		= iOPE_Operacion	--[int]			NOT NULL,
		,'MontoOrigen'		= fDETOPE_MontoPago	--[numeric](19,4) NOT NULL,
		,'MonedaOrigen'		= iDETOPE_Moneda	--[numeric](3)	NOT NULL,
		,'Precio'			= 0--[numeric](19,4) NOT NULL,
		,'Moneda_2'			= iDETOPE_Moneda--Moneda2--[numeric](3)	NOT NULL,
		,'MontoMoneda_2'	= Monto2--[numeric](19,4) NOT NULL,
		,'FechaVencimiento'	= convert(char(8),convert(datetime,dDETOPE_FechaLiquidacion),112)--[varchar](8)	NOT NULL,
		,'FechaValuta'		= convert(char(8),convert(datetime,dDETOPE_FechaLiquidacion),112)--Valuta2 [varchar](8)	NOT NULL,
		,'NroFlujo'			= iDETOPE_Correlativo--''--[numeric]		NOT NULL,

		,'NombreCliente'	= sDETOPE_Beneficiario--[varchar]		NOT NULL,
		,'RutCliente'		= iDETOPE_RutBeneficiario--[numeric]		NOT NULL,
		,'DVRutCliente'		= sDETOPE_dvBeneficiario--[char](1)		NOT NULL,
		,'CodigoCliente'	= iDETOPE_CodCli--[numeric]		NOT NULL,
		,'TipoCliente'		= 0--[numeric]		NOT NULL,
		
		,'NombreBeneficiario'	=sDETOPE_Beneficiario--[varchar]		NOT NULL,
		,'RutBeneficiario'		=iDETOPE_RutBeneficiario--[numeric]		NOT NULL,
		,'DVRutBeneficiario'	=sDETOPE_dvBeneficiario--[char](1)		NOT NULL,
		,'CodigoBeneficiario'	=0--[numeric]		NOT NULL,
		
		,'Modalidad'			= modalidad--[char](1)		NOT NULL,
		,'CodFormaPago'			= idFormaPago--[numeric]		NOT NULL,
		,'idCodBanco'			= idCodBanco--[numeric]		NOT NULL,
		,'NumeroCuenta'			= sDETOPE_NumeroCuenta--[varchar]		NOT NULL,
		,'idBancoReceptor'		= 0--[numeric]		NOT NULL,
		,'idBancoIntermediario'	= 0--[numeric]		NOT NULL,
	
		,'Estado'			= 'V'--[char](1)		NOT NULL,
		,'FILLER1'			= ''--[char](1)		NOT NULL,
		,'FILLER2'			= ''--[char](1)		NOT NULL,
		,'FILLER3'			= ''--[char](1)		NOT NULL,
		,'FILLER4'			= ''--[char](1)		NOT NULL,
		,'FILLER5'			= ''--[char](1)		NOT NULL,
	from #tblOperaciones op
	inner join DB_SADP_Filiales..SADP_TipoOperaciones tp on tp.idEntidad		= op.idEntidad
														and tp.idModulo		= op.idModulo
														and tp.idTipoOperacion=op.idTipoOperacion
	where op.idModulo=3--renta fija

	--select '#tblOperaciones' as tabla,* from #tblOperaciones where iOPE_Operacion = 10377
	--select '#tmp_cartera' as tabla,* from #tmp_cartera where numero_operacion = 10377 
	--select '#tblOperacionesFinal' as tabla,* from #tblOperacionesFinal

--	select 'tblOperaciones' as tabla,* from #tblOperaciones
	--SALIDA FINAL
	/*
	SELECT
		 [idEntidad]						
		,[idModulo]						
		,[idTipoOperacion]				
		,[iOPE_Operacion]				
		,[iDETOPE_Correlativo]			
		,[idFormaPago]					
		,[fDETOPE_MontoPago]				
		,[dDETOPE_FechaLiquidacion]		
		,[iDETOPE_RutBeneficiario]		
		,[sDETOPE_dvBeneficiario]		
		,[sDETOPE_Beneficiario]			
		,[idCodBanco]					
		,[sDETOPE_NumeroCuenta]			
		,[idEstado]						
		,[iDETOPE_BancoReceptor]			
		,[iDETOPE_BancoIntermediario]	
		,[iDETOPE_Moneda]				
		,[iDETOPE_CodCli]				
		,[DiasValor]						
		,[idMensaje]						
		,[iRegistro]						
		,[Agrupada]						
		,[Referencia]					
		,[Monto2]						
		,[Moneda2]						
		,[Valuta2]						
		,[Cantidad]						
		,[iForPagoOrig]					
	FROM #tblOperaciones
	*/
	
	INSERT INTO #VM_BAC_USER_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		SELECT 
		"idEntidad" = idEntidad,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		+ RTRIM(LTRIM([IdEntidad]))      + @SEP 						
		+ RTRIM(LTRIM(convert(char(8),convert(datetime,[FechaProceso]),112) ))      + @SEP 
		+ RTRIM(LTRIM([TipoCaja]))      + @SEP 						
		+ RTRIM(LTRIM([Modulo]))      + @SEP 				
		+ RTRIM(LTRIM([TipoProducto]))      + @SEP 				
		+ RTRIM(LTRIM([TipoOperacion]))      + @SEP 			
		+ RTRIM(LTRIM([NumOperacion]))      + @SEP 					
		+ RTRIM(LTRIM([MontoOrigen]))      + @SEP 				
		+ RTRIM(LTRIM([MonedaOrigen]))      + @SEP 		
		+ RTRIM(LTRIM([Precio]))      + @SEP 	
		+ RTRIM(LTRIM([Moneda_2]))      + @SEP 	
		+ RTRIM(LTRIM([MontoMoneda_2]))      + @SEP 	
		+ RTRIM(LTRIM(convert(char(8),convert(datetime,[FechaVencimiento]),112) ))      + @SEP 
		+ RTRIM(LTRIM(convert(char(8),convert(datetime,[FechaValuta]),112) ))      + @SEP 
		+ RTRIM(LTRIM([NroFlujo]))      + @SEP 			
		+ RTRIM(LTRIM([NombreCliente]))      + @SEP 						
		+ RTRIM(LTRIM([RutCliente]))      + @SEP 			
		+ RTRIM(LTRIM([DVRutCliente]))      + @SEP 	
		+ RTRIM(LTRIM([CodigoCliente]))      + @SEP 				
		+ RTRIM(LTRIM([TipoCliente]))      + @SEP 				
		+ RTRIM(LTRIM([NombreBeneficiario]))      + @SEP 						
		+ RTRIM(LTRIM([RutBeneficiario]))      + @SEP 						
		+ RTRIM(LTRIM([DVRutBeneficiario]))      + @SEP 						
		+ RTRIM(LTRIM([CodigoBeneficiario]))      + @SEP 						
		+ RTRIM(LTRIM([Modalidad]))      + @SEP 					
		+ RTRIM(LTRIM([CodFormaPago]))      + @SEP 						
		+ RTRIM(LTRIM([idCodBanco]))      + @SEP 						
		+ RTRIM(LTRIM([NumeroCuenta]))      + @SEP 						
		+ RTRIM(LTRIM([idBancoReceptor]))      + @SEP 						
		+ RTRIM(LTRIM([idBancoIntermediario]))      + @SEP 						
		+ RTRIM(LTRIM([Estado]))      + @SEP 						
		+ RTRIM(LTRIM([FILLER1]))      + @SEP 						
		+ RTRIM(LTRIM([FILLER2]))      + @SEP 						
		+ RTRIM(LTRIM([FILLER3]))      + @SEP 						
		+ RTRIM(LTRIM([FILLER4]))      + @SEP 						
		+ RTRIM(LTRIM([FILLER5]))      					
	  AS REG_SALIDA
      FROM #tblOperacionesFinal
--      ORDER BY USR_ID 	-- se comenta porque no es necesario a este nivel-- PLL-20200512

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_USER_SALIDA
		SELECT 
			"USR_ID" = -999,
			"REG_SALIDA" = 
			+ 'IdEntidad'		+ @SEP 						
			+ 'FechaProceso'	+ @SEP 
			+ 'TipoCaja'		+ @SEP 						
			+ 'Modulo'			+ @SEP 				
			+ 'TipoProducto'	+ @SEP 				
			+ 'TipoOperacion'	+ @SEP 			
			+ 'NumOperacion'	+ @SEP 					
			+ 'MontoOrigen'		+ @SEP 				
			+ 'MonedaOrigen'	+ @SEP 		
			+ 'Precio'			+ @SEP 		
			+ 'Moneda_2'	+ @SEP 	
			+ 'MontoMoneda_2'	+ @SEP 	
			+ 'FechaVencimiento'+ @SEP 
			+ 'FechaValuta'		+ @SEP 
			+ 'NroFlujo'		+ @SEP 			
			+ 'NombreCliente'	+ @SEP 						
			+ 'RutCliente'		+ @SEP 			
			+ 'DVRutCliente'	+ @SEP 	
			+ 'CodigoCliente'	+ @SEP 				
			+ 'TipoCliente'		+ @SEP 				
			+ 'NombreBeneficiario'	+ @SEP 						
			+ 'RutBeneficiario'		+ @SEP 						
			+ 'DVRutBeneficiario'	+ @SEP 						
			+ 'CodigoBeneficiario'	+ @SEP 						
			+ 'Modalidad'		+ @SEP 					
			+ 'CodFormaPago'	+ @SEP 						
			+ 'idCodBanco'		+ @SEP 						
			+ 'NumeroCuenta'	+ @SEP 						
			+ 'idBancoReceptor'	+ @SEP 						
			+ 'idBancoIntermediario'+ @SEP 						
			+ 'Estado'			+ @SEP 						
			+ 'FILLER1'			+ @SEP 						
			+ 'FILLER2'			+ @SEP 						
			+ 'FILLER3'			+ @SEP 						
			+ 'FILLER4'			+ @SEP 						
			+ 'FILLER5'
		WHERE @Con_Linea_Encabezado = 'Y'
		
	/*SALIDA OLD
	INSERT INTO #VM_BAC_USER_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		SELECT 
		"idEntidad" = idEntidad,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		  RTRIM(LTRIM([idEntidad]))      + @SEP 						
		+ RTRIM(LTRIM([idModulo]))      + @SEP 						
		+ RTRIM(LTRIM([idTipoOperacion]))      + @SEP 				
		+ RTRIM(LTRIM([iOPE_Operacion]))      + @SEP 				
		+ RTRIM(LTRIM([iDETOPE_Correlativo]))      + @SEP 			
		+ RTRIM(LTRIM([idFormaPago]))      + @SEP 					
		+ RTRIM(LTRIM([fDETOPE_MontoPago]))      + @SEP 				
		+ RTRIM(LTRIM(CONVERT(CHAR(10),[dDETOPE_FechaLiquidacion],103)))      + @SEP 		
		+ RTRIM(LTRIM([iDETOPE_RutBeneficiario]))      + @SEP 		
		+ RTRIM(LTRIM([sDETOPE_dvBeneficiario]))      + @SEP 		
		+ RTRIM(LTRIM([sDETOPE_Beneficiario]))      + @SEP 			
		+ RTRIM(LTRIM([idCodBanco]))      + @SEP 					
		+ RTRIM(LTRIM([sDETOPE_NumeroCuenta]))      + @SEP 			
		+ RTRIM(LTRIM([idEstado]))      + @SEP 						
		+ RTRIM(LTRIM([iDETOPE_BancoReceptor]))      + @SEP 			
		+ RTRIM(LTRIM([iDETOPE_BancoIntermediario]))      + @SEP 	
		+ RTRIM(LTRIM([iDETOPE_Moneda]))      + @SEP 				
		+ RTRIM(LTRIM([iDETOPE_CodCli]))      + @SEP 				
		+ RTRIM(LTRIM([DiasValor]))      + @SEP 						
		+ RTRIM(LTRIM([idMensaje]))      + @SEP 						
		+ RTRIM(LTRIM([iRegistro]))      + @SEP 						
		+ RTRIM(LTRIM([Agrupada]))      + @SEP 						
		+ RTRIM(LTRIM([Referencia]))      + @SEP 					
		+ RTRIM(LTRIM([Monto2]))      + @SEP 						
		+ RTRIM(LTRIM([Moneda2]))      + @SEP 						
		+ RTRIM(LTRIM(CONVERT(CHAR(10),[Valuta2],103)))      + @SEP 						
		+ RTRIM(LTRIM([Cantidad]))      + @SEP 						
		+ RTRIM(LTRIM([iForPagoOrig]))      
	  AS REG_SALIDA
      FROM #tblOperaciones
--      ORDER BY USR_ID 	-- se comenta porque no es necesario a este nivel-- PLL-20200512

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_USER_SALIDA
		SELECT 
			"USR_ID" = -999,
			"REG_SALIDA" = 
			+ 'idEntidad' + @SEP						
			+ 'idModulo' + @SEP						
			+ 'idTipoOperacion' + @SEP				
			+ 'iOPE_Operacion' + @SEP				
			+ 'iDETOPE_Correlativo' + @SEP			
			+ 'idFormaPago' + @SEP					
			+ 'fDETOPE_MontoPago' + @SEP				
			+ 'dDETOPE_FechaLiquidacion' + @SEP		
			+ 'iDETOPE_RutBeneficiario' + @SEP		
			+ 'sDETOPE_dvBeneficiario' + @SEP		
			+ 'sDETOPE_Beneficiario' + @SEP			
			+ 'idCodBanco' + @SEP					
			+ 'sDETOPE_NumeroCuenta' + @SEP			
			+ 'idEstado' + @SEP						
			+ 'iDETOPE_BancoReceptor' + @SEP			
			+ 'iDETOPE_BancoIntermediario' + @SEP	
			+ 'iDETOPE_Moneda' + @SEP				
			+ 'iDETOPE_CodCli' + @SEP				
			+ 'DiasValor' + @SEP						
			+ 'idMensaje' + @SEP						
			+ 'iRegistro' + @SEP						
			+ 'Agrupada' + @SEP						
			+ 'Referencia' + @SEP					
			+ 'Monto2' + @SEP						
			+ 'Moneda2' + @SEP						
			+ 'Valuta2' + @SEP						
			+ 'Cantidad' + @SEP						
			+ 'iForPagoOrig'
		WHERE @Con_Linea_Encabezado = 'Y'
		SALIDA OLD */
		

	SELECT REG_SALIDA FROM #VM_BAC_USER_SALIDA 
	ORDER BY USR_ID


END 
GRANT EXECUTE ON DBO.SP_INTERFAZ_SALDOS_PROYECTADOS TO GRP_BACTRADER
GO
