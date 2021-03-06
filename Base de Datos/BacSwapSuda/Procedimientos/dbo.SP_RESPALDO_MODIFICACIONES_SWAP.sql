USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESPALDO_MODIFICACIONES_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RESPALDO_MODIFICACIONES_SWAP]    
                      @NUMERO_OPERACION  NUMERIC
					 ,@FechaModificacion DATETIME

AS    
BEGIN    


    
	SET NOCOUNT ON   



   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : RESPLADO DE MODIFICACIONES SWAP                             */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 02/06/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     



/*-----------------------------------------------------------------------------*/
/* DECLARACION DE VARIABLES                                                    */
/*-----------------------------------------------------------------------------*/
  DECLARE @C_V_RUT_CLIENTE           VARCHAR(15) = ''
         ,@C_V_NOMBRE                VARCHAR(50) = ''
		 ,@C_V_MONEDA                VARCHAR(05) = ''
		 ,@C_V_NOCIONALES            VARCHAR(30) = ''
		 ,@C_V_FRECUENCIA_PAGO       VARCHAR(30) = ''
		 ,@C_V_FRECUENCIA_CAPITAL    VARCHAR(30) = ''
		 ,@C_V_INDICADOR             VARCHAR(20) = ''
		 ,@C_V_TASA                  VARCHAR(20) = ''
		 ,@C_V_SPREAD                VARCHAR(20) = ''
		 ,@C_V_FECHA_EFECTIVA        VARCHAR(10) = ''
		 ,@C_V_FECHA_MADUREZ         VARCHAR(10) = ''
		 ,@C_V_MONEDA_PAGO           VARCHAR(05) = ''
		 ,@C_V_CARTERA_NORMATIVA     VARCHAR(30) = ''
		 ,@C_V_CONTEO_DIAS           VARCHAR(15) = ''
		 ,@C_V_MEDIO_PAGO            VARCHAR(50) = ''
		 ,@C_V_MODALIDAD_PAGO        VARCHAR(50) = ''
		 ,@C_V_CARTERA_FINANCIERA    VARCHAR(50) = ''
		 ,@C_V_SUB_CARTERA_NORMATIVA VARCHAR(50) = ''
		 ,@C_V_LIBRO_NEGOCIACION     VARCHAR(50) = ''
		 ,@C_V_TIPO_SWAP             VARCHAR(50) = ''
		 ,@C_V_OPERADOR              VARCHAR(30) = ''
		 ,@C_V_VALOR_RAZONABLE       VARCHAR(30) = ''

/*-----------------------------------------------------------------------------*/
/* DECLARACION DE VARIABLES                                                    */
/*-----------------------------------------------------------------------------*/
  DECLARE @C_M_RUT_CLIENTE           VARCHAR(15) = ''
         ,@C_M_NOMBRE                VARCHAR(50) = '' 
		 ,@C_M_MONEDA                VARCHAR(05) = ''
		 ,@C_M_NOCIONALES            VARCHAR(30) = ''
		 ,@C_M_FRECUENCIA_PAGO       VARCHAR(30) = ''
		 ,@C_M_FRECUENCIA_CAPITAL    VARCHAR(30) = ''
		 ,@C_M_INDICADOR             VARCHAR(20) = ''
		 ,@C_M_TASA                  VARCHAR(20) = ''
		 ,@C_M_SPREAD                VARCHAR(20) = ''
		 ,@C_M_FECHA_EFECTIVA        VARCHAR(10) = ''
		 ,@C_M_FECHA_MADUREZ         VARCHAR(10) = ''
		 ,@C_M_MONEDA_PAGO           VARCHAR(05) = ''
		 ,@C_M_CARTERA_NORMATIVA     VARCHAR(30) = ''
		 ,@C_M_CONTEO_DIAS           VARCHAR(15) = ''
		 ,@C_M_MEDIO_PAGO            VARCHAR(50) = ''
		 ,@C_M_MODALIDAD_PAGO        VARCHAR(50) = ''
		 ,@C_M_CARTERA_FINANCIERA    VARCHAR(50) = ''
		 ,@C_M_SUB_CARTERA_NORMATIVA VARCHAR(50) = ''
		 ,@C_M_LIBRO_NEGOCIACION     VARCHAR(50) = ''
		 ,@C_M_TIPO_SWAP             VARCHAR(50) = ''
		 ,@C_M_OPERADOR              VARCHAR(30) = ''
		 ,@C_M_VALOR_RAZONABLE       VARCHAR(30) = ''


