USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_PASIVOS_PAGOS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_ADM_REPORTE_PASIVOS_PAGOS]    
                      @FECHA DATETIME

AS    
BEGIN    


    
	SET NOCOUNT ON   

	
    
    
	SET NOCOUNT ON   

	 
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : PASIVOS                                                     */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     
	 
   
  


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES CURSOR PRINCIPAL                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @CUR_NUMERO_OPERACION   NUMERIC
	        ,@CUR_CORRELATIVO        INT
			,@CUR_SERIE              VARCHAR(20)
			,@CUR_FECHA_PAGO         DATETIME
			,@CUR_MONTO_PAGO         NUMERIC
			,@CUR_FECHA_VENCIMIENTO  DATETIME




   /*-----------------------------------------------------------------------------*/
   /* GENERACION DE SALIDA                                                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	         (TIPO_REGISTRO                           VARCHAR(20)
			 ,OPERACION                               VARCHAR(05)
			 ,FECHA_PAGO_TOTAL                        DATETIME
			 ,FECHA_PAGO_PARCIAL                      DATETIME
			 ,MONTO_PAGADO                            NUMERIC)

	        		





   /*-----------------------------------------------------------------------------*/
   /* VARIABLES DE INTERFAZ                                                       */
   /*-----------------------------------------------------------------------------*/
      DECLARE @INT_TIPO_REGISTRO                           VARCHAR(20)
			 ,@INT_OPERACION                               VARCHAR(05)
			 ,@INT_FECHA_PAGO_TOTAL                        DATETIME
			 ,@INT_FECHA_PAGO_PARCIAL                      DATETIME
			 ,@INT_MONTO_PAGADO                            NUMERIC



   /*-----------------------------------------------------------------------------*/
   /* CURSOR DE CONTABILIDAD SOLO ARBITRAJES                                      */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_OPERACIONES CURSOR LOCAL FOR
      SELECT PAS.NUMERO_OPERACION
            ,PAS.numero_correlativo 
	        ,PAS.nombre_serie 
			,PAS.fecha_calculo 
			,PAS.flujo_cupon 
			,SER.fecha_vencimiento 
        FROM MdPasivo.dbo.RESULTADO_PASIVO PAS
	    LEFT JOIN
		     MdPasivo.dbo.SERIE_PASIVO     SER
		  ON PAS.nombre_serie = SER.nombre_serie 
       WHERE PAS.fecha_calculo     = @FECHA
	     AND PAS.tipo_operacion    ='VC'
       ORDER BY PAS.NUMERO_OPERACION
               ,PAS.numero_correlativo





       OPEN CURSOR_OPERACIONES
       FETCH NEXT FROM CURSOR_OPERACIONES INTO @CUR_NUMERO_OPERACION   
	                                          ,@CUR_CORRELATIVO        
			                                  ,@CUR_SERIE              
			                                  ,@CUR_FECHA_PAGO 
			                                  ,@CUR_MONTO_PAGO
											  ,@CUR_FECHA_VENCIMIENTO 
 


   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO CONTABLE                                                    */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS  = 0 BEGIN


          /*----------------------------------------------------------------------*/
          /* SETEO DE REGISTROS                                                   */
          /*----------------------------------------------------------------------*/
		    SELECT @INT_TIPO_REGISTRO      ='769-02-' 
			                               + LTRIM(RTRIM(CONVERT(CHAR,@CUR_NUMERO_OPERACION)))                         
										   + '-'
										   + LTRIM(RTRIM(CONVERT(CHAR,@CUR_CORRELATIVO)))                         
			      ,@INT_OPERACION          = ''                    
			      ,@INT_FECHA_PAGO_TOTAL   = @CUR_FECHA_VENCIMIENTO                        
			      ,@INT_FECHA_PAGO_PARCIAL = @CUR_FECHA_PAGO
			      ,@INT_MONTO_PAGADO       = @CUR_MONTO_PAGO                     
			      

          /*----------------------------------------------------------------------*/
          /* INGRESO DE REGISTROS                                                 */
          /*----------------------------------------------------------------------*/
		    INSERT INTO @SALIDA
	         (TIPO_REGISTRO                 ,OPERACION                             
			 ,FECHA_PAGO_TOTAL              ,FECHA_PAGO_PARCIAL                      
			 ,MONTO_PAGADO)                            
			 VALUES                           
	         (@INT_TIPO_REGISTRO            ,@INT_OPERACION                             
			 ,@INT_FECHA_PAGO_TOTAL         ,@INT_FECHA_PAGO_PARCIAL                      
			 ,@INT_MONTO_PAGADO)   




       FETCH NEXT FROM CURSOR_OPERACIONES INTO @CUR_NUMERO_OPERACION   
	                                          ,@CUR_CORRELATIVO        
			                                  ,@CUR_SERIE              
			                                  ,@CUR_FECHA_PAGO 
			                                  ,@CUR_MONTO_PAGO 
											  ,@CUR_FECHA_VENCIMIENTO     


     END
     CLOSE CURSOR_OPERACIONES
     DEALLOCATE CURSOR_OPERACIONES



   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     SELECT TIPO_REGISTRO               
		   ,OPERACION                   
		   ,CONVERT(CHAR(10),FECHA_PAGO_TOTAL,105)     AS FECHA_PAGO_TOTAL
		   ,CONVERT(CHAR(10),FECHA_PAGO_PARCIAL,105)   AS FECHA_PAGO_PARCIAL       
		   ,MONTO_PAGADO                
	   FROM @SALIDA




END
GO
