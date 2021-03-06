USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[ContabilidadSpot]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ContabilidadSpot](@FECHA_CONTABILIZACION  DATETIME)


  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns @CONTABILIDAD TABLE
	 (NUMERO_VOUCHER          NUMERIC
	 ,FECHA_INGRESO           DATETIME
	 ,FECHA_CONTABLE          DATETIME
	 ,GLOSA                   VARCHAR(70)
	 ,TIPO_VOUCHER            CHAR(01)
	 ,TIPO_OPERACION          CHAR(05)
	 ,OPERACION               NUMERIC
	 ,CORRELATIVO_CAR         INT
	 ,DOCUMENTO               NUMERIC
	 ,CODIGO_PRODUCTO         CHAR(07)
	 ,ID_SISTEMA              CHAR(03)
	 ,RUT_CLIENTE             NUMERIC
	 ,CODIGO_CLIENTE          NUMERIC
	 ,MERCADO                 CHAR(04)
	 ,MONEDA_OPERACION        CHAR(03)
	 ,TIPO_CAMBIO             NUMERIC
	 ,CORRELATIVO_DET         INT
	 ,CUENTA                  VARCHAR(20)
	 ,DESCRIPCION             VARCHAR(100)
	 ,TIPO_CUENTA             VARCHAR(05)
	 ,TIPO_MONTO              CHAR(01)
	 ,MONTO                   FLOAT
	 ,CODIGO_CORRESPONSAL     NUMERIC 
	 ,VALOR_CAMPO             VARCHAR(30))




 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA SPOT CONTABLE                                       */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* CONTABILIDAD DE FORWARD                                                     */
   /*-----------------------------------------------------------------------------*/
	 INSERT INTO @CONTABILIDAD
     SELECT MAS.NUMERO_VOUCHER          
	       ,MAS.FECHA_INGRESO           
	       ,MAS.FECHA_CONTABLE          
	       ,MAS.GLOSA                   
	       ,MAS.TIPO_VOUCHER            
	       ,MAS.TIPO_OPERACION          
	       ,MAS.OPERACION               
	       ,MAS.CORRELATIVO             
	       ,MAS.DOCUMENTO               
	       ,MAS.CODIGO_PRODUCTO         
	       ,MAS.ID_SISTEMA              
	       ,MAS.RUT_CLIENTE             
	       ,MAS.CODIGO_CLIENTE          
	       ,MAS.MERCADO                 
	       ,MAS.MONEDA_OPERACION        
	       ,MAS.TIPO_CAMBIO 
           ,DET.CORRELATIVO        
	       ,DET.CUENTA 
		   ,CUE.DESCRIPCION 
		   ,CUE.TIPO_CUENTA                
	       ,DET.TIPO_MONTO              
	       ,DET.MONTO                   
	       ,DET.CODIGO_CORRESPONSAL     
	       ,DET.VALOR_CAMPO 		               
       FROM BacCamSuda.dbo.bac_cnt_voucher          MAS WITH(NOLOCK)
      INNER JOIN 
            BacCamSuda.dbo.bac_cnt_detalle_voucher  DET WITH(NOLOCK)
	     ON DET.numero_voucher = MAS.numero_voucher
	    AND DET.Tipo_Operacion = MAS.Tipo_Operacion
		AND DET.OPERACION      = MAS.OPERACION
       Left JOIN
            BacParamSuda.dbo.PLAN_DE_CUENTA         CUE WITH(NOLOCK)
	     ON DET.CUENTA         = CUE.CUENTA           
	  WHERE MAS.Fecha_Ingreso  = @FECHA_CONTABILIZACION


 Return

 END



GO