/*-----------------------------------------------------------------------------*/
/* DECLARACION DE VARIABLES                                                    */
/*-----------------------------------------------------------------------------*/
  DECLARE @V_V_RUT_CLIENTE           VARCHAR(15) = ''
         ,@V_V_NOMBRE                VARCHAR(50) = ''
		 ,@V_V_MONEDA                VARCHAR(05) = ''
		 ,@V_V_NOCIONALES            VARCHAR(30) = ''
		 ,@V_V_FRECUENCIA_PAGO       VARCHAR(30) = ''
		 ,@V_V_FRECUENCIA_CAPITAL    VARCHAR(30) = ''
		 ,@V_V_INDICADOR             VARCHAR(20) = ''
		 ,@V_V_TASA                  VARCHAR(20) = ''
		 ,@V_V_SPREAD                VARCHAR(20) = ''
		 ,@V_V_FECHA_EFECTIVA        VARCHAR(10) = ''
		 ,@V_V_FECHA_MADUREZ         VARCHAR(10) = ''
		 ,@V_V_MONEDA_PAGO           VARCHAR(05) = ''
		 ,@V_V_CARTERA_NORMATIVA     VARCHAR(30) = ''
		 ,@V_V_CONTEO_DIAS           VARCHAR(15) = ''
		 ,@V_V_MEDIO_PAGO            VARCHAR(50) = ''
		 ,@V_V_MODALIDAD_PAGO        VARCHAR(50) = ''
		 ,@V_V_CARTERA_FINANCIERA    VARCHAR(50) = ''
		 ,@V_V_SUB_CARTERA_NORMATIVA VARCHAR(50) = ''
		 ,@V_V_LIBRO_NEGOCIACION     VARCHAR(50) = ''
		 ,@V_V_TIPO_SWAP             VARCHAR(50) = ''
		 ,@V_V_OPERADOR              VARCHAR(30) = ''
		 ,@V_V_VALOR_RAZONABLE       VARCHAR(30) = ''
		 

/*-----------------------------------------------------------------------------*/
/* DECLARACION DE VARIABLES                                                    */
/*-----------------------------------------------------------------------------*/
  DECLARE @V_M_RUT_CLIENTE           VARCHAR(15) = ''
         ,@V_M_NOMBRE                VARCHAR(50) = ''
		 ,@V_M_MONEDA                VARCHAR(05) = ''
		 ,@V_M_NOCIONALES            VARCHAR(30) = ''
		 ,@V_M_FRECUENCIA_PAGO       VARCHAR(30) = ''
		 ,@V_M_FRECUENCIA_CAPITAL    VARCHAR(30) = ''
		 ,@V_M_INDICADOR             VARCHAR(20) = ''
		 ,@V_M_TASA                  VARCHAR(20) = ''
		 ,@V_M_SPREAD                VARCHAR(20) = ''
		 ,@V_M_FECHA_EFECTIVA        VARCHAR(10) = ''
		 ,@V_M_FECHA_MADUREZ         VARCHAR(10) = ''
		 ,@V_M_MONEDA_PAGO           VARCHAR(05) = ''
		 ,@V_M_CARTERA_NORMATIVA     VARCHAR(30) = ''
		 ,@V_M_CONTEO_DIAS           VARCHAR(15) = ''
		 ,@V_M_MEDIO_PAGO            VARCHAR(50) = ''
		 ,@V_M_MODALIDAD_PAGO        VARCHAR(50) = ''
		 ,@V_M_CARTERA_FINANCIERA    VARCHAR(50) = ''
		 ,@V_M_SUB_CARTERA_NORMATIVA VARCHAR(50) = ''
		 ,@V_M_LIBRO_NEGOCIACION     VARCHAR(50) = ''
		 ,@V_M_TIPO_SWAP             VARCHAR(50) = ''
		 ,@V_M_OPERADOR              VARCHAR(30) = ''
		 ,@V_M_VALOR_RAZONABLE       VARCHAR(30) = ''
		 

