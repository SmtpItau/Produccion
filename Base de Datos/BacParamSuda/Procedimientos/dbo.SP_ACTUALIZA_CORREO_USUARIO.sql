USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_CORREO_USUARIO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_CORREO_USUARIO]    
                     @USUARIO CHAR(15)
                    ,@EMAIL   VARCHAR(50)

AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : EXTRAER MAIL DE CLIENTES INTERNOS CORPBANCA                 */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* REQUERIMIENTO : PRD -10966 MANTENEDOR DE GARANTIAS                          */
   /* FECHA CRACION : 13/05/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/

   /*=============================================================================*/
   /* SALIDA DE DATOS                                                             */
   /*=============================================================================*/
     UPDATE USUARIO
	    SET EMAIL    = @EMAIL
	  WHERE USUARIO  = @USUARIO


END

GO
