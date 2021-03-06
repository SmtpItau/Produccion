USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_CORREOS_USUARIOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_CORREOS_USUARIOS]    


AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : EXTRAER MAIL DE CLIENTES INTERNOS CORPBANCA                 */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* REQUERIMIENTO : PRD -10966 MANTENEDOR DE GARANTIAS                          */
   /* FECHA CRACION : 13/05/2014                                                  */
   /* PRUEBA        : EXEC SP_CONSULTA_CORREOS_USUARIO                            */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/

   /*=============================================================================*/
   /* SALIDA DE DATOS                                                             */
   /*=============================================================================*/
     SELECT RTRIM(LTRIM(ISNULL(EMAIL,'')))  AS CORREO
	       ,RTRIM(LTRIM(USUARIO))   AS USUARIO
		   ,RTRIM(LTRIM(NOMBRE))    AS NOMBRE
	  FROM USUARIO WITH(NOLOCK)



END

GO
