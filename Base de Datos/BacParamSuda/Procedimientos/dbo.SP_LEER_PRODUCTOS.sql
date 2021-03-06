USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_PRODUCTOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LEER_PRODUCTOS]    
     (    
       @SISTEMA        VARCHAR(10)
     )    
AS    
BEGIN    
    
	SET NOCOUNT ON    

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : SALIDA DE PRODUCTOS PARA VERIFICAR SISTEMAS                 */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* REQUERIMIENTO : NRO.19162 CONSULTA DE OPERACIONES                           */
   /* FECHA CRACION : 21/03/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   
   
   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @PRODUCTOS TABLE
	 (id_sistema       VARCHAR(10)
	 ,codigo_producto  CHAR(05)
	 ,descripcion      VARCHAR(50))



   /*-----------------------------------------------------------------------------*/
   /* INGRESO PARA TODAS LAS OPCIONES                                             */
   /*-----------------------------------------------------------------------------*/	
	 INSERT INTO @PRODUCTOS
	 SELECT  id_sistema
	       , codigo_producto
		   , descripcion 
	   FROM  producto 
	  WHERE  id_sistema in ('bfw','bcc') 
	  UNION
	 SELECT 'id_sistema' = 'OPT'
	       , OPCESTCOD
		   , OPCESTDSC 
	   FROM  lnkopc.cbmdbopc.dbo.OpcionEstructura
      UNION
     SELECT  id_sistema
	       , codigo_producto
		   , descripcion 
	   FROM  BacLineas.dbo.PRODUCTO_SISTEMA
	  WHERE ID_SISTEMA = 'PCS'


   /*-----------------------------------------------------------------------------*/
   /* RETORNO DE PRODUCTOS SEGUN SISTEMA                                          */
   /*-----------------------------------------------------------------------------*/
     SELECT id_sistema      
	       ,codigo_producto  
	       ,descripcion 
	   FROM @PRODUCTOS
	  WHERE id_sistema  = @SISTEMA
   
END

GO
