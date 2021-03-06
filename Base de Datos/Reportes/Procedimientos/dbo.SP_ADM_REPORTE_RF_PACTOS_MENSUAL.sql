USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_RF_PACTOS_MENSUAL]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_RF_PACTOS_MENSUAL]    
                      @FECHA DATETIME

AS    
BEGIN    


	SET NOCOUNT ON   

	 
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : PACTOS RENTA FIJA                                           */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 14/03/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
	 DECLARE @QUERY             VARCHAR(MAX)



   /*-----------------------------------------------------------------------------*/
   /* CREACION DE ESTRUCTURA DE TABLA DINAMICA                                    */
   /*-----------------------------------------------------------------------------*/
     CREATE TABLE #MDVI
	 (vinumoper               NUMERIC
	 ,virutcli                NUMERIC
	 ,vicodcli                NUMERIC
	 ,vimonpact               NUMERIC
	 ,vivalinip               NUMERIC)


        


   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA SEGUN FECHA MDVI                                          */
   /*-----------------------------------------------------------------------------*/
     SET @QUERY = 'INSERT INTO #MDVI '
	 SET @QUERY = @QUERY + 'SELECT '
	 SET @QUERY = @QUERY + 'vinumoper'
	 SET @QUERY = @QUERY + ',virutcli'
	 SET @QUERY = @QUERY + ',vicodcli'
	 SET @QUERY = @QUERY + ',vimonpact'
	 SET @QUERY = @QUERY + ',vivalinip'
	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDVI' + SUBSTRING(CONVERT(CHAR(8),@FECHA,112),5,4)

	 EXEC (@QUERY)


   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     SELECT 'Nr_controle_dado_institucion_financeira' = 0	
		   ,'Devedor (CNPJ)'                          = CASE WHEN CI.CNPJ = '' THEN CI.Clrut 
		                                                     ELSE ISNULL(CI.CNPJ,CI.Clrut)
													    END 
		   ,'Data_estoque'                            = @FECHA
		   ,'Moeda_do_estoque'                        = CASE WHEN VI.vimonpact = 998 THEN 'CLF' ELSE MO.mnnemo END  
		   ,'Valor_do_estoque'                        = VI.vivalinip
	   FROM #MDVI             VI (NOLOCK)
	  INNER JOIN 
	        BacParamSuda.dbo.CLIENTE  CI
		 ON CI.Clrut       = VI.virutcli 
	    AND CI.Clcodigo    = VI.vicodcli		
	  INNER JOIN 
	        BacParamSuda.dbo.MONEDA   MO 
		 ON MO.mncodmon    = VI.vimonpact	




END
GO
