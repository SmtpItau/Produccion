USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_CLIENTE_BILATERAL_ART84]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_CLIENTE_BILATERAL_ART84]    
                        @RUT_CLIENTE        NUMERIC (10,0)
					

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
     SELECT ClCompBilateral       AS ES_BILATERAL
	   FROM BACPARAMSUDA..Cliente         
      WHERE Clrut               = @RUT_CLIENTE 



  

END

GO