/*-----------------------------------------------------------------------------*/
/* DATOS DE COMPRA CARTERA MOVIMIENTOS                                         */
/*-----------------------------------------------------------------------------*/
  SELECT TOP(01)
         @C_V_RUT_CLIENTE           = ISNULL(CAR.RUT_CLIENTE,'')
        ,@C_V_NOMBRE                = ISNULL(CLI.Clnombre,'')
	    ,@C_V_MONEDA                = ISNULL(MON.mnnemo,'')
	    ,@C_V_NOCIONALES            = ISNULL(CAR.COMPRA_CAPITAL,'')
	    ,@C_V_FRECUENCIA_PAGO       = ISNULL(FRE.glosa,'') 
	    ,@C_V_FRECUENCIA_CAPITAL    = ISNULL(CAP.GLOSA,'')
		,@C_V_INDICADOR             = ISNULL(IND.TBGLOSA,'')
		,@C_V_TASA                  = ISNULL(CAR.compra_valor_tasa,'')
		,@C_V_SPREAD                = ISNULL(CAR.compra_spread,'')
		,@C_V_FECHA_EFECTIVA        = ISNULL(CONVERT(CHAR(10),CAR.fecha_inicio,121) ,'1900-01-01')
		,@C_V_FECHA_MADUREZ         = ISNULL(CONVERT(CHAR(10),CAR.fecha_termino,121),'1900-01-01')
		,@C_V_MONEDA_PAGO           = ISNULL(MOP.MNNEMO,'')
		,@C_V_CARTERA_NORMATIVA     = ISNULL(CAN.TBGLOSA,'')
		,@C_V_CONTEO_DIAS           = ISNULL(BAS.GLOSA,'')
		,@C_V_MEDIO_PAGO            = ISNULL(MED.GLOSA,'')
		,@C_V_MODALIDAD_PAGO        = ISNULL(CASE WHEN CAR.modalidad_pago = 'C' THEN 'COMPENSACION' 
		                                     ELSE 'E. FISICA'
	                                         END,'') 
		,@C_V_CARTERA_FINANCIERA    = ISNULL(FIN.TBGLOSA,'')
		,@C_V_SUB_CARTERA_NORMATIVA = ISNULL(SUB.TBGLOSA,'')
		,@C_V_LIBRO_NEGOCIACION     = ISNULL(LIB.TBGLOSA,'')
		,@C_V_TIPO_SWAP             = ISNULL(CASE WHEN CAR.tipo_swap = 1 THEN 'SWAP DE TASAS'   
                                             WHEN CAR.tipo_swap = 2 THEN 'SWAP DE MONEDAS'  
                                             WHEN CAR.tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA'  
                                             END ,'') 
		,@C_V_OPERADOR              = ISNULL(CAR.operador,'')
		,@C_V_VALOR_RAZONABLE       = ISNULL(CAR.Valor_RazonableCLP,'')
    FROM BacSwapSuda.DBO.Cartera                CAR 
   INNER JOIN
         BacParamSuda.DBO.CLIENTE               CLI WITH(NOLOCK)
	  ON CLI.CLRUT     = CAR.RUT_CLIENTE
	 AND CLI.Clcodigo  = CAR.codigo_cliente 
   INNER JOIN
         BacParamSuda.DBO.MONEDA                MON WITH(NOLOCK)
	  ON MON.mncodmon  = CAR.compra_moneda 
   INNER JOIN
         BacParamSuda.dbo.PERIODO_AMORTIZACION  FRE WITH(NOLOCK)
	  ON FRE.sistema   = 'PCS'
	 AND FRE.TABLA     = 1044
	 AND FRE.codigo    = CAR.compra_codamo_interes
   INNER JOIN
         BacParamSuda.dbo.PERIODO_AMORTIZACION  CAP WITH(NOLOCK)
	  ON CAP.sistema   = 'PCS'
	 AND CAP.TABLA     = 1043
	 AND CAP.CODIGO    IN(5,6)
	 AND CAP.codigo    = CAR.compra_codamo_capital
   INNER JOIN
         BacparamSuda.dbo.MONEDA                MOP WITH(NOLOCK)
	  ON MOP.mncodmon  =  CAR.recibimos_moneda
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE CAN WITH(NOLOCK)
	  ON CAN.TBCATEG   = 1111
	 AND CAN.TBCODIGO1 = CAR.car_cartera_normativa
   INNER JOIN
         BacSwapSuda.DBO.BASE                   BAS WITH(NOLOCK)
	  ON BAS.CODIGO    = CAR.compra_base
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE FIN WITH(NOLOCK)
	  ON FIN.TBCATEG   = 204
	 AND FIN.TBCODIGO1 = CAR.cartera_inversion
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE SUB WITH(NOLOCK)
	  ON SUB.TBCATEG   = 1554
	 AND SUB.TBCODIGO1 = CAR.car_subcartera_normativa
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE LIB WITH(NOLOCK)
	  ON LIB.TBCATEG   = 1552
	 AND LIB.TBCODIGO1 = CAR.car_libro
   INNER JOIN
         BacparamSuda.dbo.FORMA_DE_PAGO         MED WITH(NOLOCK)
	  ON MED.codigo    = CAR.recibimos_documento
   INNER JOIN
         BacparamSuda.dbo.TABLA_GENERAL_DETALLE IND WITH(NOLOCK)
	  ON IND.tbcateg   = 1042
	 AND IND.tbcodigo1 = CAR.compra_codigo_tasa
   WHERE CAR.NUMERO_OPERACION = @NUMERO_OPERACION
     AND CAR.tipo_flujo       = 1
	 AND CAR.estado_flujo     = 1


