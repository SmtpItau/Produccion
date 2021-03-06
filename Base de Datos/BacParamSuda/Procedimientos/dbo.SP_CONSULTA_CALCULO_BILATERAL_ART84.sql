USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_CALCULO_BILATERAL_ART84]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_CALCULO_BILATERAL_ART84]    
                        @RUT_CLIENTE        NUMERIC (10,0)
					 ,  @MTM                FLOAT
                     ,  @NocionalClpXFactor FLOAT
					 ,  @ValorBilateral     FLOAT OUTPUT

AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CALCULO DE BILATERAL                                        */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 26/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


     SET @ValorBilateral = 0

   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA TEMPORAL DE DERIVADOS                                     */
   /*-----------------------------------------------------------------------------*/
     DECLARE @ART84_DERIVADOS TABLE
	 (Fecha_Proc         datetime
	 ,NumOpe             numeric (10,0)
	 ,Modulo             char    (3) 
	 ,rut_cliente        numeric (9, 0)
	 ,codigo_cliente     numeric (9, 0)
	 ,Nocional           numeric (19, 4)
	 ,fecha_Cierre       datetime
	 ,fecha_inicio       datetime
	 ,Tir                numeric (19,4)
	 ,Moneda             numeric (5, 0)
	 ,Producto           char    (3)
	 ,AVR                numeric (19, 4)
	 ,Vigencia_Dias      numeric (10, 0)
	 ,Valor_Moneda       float 
	 ,Nocional_CLP       numeric (19, 4)
	 ,Factor             numeric (21, 4)
	 ,Sum_AVR_Positivo   float 
	 ,Max_Sum_AVR_Cero   float
	 ,Equiv_Credito      float
	 ,Monto_Matriz       float
	 ,Acu_Comp_Bilateral Varchar
     ,clrut_padre        NUMERIC(10,0)
     ,clcodigo_padre     INT
	 )



   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA QUE RESIDIRA LOS VALORES DE FORWARD Y SWAP                */
   /*-----------------------------------------------------------------------------*/
     DECLARE @DERIVADOS_SWAP_FWD TABLE
	 (NUMERO_OPERACION        NUMERIC(10,0)
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
	 ,MONTO_1                 FLOAT
	 ,VIGENCIA_DIAS           INT)


   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA ORWARD Y SWAP CALCULOS DE FACTORES Y VALORES              */
   /*-----------------------------------------------------------------------------*/
     DECLARE @DERIVADOS_SWAP_FWD_CALCULOS TABLE
	 (NUMERO_OPERACION        NUMERIC(10,0)
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
	 ,MONTO_1                 FLOAT
	 ,VIGENCIA_DIAS           INT
	 ,VALOR_MONEDA            FLOAT
	 ,NOCIONAL_CLP            FLOAT
	 ,FACTOR                  FLOAT)


   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA DE CALCULOS DE BILATERAL FINAL PARA FORMULA               */
   /*-----------------------------------------------------------------------------*/
     DECLARE @BILATERAL TABLE
	 (AVR          FLOAT
     ,Monto_Matriz FLOAT)








   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE  @fecproBFW           DATETIME
		  ,   @fecproBFWContable   DATETIME  
		  ,   @fecproSwap          DATETIME
		  ,   @SumatoriaValorRaz   Float
		  ,   @NocionalXFactor     float
		  ,   @monto               float
		  ,   @monto2              float

   /*-----------------------------------------------------------------------------*/
   /* FECHAS DE PROCESO SEGUN SISTEMA                                             */
   /*-----------------------------------------------------------------------------*/
	 SELECT @fecproBFW         = acfecproc FROM BacFwdSuda.dbo.MFAC  
	 SELECT @fecproBFWContable = acfecante FROM BacFwdSuda.dbo.MFAC  
	 SELECT @fecproSwap        = fechaproc FROM BacSwapSuda.dbo.SwapGeneral 


	 



   /*-----------------------------------------------------------------------------*/
   /* TABLA DE MONEDAS                                                            */
   /*-----------------------------------------------------------------------------*/
    DECLARE @TMP_VALOR_MONEDA_ART84_DERIVADOS TABLE
	(vmfecha    DATETIME
	,vmcodigo   INT
	,vmvalor    NUMERIC (18,8))



   /*-----------------------------------------------------------------------------*/
   /* COMO LOS USUARIOS ENVIARAN LOS MONTOS A SIMULACION PARA LOS CASOS DE LAS    */
   /* PANTALLAS DE DERIVADOS EN LA MAYORIA DE LOS CASOS DEBERAN ENVIAR EL MONTO   */
   /* DEL MTM MAS NOCIONAL CLP MULTIPLICADO POR EL FACTOR                         */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @BILATERAL
	 SELECT @MTM
	       ,@NocionalClpXFactor



   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE CALCULO DE MONEDAS                                               */
   /*-----------------------------------------------------------------------------*/
	 INSERT INTO @TMP_VALOR_MONEDA_ART84_DERIVADOS
     SELECT * FROM BACPARAMSUDA.dbo.ValorMonedaFecContable(@fecproBFWContable)


   /*-----------------------------------------------------------------------------*/
   /* CARTERA FORWARD                                                             */
   /*-----------------------------------------------------------------------------*/
	 INSERT INTO @DERIVADOS_SWAP_FWD
	 SELECT NUMERO_OPERACION      
	       ,MODULO                
	       ,FECHA_PROCESO           
	       ,RUT_CLIENTE             
	       ,COD_CLIENTE             
	       ,NOCIONAL                
	       ,FECHA_CIERRE            
	       ,FECHA_INICIO            
	       ,TIR                     
	       ,COD_MONEDA              
	       ,COD_PRODUCTO            
	       ,MONTO_1                 
	       ,VIGENCIA_DIAS           
	   FROM BACPARAMSUDA.dbo.CarteraArticulo84Forward(@RUT_CLIENTE,@fecproBFW)


   /*-----------------------------------------------------------------------------*/
   /* CARTERA SWAP                                                                */
   /*-----------------------------------------------------------------------------*/
	 INSERT INTO @DERIVADOS_SWAP_FWD
	 SELECT NUMERO_OPERACION      
	       ,MODULO                
	       ,FECHA_PROCESO           
	       ,RUT_CLIENTE             
	       ,COD_CLIENTE             
	       ,NOCIONAL                
	       ,FECHA_CIERRE            
	       ,FECHA_INICIO            
	       ,TIR                     
	       ,COD_MONEDA              
	       ,COD_PRODUCTO            
	       ,MONTO_1                 
	       ,VIGENCIA_DIAS           
	   FROM BACPARAMSUDA.dbo.CarteraArticulo84Swap(@RUT_CLIENTE,@fecproSwap)



   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE CALCULOS SWAP                                                    */
   /*-----------------------------------------------------------------------------*/	 
     INSERT INTO @DERIVADOS_SWAP_FWD_CALCULOS
	 SELECT NUMERO_OPERACION                                AS NUMERO_OPERACION
	       ,MODULO                                          AS MODULO
	       ,FECHA_PROCESO                                   AS FECHA_PROCESO
	       ,RUT_CLIENTE                                     AS RUT_CLIENTE
	       ,COD_CLIENTE                                     AS COD_CLIENTE
	       ,NOCIONAL                                        AS NOCIONAL
	       ,FECHA_CIERRE                                    AS FECHA_CIERRE
	       ,FECHA_INICIO                                    AS FECHA_INICIO
	       ,TIR                                             AS TIR
	       ,COD_MONEDA                                      AS COD_MONEDA
	       ,COD_PRODUCTO                                    AS COD_PRODUCTO
	       ,MONTO_1                                         AS MONTO_1
	       ,VIGENCIA_DIAS                                   AS VIGENCIA_DIAS
		   ,Convert(float,MOC.vmvalor)                      AS VALOR_MONEDA
           ,Convert(float, Nocional * MOC.vmvalor )         AS NOCIONAL_CLP
           ,CASE 
		    WHEN DER.COD_PRODUCTO != 2 THEN Convert(float,(ISNULL(MAT.Factor1,0.0)))   
		    ELSE (CASE WHEN Acrp_CodigoGrupo = 1 THEN ISNULL(Factor1,0.0) ELSE ISNULL(Factor2,0.0) END)
			END                                             AS FACTOR
	   FROM @DERIVADOS_SWAP_FWD                                 DER
      INNER JOIN 
	        @TMP_VALOR_MONEDA_ART84_DERIVADOS                   MOC
	     ON MOC.vmcodigo                   = DER.COD_MONEDA
      INNER JOIN 
	        BACPARAMSUDA..MONEDA                                MON
	     ON MON.mncodmon                   = DER.COD_MONEDA
	  INNER JOIN 
	        BACPARAMSUDA..Producto                              PRO
	     ON PRO.id_sistema                 = DER.MODULO
		AND PRO.codigo_producto            = (CASE WHEN DER.COD_PRODUCTO = 1 THEN 'ST'     
                                                   WHEN DER.COD_PRODUCTO = 2 THEN 'SM'    
                                                   WHEN DER.COD_PRODUCTO = 3 THEN 'FR'    
                                                   WHEN DER.COD_PRODUCTO = 4 THEN 'SP'    
                                              END)    
	  INNER JOIN 
	        BACPARAMSUDA..TBL_AGRUPA_CLASIFICACION_RIESGO_PAIS  CLA
	     ON CLA.Acrp_CodigoClasificacion   =  MON.mnClasificaRiesgoPais  
      INNER JOIN 
	        BACPARAMSUDA..Riesgo_Normativo                      NOR
	     ON NOR.Codigo_Riesgo              =  PRO.Riesgo_Normativo  
      INNER JOIN 
	        BACPARAMSUDA..Matriz_Riesgo_Normativo               MAT
	     ON MAT.Codigo_Riesgo              =  NOR.Codigo_Riesgo 
        AND VIGENCIA_DIAS BETWEEN MAT.Plazo_Desde AND MAT.Plazo_Hasta    
      WHERE DER.MODULO                     ='PCS'


	     



   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE CALCULOS FORWARD                                                 */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @DERIVADOS_SWAP_FWD_CALCULOS
	 SELECT NUMERO_OPERACION                                AS NUMERO_OPERACION
	       ,MODULO                                          AS MODULO
	       ,FECHA_PROCESO                                   AS FECHA_PROCESO
	       ,RUT_CLIENTE                                     AS RUT_CLIENTE
	       ,COD_CLIENTE                                     AS COD_CLIENTE
	       ,NOCIONAL                                        AS NOCIONAL
	       ,FECHA_CIERRE                                    AS FECHA_CIERRE
	       ,FECHA_INICIO                                    AS FECHA_INICIO
	       ,TIR                                             AS TIR
	       ,COD_MONEDA                                      AS COD_MONEDA
	       ,COD_PRODUCTO                                    AS COD_PRODUCTO
	       ,MONTO_1                                         AS MONTO_1
	       ,VIGENCIA_DIAS                                   AS VIGENCIA_DIAS
		   ,Convert(float,MOC.vmvalor)                      AS VALOR_MONEDA
           ,Convert(float, Nocional * MOC.vmvalor )         AS NOCIONAL_CLP
           ,CASE 
		    WHEN DER.COD_PRODUCTO = 10 THEN ISNULL(Factor1,0.0)
			WHEN DER.COD_PRODUCTO = 11 THEN ISNULL(Factor1,0.0)
		    ELSE (CASE WHEN Acrp_CodigoGrupo = 1 THEN ISNULL(Factor1,0.0) ELSE ISNULL(Factor2,0.0) END)  
			END                                             AS FACTOR
	   FROM @DERIVADOS_SWAP_FWD                                 DER
      INNER JOIN 
	        @TMP_VALOR_MONEDA_ART84_DERIVADOS                   MOC
	     ON MOC.vmcodigo                   = DER.COD_MONEDA
      INNER JOIN 
	        BACPARAMSUDA..MONEDA                                MON
	     ON MON.mncodmon                   = DER.COD_MONEDA
	  INNER JOIN 
	        BACPARAMSUDA..Producto                              PRO
	     ON PRO.codigo_producto            = DER.COD_PRODUCTO
	    AND PRO.id_sistema                 = DER.MODULO
		AND PRO.codigo_producto            = DER.COD_PRODUCTO 
	  INNER JOIN 
	        BACPARAMSUDA..TBL_AGRUPA_CLASIFICACION_RIESGO_PAIS  CLA
	     ON CLA.Acrp_CodigoClasificacion   =  MON.mnClasificaRiesgoPais  
      INNER JOIN 
	        BACPARAMSUDA..Riesgo_Normativo                      NOR
	     ON NOR.Codigo_Riesgo              =  PRO.Riesgo_Normativo  
      INNER JOIN 
	        BACPARAMSUDA..Matriz_Riesgo_Normativo               MAT
	     ON MAT.Codigo_Riesgo              =  NOR.Codigo_Riesgo 
        AND VIGENCIA_DIAS BETWEEN MAT.Plazo_Desde AND MAT.Plazo_Hasta    
      WHERE DER.MODULO                     ='BFW'




   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE DERIVADOS A TABLA DE ARTICULO 84 CON CALCULOS                    */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @ART84_DERIVADOS
     SELECT DER.FECHA_PROCESO                       AS Fecha_Proc
	       ,DER.NUMERO_OPERACION                    AS NumOpe
		   ,DER.MODULO                              AS Modulo
           ,DER.RUT_CLIENTE                         AS rut_cliente
	       ,DER.COD_CLIENTE                         AS codigo_cliente
	       ,DER.NOCIONAL                            AS Nocional
	       ,DER.FECHA_CIERRE                        AS fecha_Cierre
	       ,DER.FECHA_INICIO                        AS fecha_inicio
	       ,DER.TIR                                 AS Tir
	       ,DER.COD_MONEDA                          AS Moneda
	       ,DER.COD_PRODUCTO                        AS Producto
		   ,ROUND(DER.MONTO_1,0)                    AS AVR
		   ,DER.VIGENCIA_DIAS 	                    AS Vigencia_Dias
           ,DER.VALOR_MONEDA                        AS Valor_Moneda
	       ,DER.NOCIONAL_CLP                        AS Nocional_CLP
	       ,DER.FACTOR                              AS Factor
           ,0.0                                     AS Sum_AVR_Positivo
           ,0.0                                     AS Max_Sum_AVR_Cero
           ,0.0                                     AS Equiv_Credito
           ,Round(NOCIONAL_CLP 
		   *(FACTOR/100.0), 0 )                     AS Monto_Matriz
           ,CLI.ClCompBilateral                     AS Acu_Comp_Bilateral
           ,ISNULL(clrut_padre,0)                   AS clrut_padre
           ,ISNULL(clcodigo_padre,0)                AS clcodigo_padre
	   FROM @DERIVADOS_SWAP_FWD_CALCULOS   DER
	  INNER JOIN
	        BACPARAMSUDA..Cliente          CLI
		 ON CLI.Clrut               = DER.RUT_CLIENTE 
       LEFT JOIN 
	        BACLINEAS..CLIENTE_RELACIONADO REL
	     ON DER.RUT_CLIENTE         = REL.clrut_hijo 
		AND DER.COD_CLIENTE         = REL.clcodigo_hijo   



		

   /*-----------------------------------------------------------------------------*/
   /* SE INCLUYEN OPCIONES EN LA TABLA DE DERIVADOS                               */
   /*-----------------------------------------------------------------------------*/
      INSERT INTO @ART84_DERIVADOS
      SELECT DISTINCT    
            OPT.FECHA_PROCESO                       AS Fecha_Proc
	       ,OPT.NUMERO_OPERACION                    AS NumOpe
		   ,'OPT'                                   AS Modulo
           ,OPT.RUT_CLIENTE                         AS rut_cliente
	       ,OPT.COD_CLIENTE                         AS codigo_cliente
	       ,OPT.NOCIONAL                            AS Nocional
	       ,OPT.FECHA_CIERRE                        AS fecha_Cierre
	       ,OPT.FECHA_INICIO                        AS fecha_inicio
	       ,0.0                                     AS TIR
	       ,OPT.MONEDA_NOCIONAL                     AS Moneda
	       ,'OPT'                                   AS Producto
		   ,ROUND(OPT.VALOR_RAZONABLE,0)            AS AVR
		   ,OPT.PLAZO 	                            AS Vigencia_Dias
           ,OPT.VALOR_MONEDA                        AS Valor_Moneda
	       ,OPT.NOCIONAL_CLP                        AS Nocional_CLP
	       ,OPT.FACTOR_ARTICULO_84                  AS Factor
	       ,Sum_AVR_Positivo                        AS Sum_AVR_Positivo
	       ,Max_Sum_AVR_Cero                        AS Max_Sum_AVR_Cero
	       ,Equiv_Credito                           AS Equiv_Credito
           ,Round(OPT.NOCIONAL_CLP 		    
		   *(OPT.FACTOR_ARTICULO_84/100.0), 0 )     AS Monto_Matriz
           ,CLI.ClCompBilateral                     AS Acu_Comp_Bilateral 
           ,ISNULL(clrut_padre,0)                   AS clrut_padre
           ,ISNULL(clcodigo_padre,0)                AS clcodigo_padre
       FROM BACPARAMSUDA.dbo.CarteraArticulo84Opciones(@RUT_CLIENTE) OPT
	  INNER JOIN
	        BACPARAMSUDA..Cliente         CLI
		 ON CLI.Clrut               = OPT.RUT_CLIENTE 
       LEFT JOIN 
	        BACLINEAS..CLIENTE_RELACIONADO REL
	     ON OPT.RUT_CLIENTE         = REL.clrut_hijo 
		AND OPT.COD_CLIENTE         = REL.clcodigo_hijo   



   /*-----------------------------------------------------------------------------*/
   /* LA TABLA TEMPORAL ARTICULO 84 ESTA CREADA SOLO COMO INFORMATIVA EN EL CASO  */
   /* DE REVISAR Y AGREGAR UN CALCULO YA QUE EN ESTA SOLO SIRVEN ALGUNOS CAMPOS   */
   /* PARA EL CALCULO ADEMAS SE AGREGARA LA SIMULACION PARA EL CALCULO            */                                                          
   /*-----------------------------------------------------------------------------*/
      INSERT INTO @BILATERAL
	  SELECT AVR
	        ,Monto_Matriz
        FROM @ART84_DERIVADOS
 



   /*-----------------------------------------------------------------------------*/
   /* SUMATORIA DE VALOR RAZONABLE                                                */
   /*-----------------------------------------------------------------------------*/
        SET @SumatoriaValorRaz = 0
     SELECT @SumatoriaValorRaz = SUM(AVR) FROM @BILATERAL

	     IF @SumatoriaValorRaz IS NULL BEGIN
		    SET @SumatoriaValorRaz = 0
		 END


   /*-----------------------------------------------------------------------------*/
   /* SUMATORIA DE VALOR NOCIONAL POR FACTOR                                      */
   /*-----------------------------------------------------------------------------*/
        SET @NocionalXFactor = 0
     SELECT @NocionalXFactor = SUM(Monto_Matriz) FROM @BILATERAL

	     IF @NocionalXFactor IS NULL BEGIN
		    SET @NocionalXFactor = 0
		 END



   /*-----------------------------------------------------------------------------*/
   /* SUMATORIA MONTO 2 Y MONTO 1                                                 */
   /*-----------------------------------------------------------------------------*/
        SET @monto   = 0
		SET @monto2  = 0
	 SELECT @monto   = CONVERT (FLOAT,SUM(CASE WHEN (AVR <= 0.0) THEN 0.0 ELSE AVR END))       
           ,@monto2  = CONVERT (FLOAT,(CASE WHEN (SUM(AVR)<=0.0) THEN 0.0 ELSE SUM(AVR) END))  
       FROM @BILATERAL

	     IF @monto IS NULL BEGIN
		    SET @monto = 0
		 END

	     IF @monto2 IS NULL BEGIN
		    SET @monto2 = 0
		 END


	 SET @ValorBilateral = 0
   /*-----------------------------------------------------------------------------*/
   /* SI LA SUMATORIA DEL MONTO AVR (VALOR RAZONABLE ES POSITIVO                  */
   /*-----------------------------------------------------------------------------*/
     IF @SumatoriaValorRaz > 0 BEGIN

	    SET @ValorBilateral = @SumatoriaValorRaz + @NocionalXFactor * (0.4 + 0.6 *(@monto2/@monto))

	 END



   /*-----------------------------------------------------------------------------*/
   /* SI LA SUMATORIA DEL MONTO AVR (VALOR RAZONABLE) ES NEGATIVO                 */
   /*-----------------------------------------------------------------------------*/
     IF @SumatoriaValorRaz > 0 BEGIN

	    SET @ValorBilateral = @NocionalXFactor  * 0.4 
	 END




 

  

END

GO
