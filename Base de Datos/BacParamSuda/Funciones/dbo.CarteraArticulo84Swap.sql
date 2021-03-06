USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[CarteraArticulo84Swap]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[CarteraArticulo84Swap](@RUT_CLIENTE NUMERIC (10,0)
                                             ,@fecproSwap  DATETIME)


  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns  @SWAP TABLE
	 (NUMERO_OPERACION        NUMERIC(10,0)
	 ,FLUJO                   INT
	 ,MODULO                  CHAR(04)
	 ,FECHA_PROCESO           DATETIME
	 ,RUT_CLIENTE             NUMERIC(10,0)
	 ,COD_CLIENTE             INT
	 ,NOCIONAL                FLOAT
	 ,FECHA_CIERRE            DATETIME
	 ,FECHA_INICIO            DATETIME
	 ,TIR                     FLOAT
	 ,COD_MONEDA              INT
	 ,COD_PRODUCTO            VARCHAR(10)
	 ,VIGENCIA_DIAS           INT
     ,MONTO_1                 FLOAT)

	  

 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA SWAP                                                */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 13/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* MONEDAS PRIMARIAS                                                           */
   /*-----------------------------------------------------------------------------*/
     DECLARE @MONEDAS_PRIMARIAS TABLE
	        (mncodmon    INT
			,mnPrioridad INT)


   /*-----------------------------------------------------------------------------*/
   /* MONEDAS PRIMARIAS                                                           */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @MONEDAS_PRIMARIAS
     SELECT mncodmon    
           ,mnPrioridad = isnull((Select MnPRioridad     
                                    From BacParamSuda..MonedaPrioridad Pri    
                                   Where Pri.MnCodMon = Mda.MnCodMon)    
                                 ,Case when mnCodMon = 999 then 0    
                                       when mnCodMon = 998 then 1    
                                       when mnCodMon = 13  then 2    
                                       Else 3 
									   End)    
       FROM BacParamSuda..MONEDA Mda where mnmx = 'C'     
      Union    
     SELECT mnCodMon    
           ,MnPrioridad = isnull((Select MnPrioridad     
                                    From BacParamSuda..MonedaPrioridad Pri    
                                   Where Pri.MnCodMon = Mda.MnCodMon)    
                                ,Case when Mda.MnCodMon = 999 then 0     
                                      when Mda.MnCodMon = 998 then 1    
                                      when Mda.MnCodMon = 13  then 2    
                                      Else 3 
							      End)    
       From BacParamSuda..Moneda Mda    
      WHERE MnCodMon in ( 999, 998 )    
  

 /*-----------------------------------------------------------------------------*/
   /* CARTERA SWAP                                                                */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @SWAP
     SELECT NUMERO_OPERACION
         ,  FLUJO  
         ,  MODULO  
         ,  FECHA_PROCESO
         ,  RUT_CLIENTE
         ,  CODIGO_CLIENTE   
         ,  CONVERT(FLOAT, case when MdaPas.MnPrioridad <= MdaAct.MnPrioridad     
                           THEN NOCIONAL 
						   ELSE NOCIONAL_PASIVO end )    
                        * (Case when PRODUCTO in ( 1 )     
                            and CODIGO_TASA_ACTIVO <> 0     
                            and CODIGO_TASA_PASIVO <> 0 then 0.0 else 1.0 
							End )   AS NOCIONAL
         ,  FECHA_CIERRE
		 ,  FECHA_INICIO
		 ,  CONVERT(FLOAT, 0.0)     AS TIR
		 ,  CONVERT(NUMERIC(05), case when MdaPas.MnPrioridad <= MdaAct.MnPrioridad    
                                      then MONEDA else MONEDA_PASIVO end )  AS COD_MONEDA
		 ,  PRODUCTO
		 ,  VIGENCIA_DIAS
		 ,  MONTO_1  
	   FROM
           ( SELECT NUMERO_OPERACION
		           ,FLUJO
		           ,MODULO
		           ,FECHA_PROCESO
		           ,RUT_CLIENTE
		           ,CODIGO_CLIENTE
		           ,SUM(NOCIONAL)        AS NOCIONAL
		           ,FECHA_CIERRE
		           ,FECHA_INICIO
		           ,MONEDA
		           ,PRODUCTO
				   ,MONTO_1
		           ,VIGENCIA_DIAS
				   ,CODIGO_TASA_ACTIVO
		           ,SUM(NOCIONAL_PASIVO) AS NOCIONAL_PASIVO
		           ,VIGENCIA_DIAS_PASIVO
				   ,MONEDA_PASIVO
				   ,CODIGO_TASA_PASIVO

               FROM
                   (SELECT DISTINCT    
                           CARTERA_ACTIVA.Numero_Operacion                                                    AS NUMERO_OPERACION
                          ,CARTERA_ACTIVA.numero_flujo                                                        AS FLUJO
                          ,'PCS'                                                                              AS MODULO
                          ,@fecproSwap                                                                        AS FECHA_PROCESO
                          ,CARTERA_ACTIVA.rut_cliente                                                         AS RUT_CLIENTE
                          ,CARTERA_ACTIVA.codigo_cliente                                                      AS CODIGO_CLIENTE
                          ,CONVERT(FLOAT, CARTERA_ACTIVA.compra_amortiza + CARTERA_ACTIVA.Compra_Flujo_Adicional ) AS NOCIONAL
                          ,CARTERA_ACTIVA.fecha_Cierre                                                        AS FECHA_CIERRE
                          ,CARTERA_ACTIVA.fecha_inicio                                                        AS FECHA_INICIO
                          ,CONVERT(NUMERIC(05) , CARTERA_ACTIVA.compra_moneda )                               AS MONEDA
                          ,CONVERT(NUMERIC(05) , CARTERA_ACTIVA.tipo_swap )                                   AS PRODUCTO
                          ,Isnull( DATEDIFF(DAY, @fecproSwap, CARTERA_ACTIVA.FechaLiquidacion ), '19000101' ) AS VIGENCIA_DIAS
						  ,isnull( CARTERA_ACTIVA.compra_codigo_tasa, 0 )                                     AS CODIGO_TASA_ACTIVO
                          ,Isnull( CARTERA_PASIVA.venta_amortiza + CARTERA_PASIVA.Venta_Flujo_Adicional , 0 ) AS NOCIONAL_PASIVO
                          ,DATEDIFF(DAY, @fecproSwap, CARTERA_PASIVA.FechaLiquidacion )                       AS VIGENCIA_DIAS_PASIVO
						  ,isnull( CARTERA_PASIVA.venta_moneda , 0 )                                          AS MONEDA_PASIVO
                          ,isnull( CARTERA_PASIVA.venta_codigo_tasa , 0 )                                     AS CODIGO_TASA_PASIVO
		                  ,Isnull(CONTRATOS.VALOR_RAZONABLE_CLP,0)                                            AS MONTO_1
                      FROM BacSwapSuda.dbo.CARTERA CARTERA_ACTIVA    
                      LEFT JOIN  BacSwapSuda.dbo.CARTERA CARTERA_PASIVA
		                ON CARTERA_ACTIVA.Numero_Operacion = CARTERA_PASIVA.Numero_Operacion    
                       AND CARTERA_ACTIVA.fechaliquidacion = CARTERA_PASIVA.fechaliquidacion    
	                  LEFT JOIN
	                      (SELECT DISTINCT 
	                              CAB.numero_operacion                 AS NUMERO_OPERACION
                                 ,CAB.Valor_RazonableCLP               AS VALOR_RAZONABLE_CLP
                             FROM BacSwapSuda..CARTERA                 CAB with(nolock)        
                            WHERE CAB.rut_cliente                     = @RUT_CLIENTE 
			                  AND CAB.Estado                         <> 'C'    
                              AND CAB.tipo_Flujo                      = 1) CONTRATOS
		                       ON CARTERA_ACTIVA.Numero_Operacion     = CONTRATOS.NUMERO_OPERACION
                            WHERE CARTERA_ACTIVA.Rut_Cliente          = @RUT_CLIENTE
	                          and CARTERA_ACTIVA.estado               <> 'C'       
                              AND CARTERA_ACTIVA.tipo_flujo           = 1       
                              AND CARTERA_PASIVA.tipo_flujo           = 2       
                              AND (     
                                  CARTERA_ACTIVA.compra_amortiza         > 0     
                               OR CARTERA_PASIVA.venta_amortiza          > 0     
                               OR CARTERA_ACTIVA.compra_flujo_adicional <> 0     
                               OR CARTERA_PASIVA.venta_flujo_adicional  <> 0     
                            ) 
			       ) SWAP    
           GROUP BY NUMERO_OPERACION
		           ,FLUJO
		           ,MODULO
		           ,FECHA_PROCESO
		           ,RUT_CLIENTE
		  		   ,CODIGO_CLIENTE
			       ,FECHA_CIERRE
				   ,FECHA_INICIO
				   ,MONEDA
				   ,PRODUCTO
				   ,VIGENCIA_DIAS
				   ,CODIGO_TASA_ACTIVO
				   ,VIGENCIA_DIAS_PASIVO
				   ,MONEDA_PASIVO
				   ,CODIGO_TASA_PASIVO
				   ,MONTO_1
		   ) SWAP
       LEFT JOIN @MONEDAS_PRIMARIAS MdaAct ON SWAP.MONEDA         = MdaAct.MnCodMon 
       LEFT JOIN @MONEDAS_PRIMARIAS MdaPas ON SWAP.MONEDA_PASIVO   = MdaPas.MnCodMon



 Return

 END


GO
