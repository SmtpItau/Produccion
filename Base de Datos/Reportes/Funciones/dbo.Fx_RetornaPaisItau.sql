USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_RetornaPaisItau]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[Fx_RetornaPaisItau](@Pais int)
                                             
											 

  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns VARCHAR(20)



 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : PAIS ITAU                                                   */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     DECLARE @COD_ITAU VARCHAR(20)



	 SELECT @COD_ITAU    = COD_ITAU
	   FROM BacParamSuda.DBO.PAIS WITH(NOLOCK)
	  WHERE CODIGO_PAIS  = @Pais 

	     IF  @@ROWCOUNT = 0 BEGIN
		     SET @COD_ITAU = 'S_COD'
		 END



       RETURN @COD_ITAU


 END

GO
