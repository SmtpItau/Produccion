USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[ContabilidadForwardXOperacion]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ContabilidadForwardXOperacion](@FECHA DATETIME ,@OPERACION  NUMERIC )


  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns @CONTABILIDAD TABLE
	 (NUMERO_VOUCHER          NUMERIC
	 ,ID_SISTEMA              VARCHAR(04)
	 ,TIPO_MOVIMIENTO         VARCHAR(04)
	 ,TIPO_OPERACION          VARCHAR(04)
	 ,CODIGO_INSTRUMENTO      VARCHAR(10)
	 ,MONEDA_INSTRUMENTO      VARCHAR(10)
	 ,GLOSA_PERFIL            VARCHAR(150)
	 ,FECHA_INGRESO           DATETIME
	 ,GLOSA                   VARCHAR(150)
	 ,OPERACION               NUMERIC
	 ,FOLIO_PERFIL            INT
	 ,CUENTA                  VARCHAR(20)
	 ,DESCRIPCION             VARCHAR(150)
	 ,CORRELATIVO             INT
	 ,TIPO_CUENTA             VARCHAR(04)
	 ,TIPO_MONTO              VARCHAR(01)
	 ,MONTO                   NUMERIC
	 ,MONEDA                  INT)




 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA FORDWARD CONTABLE                                   */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* CONTABILIDAD DE FORWARD                                                     */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @CONTABILIDAD
     SELECT MAS.NUMERO_VOUCHER
	       ,PER.id_sistema 
		   ,PER.tipo_movimiento 
		   ,PER.tipo_operacion 
		   ,PER.codigo_instrumento 
		   ,PER.moneda_instrumento 
		   ,PER.glosa_perfil 
           ,MAS.FECHA_INGRESO
           ,MAS.GLOSA
		   ,MAS.Operacion 
		   ,MAS.Folio_Perfil 
	       ,DET.CUENTA
	       ,CUE.DESCRIPCION
		   ,DET.CORRELATIVO
	       ,CUE.TIPO_CUENTA
	       ,DET.TIPO_MONTO
	       ,DET.Monto
		   ,DET.Moneda 
       FROM BacfwdSuda.dbo.VOUCHER_CNT          MAS WITH(NOLOCK)
      INNER JOIN 
            BacfwdSuda.dbo.DETALLE_VOUCHER_CNT  DET WITH(NOLOCK)
	     ON DET.numero_voucher  = MAS.numero_voucher
       LEFT JOIN
            BacParamSuda.dbo.PLAN_DE_CUENTA     CUE WITH(NOLOCK)
	     ON DET.CUENTA          = CUE.CUENTA 
	  INNER JOIN        
	        BACPARAMSUDA.DBO.PERFIL_CNT         PER WITH(NOLOCK)
		 ON PER.folio_perfil    = MAS.Folio_Perfil 
      WHERE MAS.FECHA_INGRESO   = @FECHA
	    AND MAS.OPERACION       = @OPERACION
      ORDER BY  MAS.Operacion
	           ,DET.CORRELATIVO


 Return

 END





GO
