USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_BALANCE_FORWARD_ALE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_BALANCE_FORWARD_ALE] -- dbo.Sp_Interfaz_balance_forward_ALE  '20030829','20040829'
		( @FECHAFINMESHabil  CHAR(8),
		  @FECHAFINMES       CHAR(8))

AS
BEGIN
-- select caperdsaldo, cautilsaldo, * from mfca where cacodpos1 =1 2490  2469
-- select * from mfac
-- select * from mfca where canumoper = 2695                 
-- select * from view_moneda
	SET NOCOUNT ON
	DECLARE   @Cuenta            CHAR(20)
         ,@Tipo_Monto        CHAR(1)
         ,@Numero_Voucher    NUMERIC(9)
         ,@Correlativo       NUMERIC(5)
         ,@Moneda            NUMERIC(5)
         ,@Monto             FLOAT
         ,@Operacion         NUMERIC(9)
         ,@Tipo_Operacion    CHAR(5)
         ,@Glosa             CHAR(70)
         ,@Tipo_Voucher      CHAR(1)
         ,@Numero            NUMERIC(5)
         ,@x                 INTEGER
         ,@num_oper          NUMERIC(9)
         ,@tip_oper          CHAR(1)
         ,@cod_pro           CHAR(4)
         ,@T_prod            CHAR(4)
         ,@max               INTEGER
         ,@FECHA             DATETIME
         ,@vDolar_obsFinMes  FLOAT
         ,@vUF_FinMes        FLOAT
         ,@cal_monto         FLOAT
         ,@signo             CHAR(1)
         ,@T_monto           CHAR(1) 
         ,@cMoneda           NUMERIC(5)
	 ,@TIP               CHAR(1)

	SELECT @FECHA = (SELECT acfecproc FROM MFAC)

	select @vDolar_obsFinMes = isnull((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = @FECHAFINMESHabil),0)
	select @vUF_FinMes       = isnull((select vmvalor from view_valor_moneda where vmcodigo = 998 and vmfecha = @FECHAFINMES),0)

