USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[CARTERA_SWAP_NY]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[CARTERA_SWAP_NY](@FECHA  DATETIME)


 
  
  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns @OPERACIONES TABLE
	 (OPERACION             NUMERIC
	 ,TIPO_FLUJO            INT
	 ,TIPO_SWAP             INT
	 ,RUT_CLIENTE           NUMERIC
	 ,RUT_DV                CHAR(01)
	 ,COD_CLIENTE           INT
	 ,FECHA_CIERRE          DATETIME
	 ,FECHA_INICIO          DATETIME
	 ,FECHA_TERMINO         DATETIME
	 ,FECHA_VENCIMIENTO     DATETIME
	 ,NOMINAL               NUMERIC(25,4)
	 ,MONEDA                INT
	 ,STR_MONEDA            CHAR(03)
	 ,VALOR_RAZONABLE_USD   NUMERIC
	 ,VALOR_RAZONABLE_CLP   NUMERIC
	 ,FRECUENCIA_PAGO       INT
	 ,INDICADOR             INT
	 ,MODALIDAD             CHAR(01)
	 ,MODALIDAD_PAGO        VARCHAR(60)
	 ,MTM_MOVIMIENTO        NUMERIC
	 ,FECHA_LIQUIDACION     DATETIME
	 ,MONEDA_PAGO           INT
	 ,CARTERA_NORMATIVA     CHAR(02)
	 ,CARTERA               VARCHAR(50)
	 ,NOMBRE_CLIENTE        VARCHAR(100)
	 ,OPERADOR              VARCHAR(50)
     ,PAIS                  INT
     ,AGENCIA               VARCHAR(50)
     ,COD_PAIS              VARCHAR(5)
     ,TASA                  FLOAT
	 ,SPREAD                FLOAT
	 ,CNPJ                  VARCHAR(20)
	 ,CLOPCION              VARCHAR(02)
	 ,MONEDA_PAGO_STR       VARCHAR(04))

	 




 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA SWAP                                                */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* CONTABILIDAD DE FORWARD                                                     */
   /*-----------------------------------------------------------------------------*/
     INSERT @OPERACIONES
	 SELECT CAR.numero_operacion 
	       ,CAR.tipo_flujo 
		   ,CAR.tipo_swap 
		   ,CAR.rut_cliente
		   ,0 
		   ,CAR.codigo_cliente 
		   ,CAR.fecha_cierre 
		   ,CAR.fecha_inicio
		   ,CAR.fecha_termino
		   ,CAR.fecha_vence_flujo
		   ,CASE 
		    WHEN CAR.tipo_flujo = 1 THEN CAR.compra_capital
		    WHEN CAR.tipo_flujo = 2 THEN CAR.venta_capital
			ELSE 0
			END
		   ,CASE 
		    WHEN CAR.tipo_flujo = 1 THEN CAR.compra_moneda
		    WHEN CAR.tipo_flujo = 2 THEN CAR.venta_moneda
			ELSE 0
			END                    AS CODIGO_MONEDA
		   ,''
		   ,CAR.Valor_Razonableusd 
		   ,CAR.Valor_RazonableCLP
		   ,CASE 
			WHEN TIPO_FLUJO = 1 THEN compra_codamo_interes
			WHEN TIPO_FLUJO = 2 THEN Venta_codamo_interes  
			ELSE 0
			END
		   ,CASE 
			WHEN TIPO_FLUJO = 1 THEN compra_codigo_tasa
			WHEN TIPO_FLUJO = 2 THEN venta_codigo_tasa
			ELSE 0
			END
           ,modalidad_pago
		   ,CASE 
			WHEN CAR.modalidad_pago = 'C' THEN 'Compensacion'
			WHEN CAR.modalidad_pago = 'E' THEN 'Entrega Fisica'
			ELSE ''
			END
		   ,CASE 
			WHEN TIPO_FLUJO = 1 THEN compra_mercado_clp
			WHEN TIPO_FLUJO = 2 THEN venta_mercado_clp
			ELSE 0
			END
		   ,FechaLiquidacion
		   ,CASE 
			WHEN TIPO_FLUJO = 1 THEN recibimos_moneda
			WHEN TIPO_FLUJO = 2 THEN pagamos_moneda
			ELSE 0
			END
		   ,CRE_CARTERA_NORMATIVA 
		   ,'CARTERA'
		   ,'NOMBRE CLIENTE'
		   ,OPERADOR
           ,0  AS PAIS
           ,'' AS AGENCIA
           ,'CPAIS'
		   ,CASE 
			WHEN TIPO_FLUJO = 1 THEN compra_valor_tasa 
			WHEN TIPO_FLUJO = 2 THEN venta_valor_tasa 
			ELSE 0
			END 
           ,CASE 
			WHEN TIPO_FLUJO = 1 THEN compra_spread 
			WHEN TIPO_FLUJO = 2 THEN venta_spread 
			ELSE 0
			END 
  	       ,'' AS CNPJ  
	       ,'' AS CLOPCION 
		   ,'' AS MONEDA_PAGO  		           
       FROM BacSwapNY.DBO.CARTERARES   CAR WITH(NOLOCK)
      WHERE CAR.Fecha_Proceso = @FECHA
        AND CAR.estado_flujo  = 1
        AND CAR.estado       != 'C'
      ORDER BY numero_operacion DESC


   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR CARTERA EN TABLA DE OPERACIONES                                  */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET CARTERA   = CAR.TBGLOSA 
	   FROM @OPERACIONES OPE
	  INNER JOIN
            bacparamsuda.dbo.TABLA_GENERAL_DETALLE CAR WITH(NOLOCK)
		 ON CAR.tbcateg   = 1111 
		AND CAR.tbcodigo1 = CARTERA_NORMATIVA 




   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR MONEDAS EN TABLAS DE OPERACIONES                                 */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET STR_MONEDA  = CASE WHEN MON.mnnemo ='UF' THEN 'CLF' ELSE MON.mnnemo END
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.DBO.MONEDA      MON WITH(NOLOCK)
		 ON MON.mncodmon         = OPE.MONEDA 


   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR MONEDAS EN TABLAS DE OPERACIONES                                 */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET MONEDA_PAGO_STR  = CASE WHEN MON.mnnemo ='UF' THEN 'CLF' ELSE MON.mnnemo END
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.DBO.MONEDA      MON WITH(NOLOCK)
		 ON MON.mncodmon         = OPE.MONEDA_PAGO 



   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR CLIENTES EN TABLA DE OPERACIONES                                 */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET RUT_DV          = CLI.CLDV
		   ,NOMBRE_CLIENTE  = CLNOMBRE  
		   ,CNPJ            = ISNULL(CLI.CNPJ, LTRIM(RTRIM(CLI.Clrut)) + '-' + LTRIM(RTRIM(CLI.CLDV)))
		   ,CLOPCION        = CASE 
			                  WHEN CLI.cltipcli = 8 THEN 'PF'
			                  WHEN CLI.cltipcli = 1 THEN 'IF'
			                  WHEN CLI.cltipcli = 2 THEN 'IF'
			                  WHEN CLI.cltipcli = 3 THEN 'IF'
			                  WHEN CLI.cltipcli = 4 THEN 'IF'
			                  WHEN CLI.cltipcli = 5 THEN 'IF'
			                  WHEN CLI.cltipcli = 6 THEN 'IF'
			                  WHEN CLI.cltipcli = 7 THEN 'PJ'
			                  WHEN CLI.cltipcli = 9 THEN 'PJ'
			                  WHEN CLI.cltipcli = 10 THEN 'PJ'
			                  WHEN CLI.cltipcli = 11 THEN 'PJ'
			                  WHEN CLI.cltipcli = 12 THEN 'PJ'
			                  WHEN CLI.cltipcli = 13 THEN 'PJ'
			                  ELSE  'PJ'
		                      END 		    
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.DBO.CLIENTE  CLI WITH(NOLOCK)
		 ON CLI.Clrut       = OPE.RUT_CLIENTE 
		AND CLI.ClCodigo    = OPE.COD_CLIENTE


   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR PAIS DE OPERACIONES                                              */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET PAIS  = CLI.CLPAIS 
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.DBO.CLIENTE      CLI WITH(NOLOCK)
		 ON CLI.Clrut          = OPE.RUT_CLIENTE 
		AND CLI.Clcodigo       = OPE.COD_CLIENTE 
  

   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR AGENCIA DE OPERADORES                                            */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET AGENCIA   = CAR.TBGLOSA
	   FROM @OPERACIONES OPE
	  INNER JOIN
            bacparamsuda.dbo.TABLA_GENERAL_DETALLE CAR WITH(NOLOCK)
		 ON CAR.tbcateg   = 9000 
		AND UPPER(LTRIM(RTRIM(CAR.tbglosa))) = UPPER(LTRIM(RTRIM(OPE.OPERADOR))) 


   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR CODIGO DE PAIS POR OPERACIONES                                   */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET COD_PAIS  = dbo.Fx_RetornaPaisItau(OPE.PAIS) 
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BACPARAMSUDA.DBO.PAIS      PAI WITH(NOLOCK)
		 ON PAI.codigo_pais    = OPE.PAIS


 Return



 END

GO