/*-----------------------------------------------------------------------------*/
/* DATOS DE COMPRA CARTERA MODIFICADA                                          */
/*-----------------------------------------------------------------------------*/
SELECT TOP(01)
         @C_M_RUT_CLIENTE           = ISNULL(CAR.RUT_CLIENTE,'')
        ,@C_M_NOMBRE                = ISNULL(CLI.Clnombre,'')
	    ,@C_M_MONEDA                = ISNULL(MON.mnnemo,'')
	    ,@C_M_NOCIONALES            = ISNULL(CAR.COMPRA_CAPITAL,'')
	    ,@C_M_FRECUENCIA_PAGO       = ISNULL(FRE.glosa,'') 
	    ,@C_M_FRECUENCIA_CAPITAL    = ISNULL(CAP.GLOSA,'')
		,@C_M_INDICADOR             = ISNULL(IND.TBGLOSA,'')
		,@C_M_TASA                  = ISNULL(CAR.compra_valor_tasa,'')
		,@C_M_SPREAD                = ISNULL(CAR.compra_spread,'')
		,@C_M_FECHA_EFECTIVA        = ISNULL(CONVERT(CHAR(10),CAR.fecha_inicio,121) ,'1900-01-01')
		,@C_M_FECHA_MADUREZ         = ISNULL(CONVERT(CHAR(10),CAR.fecha_termino,121),'1900-01-01')
		,@C_M_MONEDA_PAGO           = ISNULL(MOP.MNNEMO,'')
		,@C_M_CARTERA_NORMATIVA     = ISNULL(CAN.TBGLOSA,'')
		,@C_M_CONTEO_DIAS           = ISNULL(BAS.GLOSA,'')
		,@C_M_MEDIO_PAGO            = ISNULL(MED.GLOSA,'')
		,@C_M_MODALIDAD_PAGO        = ISNULL(CASE WHEN CAR.modalidad_pago = 'C' THEN 'COMPENSACION' 
		                                     ELSE 'E. FISICA'
	                                         END,'') 
		,@C_M_CARTERA_FINANCIERA    = ISNULL(FIN.TBGLOSA,'')
		,@C_M_SUB_CARTERA_NORMATIVA = ISNULL(SUB.TBGLOSA,'')
		,@C_M_LIBRO_NEGOCIACION     = ISNULL(LIB.TBGLOSA,'')
		,@C_M_TIPO_SWAP             = ISNULL(CASE WHEN CAR.tipo_swap = 1 THEN 'SWAP DE TASAS'   
                                             WHEN CAR.tipo_swap = 2 THEN 'SWAP DE MONEDAS'  
                                             WHEN CAR.tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA'  
                                             END ,'') 
		,@C_M_OPERADOR              = ISNULL(CAR.operador,'')
		,@C_M_VALOR_RAZONABLE       = ISNULL(CAR.Valor_RazonableCLP,'')
    FROM BacSwapSuda.DBO.CarteraModificada      CAR 
   INNER JOIN
         BacParamSuda.DBO.CLIENTE               CLI WITH(NOLOCK)
	  ON CLI.CLRUT     = CAR.RUT_CLIENTE
	 AND CLI.Clcodigo  = CAR.codigo_cliente 
   INNER JOIN
         BacParamSuda.DBO.MONEDA                MON WITH(NOLOCK)
	  ON MON.mncodmon  = CAR.compra_moneda 
   INNER JOIN
         BacParamSuda.dbo.PERIODO_AMORTIZACION  FRE WITH(NOLOCK)
	  ON FRE.sistema   = 'PCS'
	 AND FRE.TABLA     = 1044
	 AND FRE.codigo    = CAR.compra_codamo_interes
   INNER JOIN
         BacParamSuda.dbo.PERIODO_AMORTIZACION  CAP WITH(NOLOCK)
	  ON CAP.sistema   = 'PCS'
	 AND CAP.TABLA     = 1043
	 AND CAP.CODIGO    IN(5,6)
	 AND CAP.codigo    = CAR.compra_codamo_capital
   INNER JOIN
         BacparamSuda.dbo.MONEDA                MOP WITH(NOLOCK)
	  ON MOP.mncodmon  =  CAR.recibimos_moneda
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE CAN WITH(NOLOCK)
	  ON CAN.TBCATEG   = 1111
	 AND CAN.TBCODIGO1 = CAR.car_cartera_normativa
   INNER JOIN
         BacSwapSuda.DBO.BASE                   BAS WITH(NOLOCK)
	  ON BAS.CODIGO    = CAR.compra_base
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE FIN WITH(NOLOCK)
	  ON FIN.TBCATEG   = 204
	 AND FIN.TBCODIGO1 = CAR.cartera_inversion
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE SUB WITH(NOLOCK)
	  ON SUB.TBCATEG   = 1554
	 AND SUB.TBCODIGO1 = CAR.car_subcartera_normativa
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE LIB WITH(NOLOCK)
	  ON LIB.TBCATEG   = 1552
	 AND LIB.TBCODIGO1 = CAR.car_libro
   INNER JOIN
         BacparamSuda.dbo.FORMA_DE_PAGO         MED WITH(NOLOCK)
	  ON MED.codigo    = CAR.recibimos_documento
   INNER JOIN
         BacparamSuda.dbo.TABLA_GENERAL_DETALLE IND WITH(NOLOCK)
	  ON IND.tbcateg   = 1042
	 AND IND.tbcodigo1 = CAR.compra_codigo_tasa
   WHERE CAR.NUMERO_OPERACION = @NUMERO_OPERACION
     AND CAR.tipo_flujo       = 1
	 AND CAR.estado_flujo     = 1