-- (select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha ='20030530' ),0)
         select vmptacmp ,mnrefusd  ,mncodmon ,vmvalor
           into #tipocambio 
           from view_valor_moneda, view_moneda
          where vmcodigo = mncodmon and vmfecha = @FECHAFINMESHabil


	CREATE TABLE #TEMP_INTERFAZ
                 (
                        T_Producto        CHAR(4)
                       ,Producto          CHAR(4)
                       ,Nro_Operacion     VARCHAR(20)
                       ,Fecha_Contable    DATETIME
                       ,Cuenta            CHAR(20)
                       ,Indicador         CHAR(1)
                       ,Cod_Evento_Cble   CHAR(3)
                       ,S_B_Mda_Origin    CHAR(1)
                       ,B_Mda_Original    Float
                       ,S_B_Mda_Local     CHAR(1)
                       ,B_Mda_Local       FLOAT
                       ,S_B_Local_Agregdo CHAR(1)
                       ,B_Local_Agregdo   FLOAT
                       ,C_Moneda          NUMERIC(2)
                     )                  

	/*
	TRATAMIENTO DE CUENTAS IBF
	-------------------------------
	ACTIVOS (DEBITO) 1000-2900
	PASIVOS (CREDITO) 3000-4900
	RESULTADO (-) (DEBITO) 5700-6000
	RESULTADO (+) (CREDITO) 7000-8000
	*/


	/*
	CAMBIO FUTURO COMPRAS
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000028142'		,
		'D'			,
                '0'			,
                '+' 			,
                ABS(camtomon1)		,
                '+'			,
                ABS(caclpmoneda1)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'C'		AND
		cafecvcto > @fecha      

	/*
	COMPRAS CONVERSION 
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068445'		,      -- este
		'C'			,
                '0'			,
                '+' 			,
                ABS(camtomon1)		,
                '+'			,
                ROUND (ABS(camtomon1) * @vDolar_obsFinMes, 0 ) , -- ABS(caclpmoneda1)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon1)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'C'		AND
		cafecvcto > @fecha	 
                
	/*
	COMPRAS USD - UF
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000028118'		,      -- este
		'D'			,
                '0'			,
                '+' 			,
                ABS(camtomon1)		,
                '+'			,
                ROUND (ABS(camtomon1) * @vDolar_obsFinMes, 0 ) , -- ABS(caclpmoneda1)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon1)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'C'		AND
		cafecvcto > @fecha	AND 
                cacodmon2 = 998
               
	/*
	COMPRAS USD-CLP
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000028795'		,      -- este 
		'D'			,
                '0'			,
                '+' 			,
                ABS(camtomon1)		,
                '+'			,
                ROUND (ABS(camtomon1) * @vDolar_obsFinMes, 0 ) ,  --                ABS(caclpmoneda1)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon1 )
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'C'		AND
		cafecvcto > @fecha	AND 
                cacodmon2 = 999

	/*
	ACREEDORES USD-CLP
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068627'		,  -- este
		'C'                     ,
                '0'			,
                '+' 			,
                ABS(camtomon2)		,
                '+'			,
                ABS(caclpmoneda2)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'C'		AND
   		cafecvcto > @fecha      AND 
                cacodmon2 = 999   

	/*
	CAMBIO FUTURO VENTAS
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068346'		,
		'C'			,
                '0'			,
                '+' 			,
                ABS(camtomon1)		,
                '+'			,
                ABS(camtomon1 * @vDolar_obsFinMes )		,-- ABS(caclpmoneda1)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'V'		AND
		cafecvcto > @fecha
/*
select cacodmon1,camtomon1,caclpmoneda1, cacodpos1, (caclpmoneda1 / camtomon1 ) from mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'V'		AND
		cafecvcto > '20031222'
*/
	/*
	VENTAS CONVERSION
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000027706'		,      -- este
		'D',                           --'C'			,
                '0'			,
                '+' 			,
                ABS(camtomon1)		,
                '+'			,
                ROUND (ABS(camtomon1) * @vDolar_obsFinMes, 0 ) ,--- ABS(caclpmoneda1)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon1)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'V'		AND
		cafecvcto > @fecha	

	/*
	VENTAS USD-UF
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068338'		,      -- este
		'C',                           --'C'			,
                '0'			,
                '+' 			,
                ABS(camtomon1)		,
                '+'			,
                ROUND (ABS(camtomon1) * @vDolar_obsFinMes, 0 ) ,--- ABS(caclpmoneda1)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon1)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'V'		AND
		cafecvcto > @fecha	AND 
                cacodmon2 = 998   

	/*
	VENTAS USD-CLP
	*/
         INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068619'		,      -- este 
		'C'			,
                '0'			,
                '+' 			,
		ABS(camtomon1)		,
		'+'			,
                ROUND ( (ABS(camtomon1) * @vDolar_obsFinMes) , 0 ),--ABS(caclpmoneda1)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon1 )
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'V'		AND
		cacodmon2 = 999		AND
		cafecvcto > @fecha

	/*
	DEUDORES USD-CLP
	*/
        INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000028829'		,      -- este 
		'D'			,
                '0'			,
                '+' 			,
                ABS(camtomon2)		,
                '+'			,
                ABS(caclpmoneda2)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon2 )
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'V'		AND
		cacodmon2 = 999		AND
		cafecvcto > @fecha

	/*
	SALDO PERDIDA DIFERIDA COMPRA
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000028126'		,
		'D'			,
                '0'			,
                '+' 			,
                ABS(caperdsaldo)/@vDolar_obsFinMes,
                '+'			,
                ABS(caperdsaldo)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'C'		AND
		cafecvcto > @fecha	AND
		cadiferen < 0

	/*
	SALDO PERDIDA DIFERIDA VENTA
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000027748'		,
		'D'			,
                '0'			,
		'+' 			,
                ABS(caperdsaldo)/@vDolar_obsFinMes,
                '+'			,
                ABS(caperdsaldo)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'V'		AND
		cafecvcto > @fecha	AND
		cadiferen < 0

	/*
	SALDO UTILIDAD DIFERIDA COMPRA
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068460'		,
		'C'			,
                '0'			,
                '+' 			,
                ABS(cautilsaldo)/@vDolar_obsFinMes,
                '+'			,
                ABS(cautilsaldo)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'C'		AND
		cafecvcto > @fecha	AND
		cadiferen > 0

	/*
	SALDO UTILIDAD DIFERIDA VENTA
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068478'		,
		'C'			,
                '0'			,
                '+' 			,
                ABS(cautilsaldo)/@vDolar_obsFinMes,
                '+'			,
                ABS(cautilsaldo)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'V'		AND
		cafecvcto > @fecha	AND
		cadiferen > 0
-- select cautilsaldo, * from mfca where cacodpos1 =  1  and cafecvcto > '20030430'
	/*
	SALDO DEUDORES VENTA DIVISAS UF
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000027722'		,
		'D'			,
                '0'			,
                '+' 			,
                ABS(camtomon2)		,
                '+'			,
                ABS(caclpmoneda2)	,--ROUND( (ABS(camtomon2)* @vUF_FinMes),0) , -- 
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'V'		AND
		cacodmon2 = 998		AND
		cafecvcto > @fecha
/* NO SE MODIFICO REVISAR

SELECT	camtomon2, caclpmoneda2 ,(caclpmoneda2/ camtomon2),cacodpos1 FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'V'		AND
		cacodmon2 = 998		AND
		cafecvcto > '20031222'
*/

	/*
	SALDO ACREEDORES COMPRA DIVISAS UF
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068452'		,
		'C'			,
                '0'			,
                '+' 			,
                ABS(camtomon2)		,
                '+'			,
                ABS(caclpmoneda2)	,--ROUND( (ABS(camtomon2)* @vUF_FinMes),0),-- 
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'C'		AND
		cacodmon2 = 998		AND
		cafecvcto > @fecha

	/*
	UTILIDAD MERCADO LOCAL Y VARIACION MERCADO LOCAL
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000030494'		,
		'D'			,
                '0'			,
                '+' 			,
                case  mnrefusd  when 0 then ROUND( (ABS(cavalordia) / (@vDolar_obsFinMes / vmptacmp ) ),0)
                                       else ROUND( (ABS(cavalordia) / (@vDolar_obsFinMes * vmptacmp ) ),0)                
                END,
                '+'			,
                ABS(cavalordia)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca		,
		view_cliente    ,
                #tipocambio    
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  = 6		AND
		cavalordia > 0		AND
		cafecvcto > @fecha      AND
                cacodmon1 = mncodmon           
-- 
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000087262'		,
		'C'			,
                '0'			,
                '+' 			,
            case  mnrefusd  when 0 then  ROUND((ABS(cavalordia) / (@vDolar_obsFinMes / vmptacmp ) ),0)
                                       else  ROUND((ABS(cavalordia) / (@vDolar_obsFinMes * vmptacmp ) ),0)   
                END,
                 '+'			,
                ABS(cavalordia)	,

                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca		,
		view_cliente    ,
                #tipocambio          
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  = 6		AND
		cavalordia > 0		AND
		cafecvcto > @fecha      AND
                cacodmon1 = mncodmon           

	/*
	PERDIDA MERCADO LOCAL Y VARIACION MERCADO LOCAL
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000046771'		,
		'D'			,
                '0'			,
                '+' 			,
                case  mnrefusd  when 0 then ROUND( (ABS(cavalordia) / (@vDolar_obsFinMes / vmptacmp ) ),0)
                                       else ROUND( (ABS(cavalordia) / (@vDolar_obsFinMes * vmptacmp ) ),0)                
                END,
                '+'			,
                ABS(cavalordia)	,
               '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca		,
		view_cliente    ,
                #tipocambio          
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  = 6		AND
		cavalordia < 0		AND
		cafecvcto > @fecha      AND
                cacodmon1 = mncodmon           

      INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068908'		,
		'C'			,
                '0'			,
                '+' 			,
                case  mnrefusd  when 0 then  ROUND((ABS(cavalordia) / (@vDolar_obsFinMes / vmptacmp ) ),0)
                                       else  ROUND((ABS(cavalordia) / (@vDolar_obsFinMes * vmptacmp ) ),0)                
                END,
                '+'			,
                ABS(cavalordia)	,

                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca		,
		view_cliente    ,
                #tipocambio          
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  = 6		AND
		cavalordia < 0		AND
		cafecvcto > @fecha      AND
                cacodmon1 = mncodmon    

	/*
	UTILIDAD MERCADO EXTERNO VARIACION MERCADO EXTERNO
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000087882'		,
		'C'			,
                '0'			,
                '+' 			,
                case  mnrefusd  when 0 then  ROUND((ABS(cavalordia) / (@vDolar_obsFinMes / vmptacmp ) ),0)
                                       else  ROUND((ABS(cavalordia) / (@vDolar_obsFinMes * vmptacmp ) ),0)                
                END,
                '+'			,
                ABS(cavalordia)	,

                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca		,
		view_cliente    ,
                #tipocambio     
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  <> 6		AND
		cavalordia > 0		AND
		cafecvcto > @fecha      AND
                cacodmon1 = mncodmon    

	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000033175'		,
		'D'			,
                '0'			,
                '+' 			,
		CASE  mnrefusd  WHEN 0 THEN  ROUND((ABS(cavalordia) / (@vDolar_obsFinMes / vmptacmp ) ),0)
                                       ELSE  ROUND((ABS(cavalordia) / (@vDolar_obsFinMes * vmptacmp ) ),0)                
                END,
                '+'			,
                ABS(cavalordia)	,

               '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca		,
		view_cliente    ,
                #tipocambio     
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  <> 6		AND
		cavalordia > 0		AND
		cafecvcto > @fecha      AND
                cacodmon1 = mncodmon    


	/*
	PERDIDA MERCADO EXTERNO VARIACION MERCADO EXT.
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000040691'		,
		'D'			,
                '0'			,
                '+' 			,
                CASE  mnrefusd  WHEN 0 THEN  ROUND((ABS(cavalordia) / (@vDolar_obsFinMes / vmptacmp ) ),0)
                                       ELSE  ROUND((ABS(cavalordia) / (@vDolar_obsFinMes * vmptacmp ) ),0)                
                END,
                '+'			,
                ABS(cavalordia)	,

                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca		,
		view_cliente    ,
                #tipocambio     
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  <> 6		AND
		cavalordia < 0		AND
		cafecvcto > @fecha      AND
                cacodmon1 = mncodmon    

	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068155'		,
		'C'			,
                '0'			,
                '+' 			,
                CASE  mnrefusd  WHEN 0 THEN  ROUND( (ABS(cavalordia) / (@vDolar_obsFinMes / vmptacmp )),0 )
                                       ELSE  ROUND( (ABS(cavalordia) / (@vDolar_obsFinMes * vmptacmp )),0 )                
                END,
                '+'			,
                ABS(cavalordia)	,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca		,
		view_cliente    ,
                #tipocambio
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  <> 6		AND
		cavalordia < 0		AND
		cafecvcto > @fecha      AND
                cacodmon1 = mncodmon    
-- select carevtot,* from mfca where cacodpos1 = 1
	/*
	PERDIDAS COMPRAS A FUTURO
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000042218'		,
		'D'			,
                '0'			,
		'+' 			,
                ABS(carevtot)/@vDolar_obsFinMes	,
                '+'			,
                ABS(carevtot)		,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'C'		AND
		carevtot < 0		AND
		cafecvcto > @fecha

	/*
	PERDIDAS VENTAS A FUTURO
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000041269'		,
		'D'			,
                '0'			,
                '+' 			,
                ABS(carevtot)/@vDolar_obsFinMes	,
                '+'			,
                ABS(carevtot)		,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'V'		AND
		carevtot < 0		AND
		cafecvcto > @fecha


	/*
	UTILIDAD COMPRAS A FUTURO
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000084236'		,
		'C'			,
                '0'			,
                '+' 			,
                ABS(carevtot)/@vDolar_obsFinMes	,
                '+'			,
		ABS(carevtot)		,
		'+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'C'		AND
		carevtot > 0		AND
		cafecvcto > @fecha

	/*
	UTILIDAD VENTAS A FUTURO
	*/
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000083121'		,
		'C'			,
		'0'			,
               '+' 			,
                ABS(carevtot)/@vDolar_obsFinMes	,
                '+'			,
                ABS(carevtot)		,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = 999)
	FROM	mfca
	WHERE	cacodpos1 IN (1,7)	AND
		catipoper = 'V'		AND
		carevtot > 0		AND
		cafecvcto > @fecha


