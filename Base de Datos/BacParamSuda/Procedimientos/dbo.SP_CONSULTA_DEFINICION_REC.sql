USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_DEFINICION_REC]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CONSULTA_DEFINICION_REC]    
                          @RUTCLIENTE  DECIMAL(10,0)
						 ,@CODIGO      INT


AS    
BEGIN    
    
	SET NOCOUNT ON   

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : EXTRAER METODOLOGIA REC CLIENTE                             */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 16/10/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/



   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
	 DECLARE @Rec AS INT


   /*-----------------------------------------------------------------------------*/
   /* EXTRACCION DE METODOLOGIA REC PARA CLIENTE                                  */
   /*-----------------------------------------------------------------------------*/
   	 SET @Rec = (SELECT 'Metodo REC' = BacLineas.dbo.FN_RIEFIN_METODO_LCR( @RUTCLIENTE, @CODIGO, 0, 0))


   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
	 SELECT @Rec                   AS REC
  
		   


 END



GO
