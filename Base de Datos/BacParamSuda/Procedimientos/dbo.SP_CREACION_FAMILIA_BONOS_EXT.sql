USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREACION_FAMILIA_BONOS_EXT]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CREACION_FAMILIA_BONOS_EXT]    
                         @Cod_familia       NUMERIC
					   , @Nom_Familia       VARCHAR(20)
					   , @Descrip_familia   VARCHAR(50)
					   , @Base_calculo      NUMERIC
					   , @MNCODMON          INT
					   , @MNCODMONPAG       INT
					   , @RUT_EMISOR        NUMERIC
					   , @COD_EMISOR        INT
					   , @MODIFICA          INT


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

     IF EXISTS(SELECT 1
	             FROM BacBonosExtSuda.dbo.TEXT_FML_INM
			    WHERE Cod_familia = @Cod_familia) BEGIN

		RAISERROR('CODIGO DE FAMILIA YA EXISTE EN SISTEMA',16,1)
		RETURN 0
	 END




   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO BacBonosExtSuda.dbo.TEXT_FML_INM 
	 (Cod_familia  , Nom_Familia  , Descrip_familia , Base_calculo 
	 ,MNCODMON     , MNCODMONPAG , RUT_EMISOR      ,COD_EMISOR 
	 ,MODIFICA)
	 VALUES
     (@Cod_familia  , @Nom_Familia  , @Descrip_familia , @Base_calculo 
	 ,@MNCODMON     , @MNCODMONPAG  , @RUT_EMISOR      , @COD_EMISOR 
	 ,@MODIFICA)



END

GO