/*-----------------------------------------------------------------------------*/
/* DATOS DE VENTA CARTERA MOVIMIENTOS                                          */
/*-----------------------------------------------------------------------------*/
  SELECT TOP(01)
         @V_V_RUT_CLIENTE           = ISNULL(CAR.RUT_CLIENTE,'')
        ,@V_V_NOMBRE                = ISNULL(CLI.Clnombre,'') 
	    ,@V_V_MONEDA                = ISNULL(MON.mnnemo,'')
	    ,@V_V_NOCIONALES            = ISNULL(CAR.VENTA_CAPITAL,'')
	    ,@V_V_FRECUENCIA_PAGO       = ISNULL(FRE.glosa,'') 
	    ,@V_V_FRECUENCIA_CAPITAL    = ISNULL(CAP.GLOSA,'') 
		,@V_V_INDICADOR             = ISNULL(IND.TBGLOSA,'')
		,@V_V_TASA                  = ISNULL(CAR.VENTA_valor_tasa,'')
		,@V_V_SPREAD                = ISNULL(CAR.VENTA_spread,'')
		,@V_V_FECHA_EFECTIVA        = ISNULL(CONVERT(CHAR(10),CAR.fecha_inicio,121),'1900-01-01')
		,@V_V_FECHA_MADUREZ         = ISNULL(CONVERT(CHAR(10),CAR.fecha_termino,121),'1900-01-01')
		,@V_V_MONEDA_PAGO           = ISNULL(MOP.MNNEMO,'')
		,@V_V_CARTERA_NORMATIVA     = ISNULL(CAN.TBGLOSA,'')
		,@V_V_CONTEO_DIAS           = ISNULL(BAS.GLOSA,'')
		,@V_V_MEDIO_PAGO            = ISNULL(MED.GLOSA,'')
		,@V_V_MODALIDAD_PAGO        = ISNULL(CASE WHEN CAR.modalidad_pago = 'C' THEN 'COMPENSACION' 
		                                     ELSE 'E. FISICA'
	                                         END ,'')
		,@V_V_CARTERA_FINANCIERA    = ISNULL(FIN.TBGLOSA,'')
		,@V_V_SUB_CARTERA_NORMATIVA = ISNULL(SUB.TBGLOSA,'')
		,@V_V_LIBRO_NEGOCIACION     = ISNULL(LIB.TBGLOSA,'')
		,@V_V_TIPO_SWAP             = ISNULL(CASE WHEN CAR.tipo_swap = 1 THEN 'SWAP DE TASAS'   
                                             WHEN CAR.tipo_swap = 2 THEN 'SWAP DE MONEDAS'  
                                             WHEN CAR.tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA'  
                                             END,'')  
		,@V_V_OPERADOR              = ISNULL(CAR.operador,'')
		,@V_V_VALOR_RAZONABLE       = ISNULL(CAR.Valor_RazonableCLP,'')
    FROM BacSwapSuda.DBO.Cartera                CAR 
   INNER JOIN
         BacParamSuda.DBO.CLIENTE               CLI WITH(NOLOCK)
	  ON CLI.CLRUT     = CAR.RUT_CLIENTE
	 AND CLI.Clcodigo  = CAR.codigo_cliente 
   INNER JOIN
         BacParamSuda.DBO.MONEDA                MON WITH(NOLOCK)
	  ON MON.mncodmon  = CAR.venta_moneda  
   INNER JOIN
         BacParamSuda.dbo.PERIODO_AMORTIZACION  FRE WITH(NOLOCK)
	  ON FRE.sistema   = 'PCS'
	 AND FRE.TABLA     = 1044
	 AND FRE.codigo    = CAR.venta_codamo_interes
   INNER JOIN
         BacParamSuda.dbo.PERIODO_AMORTIZACION  CAP WITH(NOLOCK)
	  ON CAP.sistema   = 'PCS'
	 AND CAP.TABLA     = 1043
	 AND CAP.CODIGO    IN(5,6)
	 AND CAP.codigo    = CAR.venta_codamo_capital
   INNER JOIN
         BacparamSuda.dbo.MONEDA                MOP WITH(NOLOCK)
	  ON MOP.mncodmon  =  CAR.pagamos_moneda 
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE CAN WITH(NOLOCK)
	  ON CAN.TBCATEG   = 1111
	 AND CAN.TBCODIGO1 = CAR.car_cartera_normativa
   INNER JOIN
         BacSwapSuda.DBO.BASE                   BAS WITH(NOLOCK)
	  ON BAS.CODIGO    = CAR.venta_base 
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE FIN WITH(NOLOCK)
	  ON FIN.TBCATEG   = 204
	 AND FIN.TBCODIGO1 = CAR.cartera_inversion
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE SUB WITH(NOLOCK)
	  ON SUB.TBCATEG   = 1554
	 AND SUB.TBCODIGO1 = CAR.car_subcartera_normativa
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE LIB WITH(NOLOCK)
	  ON LIB.TBCATEG   = 1552
	 AND LIB.TBCODIGO1 = CAR.car_libro
   INNER JOIN
         BacparamSuda.dbo.FORMA_DE_PAGO         MED WITH(NOLOCK)
	  ON MED.codigo    = CAR.pagamos_documento 
   INNER JOIN
         BacparamSuda.dbo.TABLA_GENERAL_DETALLE IND WITH(NOLOCK)
	  ON IND.tbcateg   = 1042
	 AND IND.tbcodigo1 = CAR.venta_codigo_tasa 
   WHERE CAR.NUMERO_OPERACION = @NUMERO_OPERACION
     AND CAR.tipo_flujo       = 2
	 AND CAR.estado_flujo     = 1



