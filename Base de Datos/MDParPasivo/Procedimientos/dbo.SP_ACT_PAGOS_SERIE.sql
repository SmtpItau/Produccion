USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_PAGOS_SERIE]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACT_PAGOS_SERIE](@Valor_estinmado_1 float
										 ,@Valor_estinmado_2 float 
										 ,@Valor_estinmado_3 float
										 ,@Valor_estinmado_4 float
										 ,@correlativo numeric(3)
										 ,@innumero_operacion  numeric(10)
											)
											
											
AS BEGIN
/**************************************************************************************************
CREADO
AUTOR : SEBASTIÁN ESPINOZA
FECHA : 05/12/2013
MOTIVO: OS5633079 Calculos de Gastos

HISTÓRICO DE CAMBIOS
FECHA           AUTOR		MOTIVO				TAG DE LA MODIFICACION
--------------------------------------------------------------------------------------------------


***************************************************************************************************/
SET NOCOUNT on

DECLARE  @valor_estimado_T		FLOAT
,		@innombre_serie			CHAR(15)
,		@Cant_flujos			FLOAT
,		@nominal_par			FLOAT
,		@valor_estimado_1		FLOAT
,   	@valor_estimado_2		FLOAT
,   	@valor_estimado_3		FLOAT
,   	@valor_estimado_4		FLOAT
,		@innominal				FLOAT
,		@idfecha_colocacion		DATETIME

DECLARE   @cProg  CHAR (23) ,  
		  @iModcal int  ,  
		  @iCodigo int  ,  
		  @cInstser CHAR (12) ,  
		  @iMonemi INTEGER  ,  
		  @dFecemi DATETIME ,  
		  @dFecven DATETIME ,  
		  @fTasemi FLOAT  ,  
		  @fTascol FLOAT  ,  
		  @fBasemi FLOAT  ,  
		  @fTasest FLOAT  , 
		  @ntera    FLOAT , 
		  @fNominal FLOAT  ,  
		  @fTir  FLOAT  ,  
		  @fPvp  FLOAT  ,  
		  @fPvp_emision FLOAT  ,  
		  @npvpcomp       FLOAT           ,  
		  @fMT  FLOAT  ,  
		  @fMT_col FLOAT  ,  
		  @fMTUM  FLOAT           ,  
		  @fMTUM_col FLOAT           ,  
		  @fMT_cien FLOAT  ,  
		  @fVan  FLOAT  ,  
		  @fVpar  FLOAT  ,  
		  @nNumucup int  ,  
		  @dFecucup DATETIME ,  
		  @fIntucup FLOAT  ,  
		  @fAmoucup FLOAT  ,  
		  @fSalucup FLOAT  ,  
		  @nNumpcup int  ,  
		  @dFecpcup DATETIME ,  
		  @fIntpcup FLOAT  ,  
		  @fAmopcup FLOAT  ,  
		  @fSalpcup FLOAT  ,  
		  @fDurat  FLOAT  ,  
		  @fConvx  FLOAT  ,  
		  @fDurmo  FLOAT  ,  
		  @nError  int  ,  
		  @cTipOper CHAR(03),
		  @dFecprox datetime  ,
	
		@inmt_cien FLOAT ,
		@intir FLOAT , @nrango FLOAT , @ndecimales INT , @ntkl FLOAT , @nut FLOAT  , @ncontador INT , @nma FLOAT , @nme FLOAT , @njvan FLOAT

   
select  @dFecprox = Fecha_Proceso from view_datos_generales



SELECT  @valor_estimado_T	= 0
,		@innombre_serie		= A.nombre_serie
,		@nominal_par		= 0
,       @iCodigo			= A.codigo_instrumento
,		@iMonemi			= A.moneda_emision
,		@dFecemi			= A.fecha_emision_papel
,		@dFecven			= A.fecha_vencimiento	
,		@fTasemi            = a.tasa_emision	
,		@fTascol			= a.tasa_colocacion
,	    @fPvp_emision       = A.valor_par_emision
,		@fBasemi			= B.codigo_base
,		@valor_estimado_1	= A.valor_estimado_1
,   	@valor_estimado_2	= A.valor_estimado_2
,   	@valor_estimado_3	= A.valor_estimado_3
,   	@valor_estimado_4	= A.valor_estimado_4
,		@innominal			= nominal
,		@idfecha_colocacion	= A.fecha_colocacion
,		@fVpar              = A.valor_par_emision
,		@dFecucup           = A.fecha_anterior_cupon
,		@ntera				= B.tasa_tera
from	cartera_pasivo A
,	SERIE_PASIVO B
		WHERE 	numero_operacion = @innumero_operacion 
			and numero_correlativo=@correlativo
			AND  A.nombre_serie = B.nombre_serie
			AND B.codigo_instrumento = A.codigo_instrumento