/* arbitrajes de venta */
-- select * from mfca where cacodpos1 = 2
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000030486'		,  --este
		'D'			,
                '0'			,
                '+' 			,
                ABS(camtomon2)		,
                '+'			,
                ROUND( camtomon2 * @vDolar_obsFinMes, 0) ,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon2)
	FROM	mfca		,
		view_cliente   
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  = 6		AND
		cafecvcto > @fecha      AND
                catipoper = 'V'         




	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000027540'		,
		'D'			,
                '0'			,
                '+' 			,
                ABS(camtomon1)		,
                '+'			,
		ROUND( camtomon1 * vmvalor ,0)  ,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon1)
	FROM	mfca		,
		view_cliente   ,
                #tipocambio    
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  <> 6		AND
		cafecvcto > @fecha      AND
                catipoper = 'V'         and 
                mncodmon = cacodmon1

	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068890'		,
		'C'			,
                '0'			,
                '+' 			,
                ABS(camtomon1)		,
                '+'			,
                round((camtomon1 * vmvalor),0) ,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon1)
	FROM	mfca		,
		view_cliente    ,
                #tipocambio   
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  = 6		AND
		cafecvcto > @fecha      AND
                catipoper = 'V'         and 
                mncodmon = cacodmon1


-- SELECT * FROM MFCA WHERE CACODPOS1 = 2
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068148'		,
		'C'			,
                '0'			,
                '+' 			,
                ABS(camtomon2)		,
                '+'			,
                ROUND(camtomon2 * @vDolar_obsFinMes ,0),
		'+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon2)
	FROM	mfca		,
		view_cliente    

	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  <> 6		AND
		cafecvcto > @fecha      AND
                catipoper = 'V'         


