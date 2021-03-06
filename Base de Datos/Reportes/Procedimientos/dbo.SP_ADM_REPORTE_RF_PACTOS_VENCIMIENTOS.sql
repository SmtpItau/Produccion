USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_RF_PACTOS_VENCIMIENTOS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_RF_PACTOS_VENCIMIENTOS]    
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
     CREATE TABLE #MDMO
	 (monumoper               VARCHAR(20)
	 ,mocorrela				  VARCHAR(20)
	 ,mofecpro                DATETIME
	 ,movalvenp               NUMERIC
	 ,motipoper               VARCHAR(05)
	 ,motipopero              VARCHAR(05))



        
		-- select convert(char(10),mofecpro,103),*FROM bactradersuda.dbo.MDMO

   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA SEGUN FECHA MDVI                                          */
   /*-----------------------------------------------------------------------------*/
     SET @QUERY = 'INSERT INTO #MDMO '
	 SET @QUERY = @QUERY + 'SELECT '
	 SET @QUERY = @QUERY + 'monumoper'
	 SET @QUERY = @QUERY + ',mocorrela'
	 SET @QUERY = @QUERY + ',mofecpro'
	 SET @QUERY = @QUERY + ',movalvenp'
	 SET @QUERY = @QUERY + ',motipoper'
	 SET @QUERY = @QUERY + ',motipopero'
	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDMO' + SUBSTRING(CONVERT(CHAR(8),@FECHA,112),5,4)
	 SET @QUERY = @QUERY + ' WHERE mofecpro='
	 SET @QUERY = @QUERY + ''''
	 SET @QUERY = @QUERY +  convert(char(10),@FECHA,111)
	 SET @QUERY = @QUERY +   ''''

	 EXEC (@QUERY)


   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     SELECT 'Nr_controle_dado_institucion_financeira' = '76902'+ltrim(rtrim(monumoper))+ltrim(rtrim(mocorrela)) -- 769+02+no.contrato+correlativo
		   ,'Identificador_Captacion'                  = ltrim(rtrim(monumoper))+ltrim(rtrim(mocorrela)) 		-- contrato+correlativo
		   ,'Data_do_Pagamento'                        = convert(char(10),mofecpro,103)									--  dd/mm/yyyy cambiar formato
		   ,'Data_principal_recebendo_pagamento'       = convert(char(10),mofecpro,103)									--  agregar campo data do pagamento parcial -> mismo campo data do pagamento
		   ,'Parcela_de_Principal_sendo_paga'          = movalvenp	
		   --,'Valor_sendo_pago_para_a_parcela'          = movalvenp	     -- eliminar
	   FROM #MDMO (NOLOCK)    
	  WHERE mofecpro   = @FECHA
	    AND motipoper  = 'RC'
		AND motipopero = 'CP'



END

GO