SELECT @valor_estimado_T = @valor_estimado_1 + @valor_estimado_2 + @valor_estimado_3 + @valor_estimado_4 + @innominal



SELECT @Cant_flujos = COUNT(1) FROM FLUJO_BONOS WHERE LTRIM(RTRIM(nombre_serie)) = LTRIM(RTRIM(@innombre_serie)) AND fecha_vencimiento > @dFecprox 



SELECT @nominal_par = @valor_estimado_T / @Cant_flujos


SELECT	'Cant'	= @Cant_flujos
,		'amt'	= @nominal_par
,		* 
INTO	#TEMP_IRR
FROM	FLUJO_BONOS 
WHERE LTRIM(RTRIM(nombre_serie)) = LTRIM(RTRIM(@innombre_serie))
AND fecha_vencimiento > @dFecprox 

DECLARE	@irrPrev FLOAT 
SET		@irrPrev = 0
DECLARE @irr FLOAT 
SET		@irr = 0.1
DECLARE @PresentValuePrev FLOAT
DECLARE @PresentValue FLOAT
DECLARE @t FLOAT


/*
SET @PresentValuePrev =  (SELECT SUM(amt) FROM #TEMP_IRR)

SET @PresentValue = (SELECT SUM(amt/POWER(1e0+@irr,(CONVERT(float, DATEDIFF( DAY, @dFecprox , fecha_vencimiento ))/360e0    ))) FROM #TEMP_IRR  where fecha_vencimiento > @dFecprox  )


WHILE abs(@PresentValue) >= 0.0001
BEGIN

	SET @t = @irrPrev
	SET @irrPrev = @irr

	SET @irr = @irr + (@t-@irr) * @PresentValue / (@PresentValue-@PresentValuePrev)
	SET @PresentValuePrev = @PresentValue

	SET @PresentValue = (SELECT SUM(amt/POWER(1e0 + @irr , ( convert(float, DATEDIFF( DAY, @dFecprox , fecha_vencimiento )))/365e0    )) FROM #TEMP_IRR  where fecha_vencimiento > @dFecprox  )
	
END

*/






SELECT  @iModcal = 2
	   ,@fPvp_emision = 100.0
       ,@fMTUM       = 0.0
       ,@fMT        = 0.0
	   ,@fMT_cien    = 0.0
	   ,@fVan        = 0.0
	   ,@nNumucup    = 0
	   ,@fIntucup    = 0
	   ,@fAmoucup    = 0.0 
	   ,@fSalucup	 = 0.0  
	   ,@nNumpcup	 = 0   
	   ,@fIntpcup	 = 0.0   
	   ,@fAmopcup    = 0.0
	   ,@fSalpcup	 = 0.0   
	   ,@fDurat		 = 0.0
	   ,@fConvx		 = 0.0   	
	   ,@fDurmo  = 0.0      	
	   ,@CPROG='SP_PRO_VALORIZACION'


EXECUTE @nError = @cProg 1, @idfecha_colocacion, @iCodigo, @innombre_serie, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest,  
    @valor_estimado_T OUTPUT, @irr OUTPUT, @fPvp_emision OUTPUT, @fMT OUTPUT, @fMTUM OUTPUT, @fMT_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,  
    @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecucup OUTPUT, --@dFecpcup OUTPUT,  
    @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT  



UPDATE  CARTERA_PASIVO  SET Valor_Estimado_1    =@Valor_estinmado_1
						  ,Valor_Estimado_2     =@Valor_estinmado_2
						  ,Valor_Estimado_3     =@Valor_estinmado_3
						  ,Valor_Estimado_4     =@Valor_estinmado_4
						  ,Tasa_Estimada	    =round(@irr,4)
						  ,Valor_Estimado_Clp   =@fMT
						  ,Valor_Estimado_Um    =@fMTUM	
						  ,Reajuste_Estimado    =0     
						  ,Interes_Estimado     =0
						  ,Presente_Estimado    =@fMT                  
						  ,Valor_Par_Estimado   =@fPvp_emision
		WHERE 	numero_operacion   = @innumero_operacion 
			and numero_correlativo =@correlativo


												   							   
										    
	DROP TABLE #TEMP_IRR															   
												   
END
											
GO