/* aarbitrajes de compra */
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000030486'		,
		'D'			,
                '0'			,
                '+' 			,
                ABS(camtomon2)		,
                '+'			,
                ROUND(camtomon2 * @vDolar_obsFinMes ,0),
               '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon2)
	FROM	mfca		,
		view_cliente    
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  = 6		AND
		cafecvcto > @fecha      AND
                catipoper = 'C'         

	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000027540'		,   -- este
		'D'			,
                '0'			,
                '+' 			,
                ABS(camtomon1)		,
                '+'			,
                round (camtomon1 * vmvalor ,0) ,
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon1)
	FROM	mfca		,
		view_cliente    ,
                #tipocambio    
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  <> 6		AND
		cafecvcto > @fecha      AND
                catipoper = 'C'         and 
                mncodmon = cacodmon1 

	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068890'		,  -- este
		'C'			,
                '0'			,
                '+' 			,
                ABS(camtomon1)		,
                '+'			,
                 round((camtomon1 * vmvalor) ,0),
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon1)
	FROM	mfca		,
		view_cliente    ,
                #tipocambio    
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  = 6		AND
		cafecvcto > @fecha      AND
                catipoper = 'C'         AND 
                mncodmon = cacodmon1

-- select camtomon1,caclpmoneda1, camtomon2,caclpmoneda2,  * FROM	mfca	where cacodpos1 = 2
	INSERT INTO #temp_interfaz
	SELECT 	'MD01'			,
		'MDIR'			,
		canumoper		,
		@fecha			,
		'0000068148'		,  -- este
		'C'			,
                '0'			,
                '+' 			,
                ABS(camtomon2)		,
                '+'			,
                ROUND(camtomon2 * @vDolar_obsFinMes , 0 ),
                '+'			,
                0			,
                (SELECT mncodfox FROM view_moneda WHERE mncodmon = cacodmon2)
	FROM	mfca		,
		view_cliente    
	WHERE	cacodpos1 = 2		AND
		cacodigo  = clrut	AND
		cacodcli  = clcodigo	AND	
		clpais	  <> 6		AND
		cafecvcto > @fecha      AND
                catipoper = 'C'         


	SET NOCOUNT OFF
	SELECT @max = COUNT(*) FROM #temp_interfaz
	SELECT @max,* FROM  #temp_interfaz ORDER BY Nro_Operacion

END

GO
