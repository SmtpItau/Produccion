USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_DECIMALES_PRECIO_CIERRE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_DECIMALES_PRECIO_CIERRE]    
                        @Categoria INT
					   ,@moneda    INT


AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CANTIDAD DE DECIMALES U INFORMACION POR MONEDA              */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* REQUERIMIENTO : CAMBIAR CANTIDAD DE DECIMALES PARA TURING WEB ASP.NET       */
   /*                 EN EL PRECIO DE CIERRE                                      */
   /* FECHA CRACION : 15/09/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*=============================================================================*/
   /* VERIFICO QUE EXISTA EL CODIGO 9910 EN SISTEMA PARA CREAR LOS VALORES POR    */
   /* DEFECTO EN MASCARA                                                          */
   /*=============================================================================*/
     IF NOT EXISTS (SELECT 1
	                  FROM TABLA_GENERAL_GLOBAL 
					 WHERE ctcateg = 9910) BEGIN

	    INSERT INTO TABLA_GENERAL_GLOBAL VALUES(9910,'DECIMALES TURING DIST',1,0,0,1,0,0,0,0,0)

	 END

   /*=============================================================================*/
   /* VERIFICO QUE EXISTA EL CODIGO 9910 EN SISTEMA PARA CREAR LOS VALORES POR    */
   /* DEFECTO EN DETALLE                                                          */
   /*=============================================================================*/
     IF NOT EXISTS(SELECT 1
	                  FROM TABLA_GENERAL_DETALLE
				     WHERE tbcateg           = 9910
				       AND Convert(int,NEMO) = 0) BEGIN

		 INSERT INTO TABLA_GENERAL_DETALLE VALUES (9910 ,1 ,0,'1900-01-01' ,4,'DEC.PRECIO CIERRE GENERAL',0)


	  END



   /*=============================================================================*/
   /* EXISTE CODIGO DE MONEDA ENVIADO                                             */
   /*=============================================================================*/
     IF EXISTS (SELECT 1
	              FROM TABLA_GENERAL_DETALLE
                 WHERE tbcateg           = @Categoria
	               AND Convert(int,NEMO) = @moneda ) BEGIN


     /*==========================================================================*/
     /* SALIDA DE DATOS                                                          */
     /*==========================================================================*/
     SELECT tbtasa
	       ,tbfecha
		   ,tbvalor 
	       ,tbglosa
		   ,nemo
       FROM TABLA_GENERAL_DETALLE 
      WHERE tbcateg           = @Categoria
	    AND Convert(int,NEMO) = @moneda 
		


     END
	 ELSE BEGIN

     /*==========================================================================*/
     /* SALIDA DE DATOS                                                          */
     /*==========================================================================*/
     SELECT tbtasa
	       ,tbfecha
		   ,tbvalor 
	       ,tbglosa
		   ,nemo
       FROM TABLA_GENERAL_DETALLE 
      WHERE tbcateg           = @Categoria
	    AND Convert(int,NEMO) = 0 


	 END




 

  

END
GO
