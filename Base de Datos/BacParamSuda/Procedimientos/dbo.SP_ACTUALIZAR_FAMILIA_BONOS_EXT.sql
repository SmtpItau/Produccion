USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZAR_FAMILIA_BONOS_EXT]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZAR_FAMILIA_BONOS_EXT]    
                         @Cod_familia       NUMERIC
					   , @Nom_Familia       VARCHAR(20)
					   , @Descrip_familia   VARCHAR(50)
					   , @Base_calculo      NUMERIC
					   , @MNCODMON          INT
					   , @MNCODMONPAG       INT
					   , @RUT_EMISOR        NUMERIC
					   , @COD_EMISOR        INT



AS    
BEGIN    
    
	SET NOCOUNT ON   


	

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : LISTADO DE VALORES DE FAMILIA                               */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 08/07/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/



   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     UPDATE BacBonosExtSuda.dbo.TEXT_FML_INM 
	    SET Nom_Familia      = @Nom_Familia
		   ,Descrip_familia  = @Descrip_familia
		   ,Base_calculo     = @Base_calculo
		   ,MNCODMON         = @MNCODMON
           ,MNCODMONPAG      = @MNCODMONPAG
		   ,RUT_EMISOR       = @RUT_EMISOR        
		   ,COD_EMISOR       = @COD_EMISOR        
	  WHERE Cod_familia      = @Cod_familia

END

GO
