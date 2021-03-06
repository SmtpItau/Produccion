USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_DATOS_FAMILIA_BONOS_EXT]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_DATOS_FAMILIA_BONOS_EXT]    
                       @COD_FAMILIA NUMERIC

                       
AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : LISTADO DE VALORES DE FAMILIA                               */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 14/07/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* FECHA MODIF.  : 03/08/2016 MNavarro                                         */
   /* falta modificar la tabla y el mantenedor para que permita modificar def.    */
   /*-----------------------------------------------------------------------------*/
   -- SP_CONSULTA_DATOS_FAMILIA_BONOS_EXT 2005
   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     SELECT FAM.Cod_familia 
           ,FAM.Nom_Familia 
	       ,FAM.Descrip_familia 
	       ,FAM.Base_calculo 
		   ,FAM.MNCODMON
		   ,ISNULL(MO1.mnnemo,'')   AS MONEDA
		   ,FAM.MNCODMONPAG
		   ,ISNULL(MO2.mnnemo,'')   AS MONEDA_PAGO
		   ,FAM.RUT_EMISOR 
		   ,FAM.COD_EMISOR
		   ,ISNULL(EMI.nom_emi ,'') AS NOMBRE
		   ,ISNULL(PAI.NOMBRE ,'')  AS PAIS
		   , SeriadoSN            
		   , UsaIdInternacionalSN
           , Tipo_Precio_PrcSN   
		   , ISIN_Pais           
		   , ISIN_Emisor         
		   , ISIN_Inst            
		   , UsaBaseFamiliaSN 
		   , ConvFamilia      
		   , ModificarMdaSN 
		   , ModificarMdaPagSN 
       FROM BacBonosExtSuda.dbo.TEXT_FML_INM FAM   
	   LEFT JOIN
	        BacParamSuda.DBO.MONEDA          MO1
	     ON FAM.mncodmon    = MO1.MNCODMON
	   LEFT JOIN
	        BacParamSuda.DBO.MONEDA          MO2
	     ON FAM.MNCODMONPAG = MO2.MNCODMON
	   LEFT JOIN
	        BacBonosExtSuda.dbo.text_emi_itl EMI
		 ON FAM.RUT_EMISOR  = EMI.rut_emi 
		AND FAM.COD_EMISOR  = EMI.codigo 
	   LEFT JOIN
	        BacParamSuda.dbo.CLIENTE        CLI
		 ON FAM.RUT_EMISOR  = CLI.Clrut 
		AND FAM.COD_EMISOR  = CLI.Clcodigo 
	   LEFT JOIN
	        BacParamSuda.dbo.PAIS           PAI
		 ON CLI.Clpais      = PAI.codigo_pais 
      WHERE FAM.COD_FAMILIA = @COD_FAMILIA


END

GO