/*-----------------------------------------------------------------------------*/
/* DATOS DE VENTA CARTERA MOVIMIENTOS                                          */
/*-----------------------------------------------------------------------------*/
  SELECT TOP(01)
         @V_M_RUT_CLIENTE           = ISNULL(CAR.RUT_CLIENTE,'')
        ,@V_M_NOMBRE                = ISNULL(CLI.Clnombre,'') 
	    ,@V_M_MONEDA                = ISNULL(MON.mnnemo,'')
	    ,@V_M_NOCIONALES            = ISNULL(CAR.VENTA_CAPITAL,'')
	    ,@V_M_FRECUENCIA_PAGO       = ISNULL(FRE.glosa,'') 
	    ,@V_M_FRECUENCIA_CAPITAL    = ISNULL(CAP.GLOSA,'') 
		,@V_M_INDICADOR             = ISNULL(IND.TBGLOSA,'')
		,@V_M_TASA                  = ISNULL(CAR.VENTA_valor_tasa,'')
		,@V_M_SPREAD                = ISNULL(CAR.VENTA_spread,'')
		,@V_M_FECHA_EFECTIVA        = ISNULL(CONVERT(CHAR(10),CAR.fecha_inicio,121),'1900-01-01')
		,@V_M_FECHA_MADUREZ         = ISNULL(CONVERT(CHAR(10),CAR.fecha_termino,121),'1900-01-01')
		,@V_M_MONEDA_PAGO           = ISNULL(MOP.MNNEMO,'')
		,@V_M_CARTERA_NORMATIVA     = ISNULL(CAN.TBGLOSA,'')
		,@V_M_CONTEO_DIAS           = ISNULL(BAS.GLOSA,'')
		,@V_M_MEDIO_PAGO            = ISNULL(MED.GLOSA,'')
		,@V_M_MODALIDAD_PAGO        = ISNULL(CASE WHEN CAR.modalidad_pago = 'C' THEN 'COMPENSACION' 
		                                     ELSE 'E. FISICA'
	                                         END ,'')
		,@V_M_CARTERA_FINANCIERA    = ISNULL(FIN.TBGLOSA,'')
		,@V_M_SUB_CARTERA_NORMATIVA = ISNULL(SUB.TBGLOSA,'')
		,@V_M_LIBRO_NEGOCIACION     = ISNULL(LIB.TBGLOSA,'')
		,@V_M_TIPO_SWAP             = ISNULL(CASE WHEN CAR.tipo_swap = 1 THEN 'SWAP DE TASAS'   
                                             WHEN CAR.tipo_swap = 2 THEN 'SWAP DE MONEDAS'  
                                             WHEN CAR.tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA'  
                                             END,'')  
		,@V_M_OPERADOR              = ISNULL(CAR.operador,'')
		,@V_M_VALOR_RAZONABLE       = ISNULL(CAR.Valor_RazonableCLP,'')
    FROM BacSwapSuda.DBO.CarteraModificada     CAR 
   INNER JOIN
         BacParamSuda.DBO.CLIENTE               CLI WITH(NOLOCK)
	  ON CLI.CLRUT     = CAR.RUT_CLIENTE
	 AND CLI.Clcodigo  = CAR.codigo_cliente 
   INNER JOIN
         BacParamSuda.DBO.MONEDA                MON WITH(NOLOCK)
	  ON MON.mncodmon  = CAR.venta_moneda  
   INNER JOIN
         BacParamSuda.dbo.PERIODO_AMORTIZACION  FRE WITH(NOLOCK)
	  ON FRE.sistema   = 'PCS'
	 AND FRE.TABLA     = 1044
	 AND FRE.codigo    = CAR.venta_codamo_interes
   INNER JOIN
         BacParamSuda.dbo.PERIODO_AMORTIZACION  CAP WITH(NOLOCK)
	  ON CAP.sistema   = 'PCS'
	 AND CAP.TABLA     = 1043
	 AND CAP.CODIGO    IN(5,6)
	 AND CAP.codigo    = CAR.venta_codamo_capital
   INNER JOIN
         BacparamSuda.dbo.MONEDA                MOP WITH(NOLOCK)
	  ON MOP.mncodmon  =  CAR.pagamos_moneda 
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE CAN WITH(NOLOCK)
	  ON CAN.TBCATEG   = 1111
	 AND CAN.TBCODIGO1 = CAR.car_cartera_normativa
   INNER JOIN
         BacSwapSuda.DBO.BASE                   BAS WITH(NOLOCK)
	  ON BAS.CODIGO    = CAR.venta_base 
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE FIN WITH(NOLOCK)
	  ON FIN.TBCATEG   = 204
	 AND FIN.TBCODIGO1 = CAR.cartera_inversion
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE SUB WITH(NOLOCK)
	  ON SUB.TBCATEG   = 1554
	 AND SUB.TBCODIGO1 = CAR.car_subcartera_normativa
   INNER JOIN
         BacParamSuda.DBO.TABLA_GENERAL_DETALLE LIB WITH(NOLOCK)
	  ON LIB.TBCATEG   = 1552
	 AND LIB.TBCODIGO1 = CAR.car_libro
   INNER JOIN
         BacparamSuda.dbo.FORMA_DE_PAGO         MED WITH(NOLOCK)
	  ON MED.codigo    = CAR.pagamos_documento 
   INNER JOIN
         BacparamSuda.dbo.TABLA_GENERAL_DETALLE IND WITH(NOLOCK)
	  ON IND.tbcateg   = 1042
	 AND IND.tbcodigo1 = CAR.venta_codigo_tasa 
   WHERE CAR.NUMERO_OPERACION = @NUMERO_OPERACION
     AND CAR.tipo_flujo       = 2
	 AND CAR.estado_flujo     = 1



  DECLARE @DatosOriginales	VARCHAR(155)
	    , @DatosNuevos		VARCHAR(155)


