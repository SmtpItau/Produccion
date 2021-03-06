USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_CALCULO_BILATERAL_ART84_SIM]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_CALCULO_BILATERAL_ART84_SIM]    
                     @RUT_CLIENTE   NUMERIC (10,0)
					,@MTM           FLOAT 
                    ,@NOCIONAL      FLOAT
	                ,@MONEDA        VARCHAR(05)
	                ,@MODULO        VARCHAR(05)
	                ,@COD_PRODUCTO  VARCHAR(05)
	                ,@PLAZO         INT



AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CALCULO DE BILATERAL CON SIMULACION                         */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 26/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/




   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE TABLA PARA VALORES DE DERIVADOS FORWARD Y SWAP               */
   /*-----------------------------------------------------------------------------*/
    DECLARE @TMP_DERIVADOS TABLE
	(NOCIONAL     FLOAT
	,COD_MONEDA   INT
	,MODULO       VARCHAR(05)
	,COD_PRODUCTO VARCHAR(05)
	,PLAZO        INT)




   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE  @fecproBFWContable       DATETIME  
		  ,   @NocionalClpXFactor      float
		  ,   @NOCIONAL_CLP            float
		  ,   @FACTOR_ART84            float
		  ,   @COD_MONEDA              INT
		  ,   @MENSAJE                 VARCHAR(200)
		  ,   @ValorBilateral_VIGENTE  FLOAT
		  ,   @ValorBilateral_ESPERADO FLOAT
		  ,   @AVR                     FLOAT 
		  ,   @ValorBilateral          FLOAT


   /*-----------------------------------------------------------------------------*/
   /* CALCULO DE CODIGO DE MONEDA                                                 */
   /*-----------------------------------------------------------------------------*/
     SET @COD_MONEDA =(SELECT mncodmon FROM MONEDA WITH(NOLOCK) WHERE mnnemo = @MONEDA)
      IF @COD_MONEDA = 0 OR @COD_MONEDA IS NULL BEGIN

	     SET @MENSAJE = 'CODIGO DE MONEDA: ' + @MONEDA + ' NO EXISTE PARA BILATERAL'

	     RAISERROR(@MENSAJE,16,1)

	  END


   /*-----------------------------------------------------------------------------*/
   /* INGRESO REGISTROS ENVIADO EN TABLA PARA HACER JOIN QUE CALCULE LOS MONTOS   */
   /* Y FACTORES                                                                  */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @TMP_DERIVADOS
	 SELECT @NOCIONAL
	       ,@COD_MONEDA 
	       ,@MODULO     
	       ,@COD_PRODUCTO
	       ,@PLAZO        



   /*-----------------------------------------------------------------------------*/
   /* FECHAS DE PROCESO SEGUN SISTEMA                                             */
   /*-----------------------------------------------------------------------------*/
	 SELECT @fecproBFWContable = acfecante FROM BacFwdSuda.dbo.MFAC  

   /*-----------------------------------------------------------------------------*/
   /* TABLA DE MONEDAS                                                            */
   /*-----------------------------------------------------------------------------*/
    DECLARE @TMP_VALOR_MONEDA_ART84_DERIVADOS TABLE
	(vmfecha    DATETIME
	,vmcodigo   INT
	,vmvalor    NUMERIC (18,8))

	 INSERT INTO @TMP_VALOR_MONEDA_ART84_DERIVADOS
     SELECT * FROM BACPARAMSUDA.dbo.ValorMonedaFecContable(@fecproBFWContable)


   /*-----------------------------------------------------------------------------*/
   /* FORWARD                                                                     */
   /*-----------------------------------------------------------------------------*/
	 IF @MODULO ='BFW' BEGIN


        SELECT @NOCIONAL_CLP = Convert(float, Nocional * MOC.vmvalor )         
              ,@FACTOR_ART84 = CASE 
		                       WHEN DER.COD_PRODUCTO = 10 THEN ISNULL(Factor1,0.0)
			                   WHEN DER.COD_PRODUCTO = 11 THEN ISNULL(Factor1,0.0)
		                       ELSE (CASE WHEN Acrp_CodigoGrupo = 1 THEN ISNULL(Factor1,0.0) ELSE ISNULL(Factor2,0.0) END)  
			                   END                                             
	      FROM @TMP_DERIVADOS                                      DER
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
           AND PLAZO BETWEEN MAT.Plazo_Desde AND MAT.Plazo_Hasta    


	 END


   /*-----------------------------------------------------------------------------*/
   /* FORWARD                                                                     */
   /*-----------------------------------------------------------------------------*/
	 IF @MODULO ='PCS' BEGIN


	    SELECT @NOCIONAL_CLP = Convert(float, Nocional * MOC.vmvalor )         
              ,@FACTOR_ART84 = CASE 
		                       WHEN DER.COD_PRODUCTO != 2 THEN Convert(float,(ISNULL(MAT.Factor1,0.0)))   
		                       ELSE (CASE WHEN Acrp_CodigoGrupo = 1 THEN ISNULL(Factor1,0.0) ELSE ISNULL(Factor2,0.0) END)
			                   END                                             
	      FROM @TMP_DERIVADOS                                     DER
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
           AND PLAZO BETWEEN MAT.Plazo_Desde AND MAT.Plazo_Hasta    



	 END


   /*-----------------------------------------------------------------------------*/
   /* OPCIONES                                                                    */
   /*-----------------------------------------------------------------------------*/
	 IF @MODULO ='OPT' BEGIN

		  	 
			 SELECT @FACTOR_ART84 = CASE
			                        WHEN PLAZO <= 365  THEN 0.015
			                        WHEN PLAZO <= 1825 THEN 0.07
			                        ELSE 0.13
								    END
			      , @NOCIONAL_CLP    = round(DER.Nocional * MON.vmvalor,0)      
	           FROM @TMP_DERIVADOS                    DER
	          INNER JOIN
		            @TMP_VALOR_MONEDA_ART84_DERIVADOS MON
	             ON MON.vmcodigo = DER.COD_MONEDA 	    

	


	 END

   /*-----------------------------------------------------------------------------*/
   /* CALCULO BILATERAL DERIVADOS VIGENTE                                         */
   /*-----------------------------------------------------------------------------*/
     SET @AVR                     = 0
	 SET @NocionalClpXFactor      = 0
	 SET @ValorBilateral_VIGENTE  = 0


   	 EXEC SP_CONSULTA_CALCULO_BILATERAL_ART84
                        @RUT_CLIENTE        
					 ,  @AVR                
                     ,  @NocionalClpXFactor 
					 ,  @ValorBilateral_VIGENTE    OUTPUT



   /*-----------------------------------------------------------------------------*/
   /* CALCULO BILATERAL MONTO ESPERADO                                            */
   /*-----------------------------------------------------------------------------*/
     SET @AVR                     = @MTM
	 SET @NocionalClpXFactor      = @NOCIONAL_CLP * @FACTOR_ART84
	 SET @ValorBilateral_ESPERADO = 0


   	 EXEC SP_CONSULTA_CALCULO_BILATERAL_ART84
                        @RUT_CLIENTE        
					 ,  @AVR                
                     ,  @NocionalClpXFactor 
					 ,  @ValorBilateral_ESPERADO   OUTPUT




   /*-----------------------------------------------------------------------------*/
   /* CALCULO DE BILATERAL                                                        */
   /*-----------------------------------------------------------------------------*/
     SET @ValorBilateral = @ValorBilateral_ESPERADO - @ValorBilateral_VIGENTE


     SELECT @ValorBilateral AS BILATERAL

END

GO
