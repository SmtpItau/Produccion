USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_INTERFACES_MODULO_CONFIGURACION]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_INTERFACES_MODULO_CONFIGURACION]    

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
   /* SALIDA DE CALCULOS                                                          */
   /*-----------------------------------------------------------------------------*/
	  SELECT DISTINCT 
	         INF.ID_INTERFAZ     AS ID
	        ,INF.Nombre_interfaz AS NOMBRE
	    FROM DBO.FORMATO_INTERFACES             INF
	   INNER JOIN
	         DBO.FORMATO_INTERFACES_CONFIGURA   INC
	      ON INC.ID_INTERFAZ = INF.Id_interfaz 


END
GO
