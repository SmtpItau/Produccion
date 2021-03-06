USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[CARTERA_FORWARD]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[CARTERA_FORWARD](@FECHA  DATETIME)

  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns @OPERACIONES TABLE
	 (OPERACION       NUMERIC
	 ,RUT_CLIENTE     NUMERIC
	 ,COD_CLIENTE     NUMERIC
	 ,COD_PRODUCTO    INT			
	 ,COD_MONEDA_1    INT
	 ,COD_MONEDA_2    INT
	 ,MONTO_NOC_1     numeric(25,4)
	 ,MONTO_NOC_2	  numeric(25,4)
	 ,TIPO_OPERACION  CHAR(01)
	 ,FECHA_INGRESO   DATETIME	
	 ,FECHA_VCTO      DATETIME
	 ,VALOR_RAZONABLE FLOAT
	 ,TIPO_OPE_TRAN_1 CHAR(01)		
	 ,TIPO_OPE_TRAN_2 CHAR(01)		
	 ,COD_CARTERA	  VARCHAR(02)			
	 ,OPE_MTM_ACTIVO  FLOAT
	 ,OPE_MTM_PASIVO  FLOAT
	 ,MODALIDAD		  CHAR(01)
	 ,MONPAGOMN       INT
	 ,MONPAGOMX       INT
	 ,CAFECHASTARTING DATETIME
	 ,NOMBRE_CLIENTE  VARCHAR(150)
	 ,STR_MONEDA_1    VARCHAR(03)
	 ,STR_MONEDA_2    VARCHAR(03)
	 ,PAIS            INT
	 ,CARTERA         VARCHAR(50)
	 ,PRODUCTO        VARCHAR(50)
	 ,CNPJ            VARCHAR(20)
	 ,Clopcion        VARCHAR(02)
	 ,RUT_DV          VARCHAR(02))

	 




 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA SWAP                                                */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* CONTABILIDAD DE FORWARD                                                     */
   /*-----------------------------------------------------------------------------*/
     INSERT @OPERACIONES
     SELECT canumoper 
	       ,cacodigo
		   ,cacodcli		   
	       ,cacodpos1						-->TIPO INSTRUMENTO
		   ,cacodmon1 
		   ,cacodmon2 
		   ,camtomon1						--> Nocional 1
		   ,camtomon2						--> Nocional 2
		   ,catipoper 
		   ,cafecha 
		   ,cafecvcto
		   ,fRes_Obtenido
		   ,CASE 
			WHEN catipoper ='V' THEN 'V'
			WHEN catipoper ='C' THEN 'C'
			END  AS TIPO_TRAN_1
		   ,CASE 
		    WHEN catipoper ='V' THEN 'C'
			WHEN catipoper ='C' THEN 'V'
			END AS TIPO_TRAN_1
		   ,CACARTERA_NORMATIVA      		-->codigo cartera
		   ,ValorRazonableActivo			-->MTM Activo
		   ,ValorRazonablePasivo			-->MTM Pasivo
		   ,catipmoda						-->TIPO: E ->ENTREGA FISICA || C->COMPENSACION
		   ,CAFPAGOMN
		   ,CAFPAGOMX
		   ,CAFECHASTARTING
		   , ''
		   , ''
		   , ''
		   , 0
		   , ''
		   , ''
		   , ''
		   , ''
		   , 0
       FROM bacfwdsuda.dbo.mfcares 
	  WHERE cafechaproceso = @FECHA
	    AND cafecvcto      > @FECHA


	 

   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR MONEDAS EN TABLA DE OPERACIONES                                  */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET STR_MONEDA_1  = CASE WHEN MON.mnnemo ='UF' THEN 'CLF' ELSE MON.mnnemo END
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.DBO.MONEDA      MON
		 ON MON.mncodmon         = OPE.COD_MONEDA_1 

     UPDATE OPE
	    SET STR_MONEDA_2  = CASE WHEN MON.mnnemo ='UF' THEN 'CLF' ELSE MON.mnnemo END
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.DBO.MONEDA      MON
		 ON MON.mncodmon         = OPE.COD_MONEDA_2 



		 

   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR NOMBRE CLIENTE Y PAIS                                            */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET NOMBRE_CLIENTE  = CLI.Clnombre
		   ,PAIS            = CLI.CLPAIS  
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
		   ,RUT_DV          = CLDV
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.DBO.CLIENTE      CLI WITH(NOLOCK)
		 ON CLI.Clrut          = OPE.RUT_CLIENTE 
		AND CLI.Clcodigo       = OPE.COD_CLIENTE 


   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR CARTERA EN TABLA DE OPERACIONES                                  */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET CARTERA   = CAR.TBGLOSA 
	   FROM @OPERACIONES OPE
	  INNER JOIN
            bacparamsuda.dbo.TABLA_GENERAL_DETALLE CAR
		 ON CAR.tbcateg   = 1111 
		AND CAR.tbcodigo1 = OPE.COD_CARTERA 


   /*-----------------------------------------------------------------------------*/
   /* PRODUCTO                                                                    */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET PRODUCTO   = PRO.DESCRIPCION
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.dbo.PRODUCTO PRO
		 ON PRO.id_sistema      = 'BFW'
		AND PRO.CODIGO_PRODUCTO = OPE.COD_PRODUCTO 

 Return

 END

GO
