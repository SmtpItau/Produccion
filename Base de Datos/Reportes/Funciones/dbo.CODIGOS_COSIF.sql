USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[CODIGOS_COSIF]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[CODIGOS_COSIF](@CUENTA_CONTABLE VARCHAR(20))


 /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns @COSIF TABLE
	 (cta_corp       VARCHAR(50)
	 ,cosif          VARCHAR(50)
	 ,cosif_ger      VARCHAR(50)
	 ,cosif_gl       VARCHAR(50)			
	 ,cta_cosif      VARCHAR(50)
	 ,glosa_cosif    VARCHAR(80)
	 ,glosa_cosif_gl VARCHAR(80)
	 ,categoria	     VARCHAR(30))

	 



 AS BEGIN

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CODIGOS COSIF CONTABLES                                     */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* CONTABILIDAD DE FORWARD                                                     */
   /*-----------------------------------------------------------------------------*/
     INSERT @COSIF
     SELECT cta_corp       
	       ,cosif          
	       ,cosif_ger      
	       ,cosif_gl       		
	       ,cta_cosif      
	       ,glosa_cosif    
	       ,glosa_cosif_gl 
	       ,categoria	   
       FROM BacParamSuda.DBO.TBL_COSIF_ITAU WITH(NOLOCK)
	  WHERE cta_corp = @CUENTA_CONTABLE
	 


 Return


 END


GO
