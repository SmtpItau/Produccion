USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_PRODUCTOS_FACILITY]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_PRODUCTOS_FACILITY]    
                   
AS    
BEGIN    


    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : SALIDA DE REGISTROS ASIGNADOS FACILITY                      */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 05/11/2015                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/




   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     SELECT FAC.Id_sistema          AS  'Id_Sistema'
           ,SIS.nombre_sistema      AS  'Descripcion de Sistema'
	       ,FAC.Codigo_Producto     AS  'Codigo_producto'
	       ,PRO.descripcion         AS  'Descripcion de Producto'
	       ,FAC.Codigo_ProductoOtro AS  'Codigo_producto_otro'
	       ,FAC.Codigo_Instrumento  AS  'Codigo_Instrumento'
	       ,ISNULL
	        (CASE 
	         WHEN FAC.Id_sistema ='BEX' THEN (SELECT Nom_Familia
	                                           FROM BacBonosExtSuda.dbo.text_fml_inm
			            				      WHERE Cod_familia = FAC.Codigo_Instrumento)
             ELSE (SELECT INGLOSA
	                 FROM BACPARAMSUDA..Instrumento
		            WHERE incodigo = FAC.Codigo_Instrumento)
	         END                     
	       ,'NO APLICA')            AS  'Descripcion Instrumento'
	       ,FAC.Codigo_Facility     AS  'Facility'
	       ,COD.DESCRIPCION         AS  'Desc. Facility'
       FROM BACPARAMSUDA..PRODUCTOS_MESA_FACILITY FAC
      INNER JOIN
            BACPARAMSUDA..SISTEMA_CNT             SIS
	     ON SIS.id_sistema       = FAC.Id_sistema 
      INNER JOIN
            BACPARAMSUDA..PRODUCTO                PRO
	     ON PRO.Codigo_Producto  = FAC.Codigo_Producto 
      INNER JOIN
           BACPARAMSUDA..CODIGOS_FACILITY        COD
	    ON COD.CODIGO_FACILITY  = FAC.CODIGO_FACILITY 



END
GO
