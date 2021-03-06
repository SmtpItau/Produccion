USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[CarteraArticulo84Opciones]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[CarteraArticulo84Opciones](@RUT_CLIENTE    NUMERIC (10,0))




  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns @OPCIONES TABLE
	 (FECHA_PROCESO          DATETIME
	 ,NUMERO_OPERACION       NUMERIC(21,0)
	 ,RUT_CLIENTE            NUMERIC(10,0)
	 ,COD_CLIENTE            INT
	 ,NOCIONAL               NUMERIC(24,6)
	 ,MONEDA_NOCIONAL        INT
	 ,FECHA_CIERRE           DATETIME
	 ,FECHA_INICIO           DATETIME
	 ,PRODUCTO               VARCHAR(15)
	 ,VALOR_RAZONABLE        NUMERIC(24,6)
	 ,MONEDA_VALOR_RAZONABLE INT
	 ,FECHA_TERMINO          DATETIME
	 ,PLAZO                  INT
	 ,VINCULACION            VARCHAR(30)
	 ,TIPOPAYOFF             VARCHAR(15)
	 ,CODIGO_ESTRUCTURA      VARCHAR(15)
	 ,SISTEMA_ASOCIADO       VARCHAR(30)
	 ,CONTRATO_ASOCIADO      NUMERIC(21,0)
	 ,FACTOR_ARTICULO_84     FLOAT
	 ,ADDON_ARTICULO_84      FLOAT
     ,VALOR_MONEDA           FLOAT
     ,VALOR_MONEDA_VR        FLOAT
     ,NOCIONAL_CLP           FLOAT
	 ,Sum_AVR_Positivo       FLOAT 
	 ,Max_Sum_AVR_Cero       FLOAT
	 ,Equiv_Credito          FLOAT)



 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA OPCIONES                                            */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 13/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/

   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE  @fecproOPT           DATETIME
		  ,   @fecproOPTContable   DATETIME  



	  SELECT @fecproOPT          = fechaproc 
	        ,@fecproOPTContable  = fechaant
    	FROM LnkOpc.CbMdbOpc.dbo.OpcionesGeneral


   /*-----------------------------------------------------------------------------*/
   /* TABLA DE MONEDAS                                                            */
   /*-----------------------------------------------------------------------------*/
    DECLARE @TMP_VALOR_MONEDA_ART84_DERIVADOS TABLE
	(vmfecha    DATETIME
	,vmcodigo   INT
	,vmvalor    NUMERIC (18,8))



   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE CALCULO DE MONEDAS                                               */
   /*-----------------------------------------------------------------------------*/
	 INSERT INTO @TMP_VALOR_MONEDA_ART84_DERIVADOS
     SELECT * FROM BACPARAMSUDA.dbo.ValorMonedaFecContable(@fecproOPTContable)


     DECLARE @POND_ASIATICA TABLE
	 (NRO_CONTRATO  NUMERIC(10,0)
	 ,PONDERACION   FLOAT )


   /*-----------------------------------------------------------------------------*/
   /* CARTERA DE OPCIONES                                                         */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @OPCIONES
   	 SELECT  @fecproOPT                             AS FECHA_PROCESO
     	,	 A.CaNumContrato                        AS NUMERO_OPERACION
        ,	 A.CaRutCliente                         AS RUT_CLIENTE
        , 	 A.CaCodigo                             AS CODIGO_CLIENTE
        , 	 MAX(B.CaMontoMon1)                     AS NOCIONAL
	    ,	 B.CaCodMon1                            AS MONEDA_NOCIONAL
        , 	 A.CaFechaContrato                      AS FECHA_CIERRE
		,    A.CaFechaContrato                      AS FECHA_INICIO
        , 	 CONVERT(CHAR(05),B.CaSubyacente)       AS PRODUCTO
        , 	 ISNULL(CONVERT(FLOAT,A.CaVr),0.0)      AS VALOR_RAZONABLE
        , 	 A.CaMon_vr                             AS MONEDA_VALOR_RAZONABLE
        , 	 B.CaFechaVcto                          AS FECHA_TERMINO
	    ,	 DATEDIFF(dd,@fecproOPT,B.CaFechaVcto)  AS PLAZO
        , 	 B.CaVinculacion                        AS VINCULACION
        , 	 B.CaTipoPayOff                         AS TIPOPAYOFF
        , 	 A.CaCodEstructura                      AS CODIGO_ESTRUCTURA
        , 	 B.CaIteAsoSis                          AS SISTEMA_ASOCIACION
        , 	 B.CaIteAsoCon                          AS CONTRATO_ASOCIADO
	    ,	 CONVERT(FLOAT,0.0)                     AS FACTOR_ARTICULO_84
	    ,	 CONVERT(FLOAT,0.0)                     AS ADDON_ARTICULO_84
        ,    COnvert(FLOAT,0.0)                     AS VALOR_MONEDA
        ,    Convert(FLOAT,0.0)                     AS VALOR_MONEDA_VR
        ,    convert(FLOAT,0.0)                     AS NOCIONAL_CLP
	    ,    convert(FLOAT,0.0)                     AS Sum_AVR_Positivo        
	    ,    convert(FLOAT,0.0)                     AS Max_Sum_AVR_Cero       
	    ,    convert(FLOAT,0.0)                     AS Equiv_Credito
      FROM
		    LnkOpc.CbMdbOpc.dbo.CaEncContrato  A
        ,	LnkOpc.CbMdbOpc.dbo.CaDetContrato  B
   	 WHERE	A.CaRutCliente  = @RUT_CLIENTE
	   AND 	A.CaNumContrato = B.CaNumContrato 
	   AND	A.CaEstado      <> 'C' -- Descarte Cotizaciones
	   AND	B.CaFechaVcto > @fecproOPT
	   AND	(
			A.CaCodEstructura = 2 	-- Collar
		OR
			A.CaCodEstructura = 4	-- Forward utilidad acotada
		OR
			A.CaCodEstructura = 5 	-- Forward perdida acotada
		OR	
			A.CaCodEstructura = 6 	-- Forward sintético
		OR	
			A.CaCodEstructura = 8 	-- Forward Americano
		OR
			A.CaCodEstructura = 13	-- Forward Asiático Entrada Salida
		OR
			(
				A.CaCVEstructura = 'C'	-- Opciones que tienen REC solo si estan compradas
			AND	(
					A.CaCodEstructura = 0	-- Vanillas
				OR
					A.CaCodEstructura = 1	-- Straddle
				OR
					A.CaCodEstructura = 7	-- Strangle
				)
			)
		OR	
			(
				A.CaCVEstructura = 'V'	-- Butterfly vendida tiene REC
			AND	A.CaCodEstructura = 3
			)
		)
	GROUP BY
		A.CaNumContrato
	,	A.CaRutCliente
	,	A.CaCodigo 
	,	B.CaCodMon1
	,	A.CaFechaContrato
	,	B.CaSubyacente
	,	A.CaVr
	,	A.CaMon_vr
	,	B.CaFechaVcto   
	,	B.CaSubyacente
    ,	B.CaVinculacion
    ,	B.CaTipoPayOff
    ,	A.CaCodEstructura 
    ,	B.CaIteAsoSis
    ,	B.CaIteAsoCon

   /*-----------------------------------------------------------------------------*/
   /* OPCIONES NO ASIATICAS                                                       */
   /*-----------------------------------------------------------------------------*/
  	  UPDATE @OPCIONES
	     SET FACTOR_ARTICULO_84 = 
		     CASE
			 WHEN Plazo <= 365  THEN 0.015
			 WHEN Plazo <= 1825 THEN 0.07
			 ELSE 0.13
			 END
	   WHERE TipoPayOff = '01'

   /*-----------------------------------------------------------------------------*/
   /* OPCIONES ASIATICAS                                                          */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @POND_ASIATICA
     SELECT POND.NRO_CONTRATO           AS NRO_CONTRATO
	       ,SUM(POND.FACTOR_PONDERADOR) AS PONDERACION
	   FROM
   	    (SELECT ASIA.NRO_CONTRATO       AS NRO_CONTRATO
	           ,ASIA.PESOFIJ /100 *
		        CASE
			    WHEN Plazo <= 365  THEN 0.015
			    WHEN Plazo <= 1825 THEN 0.07
			    ELSE 0.13
			    END                      AS FACTOR_PONDERADOR
	       FROM (SELECT A.CaNumContrato  AS NRO_CONTRATO
	                   ,C.CaFixFecha     AS FECHA
				       ,CaPesoFij        AS PESOFIJ
	                   ,DATEDIFF(dd,@fecproOPT,C.CaFixFecha) AS PLAZO
     	           FROM LnkOpc.CbMdbOpc.dbo.CaEncContrato  A
                      , LnkOpc.CbMdbOpc.dbo.CaDetContrato  B
	                  , LnkOpc.CbMdbOpc.dbo.CaFixing       C
   	             WHERE  A.CaRutCliente    = @RUT_CLIENTE
			       AND  A.CaNumContrato   = B.CaNumContrato
	               AND  B.CaNumContrato   = C.CaNumContrato
	               AND  B.CaNumEstructura = C.CaNumEstructura
	               AND  A.CaEstado       <> 'C' -- Descarte Cotizaciones
	               AND  B.CaCVOpc         = 'C') AS ASIA
	    ) AS POND
	GROUP BY POND.NRO_CONTRATO



   /*-----------------------------------------------------------------------------*/
   /* OPCIONES ASIATICAS                                                          */
   /*-----------------------------------------------------------------------------*/
	UPDATE @OPCIONES
	   SET FACTOR_ARTICULO_84 = ASI.PONDERACION
	  FROM @POND_ASIATICA       ASI
	 WHERE TipoPayOff         ='02'
	   AND NUMERO_OPERACION   = ASI.NRO_CONTRATO

   /*-----------------------------------------------------------------------------*/
   /* CALCULO DE ADDON                                                            */
   /*-----------------------------------------------------------------------------*/
     UPDATE @OPCIONES
	    SET ADDON_ARTICULO_84 = Round(FACTOR_ARTICULO_84 * Nocional * MON.vmvalor,0)
          , Valor_moneda = MON.vmvalor   
          , Nocional_CLP = round(Nocional * MON.vmvalor,0)
	   FROM
		    @TMP_VALOR_MONEDA_ART84_DERIVADOS MON
	  WHERE	MON.vmcodigo = Moneda_Nocional

   /*-----------------------------------------------------------------------------*/
   /* VALOR RAZONABLE                                                             */
   /*-----------------------------------------------------------------------------*/
	 UPDATE @OPCIONES
	    SET Valor_Razonable = round( Valor_Razonable * MON.vmvalor,0)
          , Valor_moneda_VR = MON.vmvalor  
	   FROM @TMP_VALOR_MONEDA_ART84_DERIVADOS MON
	  WHERE MON.vmcodigo = 999

   /*-----------------------------------------------------------------------------*/
   /* EQUIVALENTE DE CREDITP                                                      */
   /*-----------------------------------------------------------------------------*/
	 UPDATE @OPCIONES
        SET Sum_AVR_Positivo = VALOR_RAZONABLE
          , Max_Sum_AVR_Cero = VALOR_RAZONABLE
		  , Equiv_Credito    = ADDON_ARTICULO_84 + case when VALOR_RAZONABLE > 0 then VALOR_RAZONABLE else 0 end
	   FROM @TMP_VALOR_MONEDA_ART84_DERIVADOS MON



 Return

 END


GO