/*-----------------------------------------------------------------------------*/
/* RUT                                                                         */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_RUT_CLIENTE)) + '/' + LTRIM(RTRIM(@V_M_RUT_CLIENTE))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_RUT_CLIENTE)) + '/' + LTRIM(RTRIM(@V_V_RUT_CLIENTE))

   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'RUT'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 1
	

/*-----------------------------------------------------------------------------*/
/* NOMBRE                                                                      */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_NOMBRE)) + '/' + LTRIM(RTRIM(@V_M_NOMBRE))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_NOMBRE)) + '/' + LTRIM(RTRIM(@V_V_NOMBRE))

   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'NOMBRE'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 2


/*-----------------------------------------------------------------------------*/
/* MONEDAS                                                                     */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_MONEDA)) + '/' + LTRIM(RTRIM(@V_M_MONEDA))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_MONEDA)) + '/' + LTRIM(RTRIM(@V_V_MONEDA))

   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'MONEDAS'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 3

/*-----------------------------------------------------------------------------*/
/* NOCIONALES                                                                  */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_NOCIONALES)) + '/' + LTRIM(RTRIM(@V_M_NOCIONALES))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_NOCIONALES)) + '/' + LTRIM(RTRIM(@V_V_NOCIONALES))

   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'NOCIONALES'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 4

/*-----------------------------------------------------------------------------*/
/* FRECUENCIA DE PAGOS                                                         */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_FRECUENCIA_PAGO)) + '/' + LTRIM(RTRIM(@V_M_FRECUENCIA_PAGO))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_FRECUENCIA_PAGO)) + '/' + LTRIM(RTRIM(@V_V_FRECUENCIA_PAGO))

   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'FRECUENCIA PAGO'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 5


/*-----------------------------------------------------------------------------*/
/* FRECUENCIA CAPITAL                                                          */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_FRECUENCIA_CAPITAL)) + '/' + LTRIM(RTRIM(@V_M_FRECUENCIA_CAPITAL))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_FRECUENCIA_CAPITAL)) + '/' + LTRIM(RTRIM(@V_V_FRECUENCIA_CAPITAL))

   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'FRECUENCIA CAPITAL'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 6

/*-----------------------------------------------------------------------------*/
/* INDICADOR                                                                   */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_INDICADOR)) + '/' + LTRIM(RTRIM(@V_M_INDICADOR))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_INDICADOR)) + '/' + LTRIM(RTRIM(@V_V_INDICADOR))

   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'INDICADOR'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 7


/*-----------------------------------------------------------------------------*/
/* TASA                                                                        */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_TASA)) + '/' + LTRIM(RTRIM(@V_M_TASA))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_TASA)) + '/' + LTRIM(RTRIM(@V_V_TASA))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'TASA'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 8

/*-----------------------------------------------------------------------------*/
/* SPREAD                                                                      */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_SPREAD)) + '/' + LTRIM(RTRIM(@V_M_SPREAD))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_SPREAD)) + '/' + LTRIM(RTRIM(@V_V_SPREAD))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'SPREAD'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 9

/*-----------------------------------------------------------------------------*/
/* FECHA EFECTIVA                                                              */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_FECHA_EFECTIVA)) + '/' + LTRIM(RTRIM(@V_M_FECHA_EFECTIVA))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_FECHA_EFECTIVA)) + '/' + LTRIM(RTRIM(@V_V_FECHA_EFECTIVA))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'FECHA EFECTIVA'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 10

/*-----------------------------------------------------------------------------*/
/* FECHA MADUREZ                                                               */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_FECHA_MADUREZ)) + '/' + LTRIM(RTRIM(@V_M_FECHA_MADUREZ))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_FECHA_MADUREZ)) + '/' + LTRIM(RTRIM(@V_V_FECHA_MADUREZ))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'FECHA MADUREZ'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 11

