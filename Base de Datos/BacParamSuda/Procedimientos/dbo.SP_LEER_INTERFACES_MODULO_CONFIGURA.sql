USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_INTERFACES_MODULO_CONFIGURA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_INTERFACES_MODULO_CONFIGURA]    
                      @Nombre_interfaz        VARCHAR(20)
                     ,@SISTEMA                CHAR(03) 
                     ,@CODIGO                 CHAR(50) 
AS    
BEGIN    


    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : SALIDA DE INTERFAZ CONFIGURA DE MODULOS DE RENTA FIJA       */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 02/11/2015                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @ID_INTERFAZ INT


   /*-----------------------------------------------------------------------------*/
   /* BUSQUEDA DE INTERFAZ                                                        */
   /*-----------------------------------------------------------------------------*/
     SELECT @ID_INTERFAZ = ID_INTERFAZ FROM DBO.FORMATO_INTERFACES WHERE UPPER(LTRIM(RTRIM(Nombre_interfaz))) = UPPER(LTRIM(RTRIM(@Nombre_interfaz)))


	
   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE CALCULOS                                                          */
   /*-----------------------------------------------------------------------------*/
     SELECT SUBCODIGO AS CODIGO
	       ,NAME      AS NAME
		   ,VALUE     AS VALUE
	   FROM DBO.FORMATO_INTERFACES_CONFIGURA WITH(NOLOCK)
	  WHERE ID_INTERFAZ = @ID_INTERFAZ
	    AND SISTEMA     = @SISTEMA
		AND CODIGO      = @CODIGO
	  ORDER BY CODIGO ASC


END
GO
