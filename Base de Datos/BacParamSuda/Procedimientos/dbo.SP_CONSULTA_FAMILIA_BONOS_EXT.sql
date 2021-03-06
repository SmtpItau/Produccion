USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_FAMILIA_BONOS_EXT]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_FAMILIA_BONOS_EXT]    
                       
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
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     SELECT FAM.Cod_familia 
           ,FAM.Nom_Familia 
	       ,FAM.Descrip_familia 
	       ,FAM.Base_calculo 
		   ,FAM.MNCODMON
		   ,ISNULL(MO1.mnnemo,'') AS MONEDA
		   ,FAM.MNCODMONPAG
		   ,ISNULL(MO2.mnnemo,'') AS MONEDA_PAGO
		   ,FAM.RUT_EMISOR 
		   ,FAM.COD_EMISOR
		   ,FAM.MODIFICA
       FROM BacBonosExtSuda.dbo.TEXT_FML_INM FAM   
	   LEFT JOIN
	        BacParamSuda.DBO.MONEDA          MO1
	     ON FAM.mncodmon    = MO1.MNCODMON
	   LEFT JOIN
	        BacParamSuda.DBO.MONEDA          MO2
	     ON FAM.MNCODMONPAG = MO2.MNCODMON



END

GO