/*-----------------------------------------------------------------------------*/
/* MONEDA DE PAGOS                                                             */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_MONEDA_PAGO)) + '/' + LTRIM(RTRIM(@V_M_MONEDA_PAGO))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_MONEDA_PAGO)) + '/' + LTRIM(RTRIM(@V_V_MONEDA_PAGO))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'MONEDA DE PAGOS'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 12


/*-----------------------------------------------------------------------------*/
/* CARTERA NORMATIVA                                                           */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_CARTERA_NORMATIVA)) + '/' + LTRIM(RTRIM(@V_M_CARTERA_NORMATIVA))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_CARTERA_NORMATIVA)) + '/' + LTRIM(RTRIM(@V_V_CARTERA_NORMATIVA))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'CARTERA NORMATIVA'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 13

/*-----------------------------------------------------------------------------*/
/* CONTEO DE DIAS                                                              */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_CONTEO_DIAS)) + '/' + LTRIM(RTRIM(@V_M_CONTEO_DIAS))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_CONTEO_DIAS)) + '/' + LTRIM(RTRIM(@V_V_CONTEO_DIAS))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'CONTEO DE DIAS'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 14


/*-----------------------------------------------------------------------------*/
/* MEDIO DE PAGO                                                               */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_MEDIO_PAGO)) + '/' + LTRIM(RTRIM(@V_M_MEDIO_PAGO))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_MEDIO_PAGO)) + '/' + LTRIM(RTRIM(@V_V_MEDIO_PAGO))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'MEDIO DE PAGO'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 15


/*-----------------------------------------------------------------------------*/
/* MODALIDAD DE PAGO                                                           */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_MODALIDAD_PAGO)) + '/' + LTRIM(RTRIM(@V_M_MODALIDAD_PAGO))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_MODALIDAD_PAGO)) + '/' + LTRIM(RTRIM(@V_V_MODALIDAD_PAGO))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'MODALIDAD DE PAGO'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 16


/*-----------------------------------------------------------------------------*/
/* CARTERA FINANCIERA                                                          */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_CARTERA_FINANCIERA)) + '/' + LTRIM(RTRIM(@V_M_CARTERA_FINANCIERA))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_CARTERA_FINANCIERA)) + '/' + LTRIM(RTRIM(@V_V_CARTERA_FINANCIERA))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'CARTERA FINANCIERA'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 17


/*-----------------------------------------------------------------------------*/
/* SUB CARTERA NORMATIVA                                                       */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_SUB_CARTERA_NORMATIVA)) + '/' + LTRIM(RTRIM(@V_M_SUB_CARTERA_NORMATIVA))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_SUB_CARTERA_NORMATIVA)) + '/' + LTRIM(RTRIM(@V_V_SUB_CARTERA_NORMATIVA))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'SUB CARTERA NORMATIVA'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 18



/*-----------------------------------------------------------------------------*/
/* LIBRO NEGOCIACION                                                           */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_LIBRO_NEGOCIACION)) + '/' + LTRIM(RTRIM(@V_M_LIBRO_NEGOCIACION))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_LIBRO_NEGOCIACION)) + '/' + LTRIM(RTRIM(@V_V_LIBRO_NEGOCIACION))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'LIBRO NEGOCIACION'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 19



/*-----------------------------------------------------------------------------*/
/* TIPO DE SWAP                                                                */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_TIPO_SWAP)) + '/' + LTRIM(RTRIM(@V_M_TIPO_SWAP))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_TIPO_SWAP)) + '/' + LTRIM(RTRIM(@V_V_TIPO_SWAP))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'TIPO SWAP'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 20

/*-----------------------------------------------------------------------------*/
/* OPERADOR                                                                    */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_OPERADOR)) + '/' + LTRIM(RTRIM(@V_M_OPERADOR))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_OPERADOR)) + '/' + LTRIM(RTRIM(@V_V_OPERADOR))


   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'OPERADOR'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 21

/*-----------------------------------------------------------------------------*/
/* OPERADOR                                                                    */
/*-----------------------------------------------------------------------------*/
   SET @DatosOriginales = LTRIM(RTRIM(@C_M_VALOR_RAZONABLE)) + '/' + LTRIM(RTRIM(@V_M_VALOR_RAZONABLE))
   SET @DatosNuevos     = LTRIM(RTRIM(@C_V_VALOR_RAZONABLE)) + '/' + LTRIM(RTRIM(@V_V_VALOR_RAZONABLE))
   

   EXEC BacLineas.DBO.SP_GRABA_REGISTRO_MODIFICAIONES @FechaModificacion	
	                                                 ,'PCS'
	                                                 , @NUMERO_OPERACION 
	                                                 , @NUMERO_OPERACION 
	                                                 , 1
									                 ,'VALOR RAZONABLE'
	                                                 , @DatosOriginales
	                                                 , @DatosNuevos
	                                                 , 22



END

GO
