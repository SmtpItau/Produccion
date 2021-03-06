USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[CARTERA_OPCIONES]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[CARTERA_OPCIONES](@FECHA  DATETIME)



 /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns @OPERACIONES TABLE
	 (SISTEMA                VARCHAR(03)
	 ,MONEDA_1               INT
	 ,STR_MONEDA_1           VARCHAR(03)
	 ,MONEDA_2               INT
	 ,STR_MONEDA_2           VARCHAR(03)
	 ,FOLIO                  NUMERIC
	 ,CONTRATO               NUMERIC
	 ,FECHA_CONTRATO         DATETIME
	 ,FECHA_VENCIMIENTO      DATETIME
	 ,CARTERA_FINANCIERA     VARCHAR(04)
	 ,LIBRO                  VARCHAR(04)
	 ,NORMATIVA              VARCHAR(04)
	 ,RUT_CLIENTE            NUMERIC
	 ,CODIGO_CLIENTE         INT
	 ,NOMBRE_CLIENTE         VARCHAR(150)
     ,PAIS                   INT 
	 ,CNPJ                   VARCHAR(20)
	 ,Clopcion               VARCHAR(02)
	 ,RUT_DV                 VARCHAR(02)
	 ,OPERADOR               VARCHAR(15)
	 ,CODIDO_ESTRUCTURA      INT
	 ,DESCRIPCION_ESTRUCTURA VARCHAR(100)
	 ,MONTO_1                NUMERIC
	 ,MONTO_2                NUMERIC
	 ,NUMERO_ESTRUCTURA      INT
	 ,CaVr                   NUMERIC
	 ,CAVRDETML              NUMERIC
	 ,CAPRIMAINICIALDETML    NUMERIC
	 ,TIPO_OPERACION         VARCHAR(01)
	 ,CARTERA                VARCHAR(100)
	 ,MODALIDAD              VARCHAR(02)
	 ,FORMAPAGOCOMP          INT
	 ,ORIGEN                 VARCHAR(03))

		 




 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA OPCIONES                                            */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* ORIGEN DE CARTERA SAO                                                       */
   /*-----------------------------------------------------------------------------*/
    INSERT @OPERACIONES
    SELECT MAS.CaSistema
          ,DET.CaCodMon1
		  ,''
          ,DET.CaCodMon2
		  ,''
          ,MAS.CaNumFolio 
          ,MAS.CaNumContrato 
	      ,MAS.CaFechaContrato 
		  ,DET.CAFECHAVCTO
	      ,MAS.CaCarteraFinanciera 
	      ,MAS.CaLibro 
	      ,MAS.CaCarNormativa 
	      ,MAS.CaRutCliente 
	      ,MAS.CaCodigo
		  ,''
          ,0
	      ,''
	      ,''
	      ,''
	      ,MAS.CaOperador
	      ,MAS.CaCodEstructura 
	      ,OES.OpcEstDsc
          ,DET.CaMontoMon1
          ,DET.CaMontoMon2
	      ,DET.CaNumEstructura 
		  ,MAS.CaVr
	      ,DET.CaVrDetML
	      ,DET.CaPrimaInicialDetML
		  ,DET.CACVOPC
		  ,''
		  ,DET.CAMODALIDAD
		  ,DET.CaFormaPagoComp
		  ,'SAO'
      FROM CbMdbOpc..CaResEncContrato MAS
     INNER JOIN
           CbMdbOpc..OpcionEstructura       OES
	    ON OES.OpcEstCod          =  MAS.CaCodEstructura 
     INNER JOIN
           CbMdbOpc..CaResDetContrato       DET
	    ON DET.CaDetFechaRespaldo  = MAS.CaEncFechaRespaldo
	   AND DET.CaNumContrato       = MAS.CaNumContrato 
	   AND DET.CAFECHAVCTO         > @FECHA
     WHERE MAS.CaEncFechaRespaldo  = @FECHA
       AND MAS.CaEstado           = ''	
	   AND MAS.CaCodEstructura NOT IN(6,13)
	   



   /*-----------------------------------------------------------------------------*/
   /* ORIGEN DE CARTERA SAO                                                       */
   /*-----------------------------------------------------------------------------*/
    INSERT @OPERACIONES
    SELECT MAS.CaSistema
          ,DET.CaCodMon1
		  ,''
          ,DET.CaCodMon2
		  ,''
          ,MAS.CaNumFolio 
          ,MAS.CaNumContrato 
	      ,MAS.CaFechaContrato 
		  ,DET.CAFECHAVCTO
	      ,MAS.CaCarteraFinanciera 
	      ,MAS.CaLibro 
	      ,MAS.CaCarNormativa 
	      ,MAS.CaRutCliente 
	      ,MAS.CaCodigo
		  ,''
          ,0
	      ,''
	      ,''
	      ,''
	      ,MAS.CaOperador
	      ,MAS.CaCodEstructura 
	      ,OES.OpcEstDsc
          ,DET.CaMontoMon1
          ,DET.CaMontoMon2
	      ,DET.CaNumEstructura 
		  ,MAS.CaVr
	      ,DET.CaVrDetML
	      ,DET.CaPrimaInicialDetML
		  ,DET.CACVOPC
		  ,''
		  ,DET.CAMODALIDAD
		  ,DET.CaFormaPagoComp
		  ,'BFW'
      FROM CbMdbOpc..CaResEncContrato MAS
     INNER JOIN
           CbMdbOpc..OpcionEstructura       OES
	    ON OES.OpcEstCod          =  MAS.CaCodEstructura 
     INNER JOIN
           CbMdbOpc..CaResDetContrato       DET
	    ON DET.CaDetFechaRespaldo  = MAS.CaEncFechaRespaldo
	   AND DET.CaNumContrato       = MAS.CaNumContrato 
	   AND DET.CAFECHAVCTO         > @FECHA
	   AND DET.CaNumEstructura     = 1
     WHERE MAS.CaEncFechaRespaldo  = @FECHA
       AND MAS.CaEstado           = ''	
	   AND MAS.CaCodEstructura IN(6,13)
	   





	 


   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR MONEDAS EN TABLA DE OPERACIONES                                  */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET STR_MONEDA_1  = CASE WHEN MON.mnnemo ='UF' THEN 'CLF' ELSE MON.mnnemo END
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.DBO.MONEDA      MON
		 ON MON.mncodmon         = OPE.MONEDA_1 

     UPDATE OPE
	    SET STR_MONEDA_2  = CASE WHEN MON.mnnemo ='UF' THEN 'CLF' ELSE MON.mnnemo END
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.DBO.MONEDA      MON
		 ON MON.mncodmon         = OPE.MONEDA_2 



		 

   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR NOMBRE CLIENTE Y PAIS                                            */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET NOMBRE_CLIENTE  = CLI.Clnombre
		   ,PAIS            = CLI.CLPAIS  
		   ,RUT_DV          = CLDV
		   ,CNPJ            = ISNULL(CLI.CNPJ,LTRIM(RTRIM(CLI.Clrut)) + '-' + LTRIM(RTRIM(CLI.CLDV)))        
		   ,CLOPCION        = CASE 
			                  WHEN CLI.cltipcli = 8 THEN 'PF'
			                  WHEN CLI.cltipcli = 1 THEN 'IF'
			                  WHEN CLI.cltipcli = 2 THEN 'IF'
			                  WHEN CLI.cltipcli = 3 THEN 'IF'
			                  WHEN CLI.cltipcli = 4 THEN 'IF'
			                  WHEN CLI.cltipcli = 5 THEN 'IF'
			                  WHEN CLI.cltipcli = 6 THEN 'IF'
			                  WHEN CLI.cltipcli = 7 THEN 'PJ'
			                  WHEN CLI.cltipcli = 9 THEN 'PJ'
			                  WHEN CLI.cltipcli = 10 THEN 'PJ'
			                  WHEN CLI.cltipcli = 11 THEN 'PJ'
			                  WHEN CLI.cltipcli = 12 THEN 'PJ'
			                  WHEN CLI.cltipcli = 13 THEN 'PJ'
			                  ELSE  'PJ'
		                      END 
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.DBO.CLIENTE      CLI WITH(NOLOCK)
		 ON CLI.Clrut          = OPE.RUT_CLIENTE 
		AND CLI.Clcodigo       = OPE.CODIGO_CLIENTE 


   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR CARTERA EN TABLA DE OPERACIONES                                  */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET CARTERA   = CAR.TBGLOSA 
	   FROM @OPERACIONES OPE
	  INNER JOIN
            bacparamsuda.dbo.TABLA_GENERAL_DETALLE CAR
		 ON CAR.tbcateg   = 1111 
		AND CAR.tbcodigo1 = OPE.NORMATIVA 


 Return



 END

GO
