USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S007_Query_Resultado_C_SPOT]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_S007_Query_Resultado_C_SPOT]
(
    @FechaDesde        DATETIME,
    @FechaHasta        DATETIME,
    @dFechaProceso     DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@FechaDesde = @FechaHasta AND @dFechaProceso = @FechaDesde)
	BEGIN
	    ---spot diario
	    SELECT Modulo = 'BCC',
	           Producto               = mvto.motipmer,
	           Numero_Operacion       = mvto.monumope,
	           Numero_Documento       = 0,
	           Numero_Correlativo     = 0,
	           Serie                  = '',
	           RutCliente             = clie.clrut,
	           CodCliente             = clie.clcodigo,
	           DvCliente              = clie.cldv,
	           NombreCliente          = clie.clnombre,
	           TipoOperacion          = mvto.motipope,
	           Monto                  = mvto.momonmo,
	           MonTransada            = mvto.mocodmon,
	           MonConversion          = mvto.mocodcnv,
	           TCCierre               = mvto.moticam,
	           TCCosto                = CASE 
	                          WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon =
	                               'USD' THEN mvto.CMX_TC_Costo_Trad
	                          WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon <>
	                               'USD' THEN mvto.motctra
	                          ELSE mvto.motctra
	                     END,
	           ParidadCierre = mvto.moparme,
	           ParidadCosto = CASE 
	                               WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon
	                                    = 'USD' THEN mvto.mopartr
	                               WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon
	                                    <> 'USD' THEN mvto.CMX_TC_Costo_Trad
	                               ELSE mvto.mopartr
	                          END,
	           MontoPesos = mvto.momonpe,
	           Operador = mvto.mooper,
	           MontoDolares = mvto.moussme,
	           ResultadoMesa = CASE 
	                                WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp
	                                ELSE mvto.moDifTran_Clp
	                           END,
	           Fecha = mvto.mofech --> CONVERT(CHAR(10), mvto.mofech, 103)
	           ,
	           Relacionado = CASE 
	                              WHEN mvto.monumfut > 0 AND mvto.moterm =
	                                   'SWAP SPOT' THEN 'Swap Spot'
	                              WHEN mvto.monumfut > 0 AND mvto.moterm =
	                                   'EMPRESAS' AND morutcli = 96665450 THEN 
	                                   'Neteo'
	                              ELSE 'Sin Relación'
	                         END,
	           FolioRelacionado = CASE 
	                                   WHEN mvto.monumfut > 0 AND mvto.moterm =
	                                        'SWAP SPOT' THEN mvto.monumfut
	                                   WHEN mvto.monumfut > 0 AND mvto.moterm =
	                                        'EMPRESAS' AND mvto.morutcli =
	                                        96665450 THEN mvto.monumfut
	                                   ELSE 0
	                              END,
	           FechaEmision = mvto.mofech,
	           FechaVencimiento = mvto.mofech,
	           SegmentoComercial = clie.Seg_Comercial
	    FROM   BacCamSuda.dbo.MEMO mvto
	           INNER JOIN BacParamSuda.dbo.CLIENTE clie
	                ON  clie.clrut = mvto.morutcli
	                AND clie.clcodigo = mvto.mocodcli
	    WHERE  mvto.moestatus <> 'A'
	           AND mvto.moterm <> 'FORWARD'
	           AND mvto.moterm <> 'SWAP'
	           AND mvto.moterm <> 'OPCIONES'
	           AND mvto.mofech BETWEEN @FechaDesde AND @Fechahasta
	           AND mvto.moterm NOT IN ('DATATEC', 'BOLSA')
	END
	ELSE
	BEGIN
	    ---- spot historico
	    SELECT Modulo = 'BCC',
	           Producto               = mvto.motipmer,
	           Numero_Operacion       = mvto.monumope,
	           Numero_Documento       = 0,
	           Numero_Correlativo     = 0,
	           Serie                  = '',
	           RutCliente             = clie.clrut,
	           CodCliente             = clie.clcodigo,
	           DvCliente              = clie.cldv,
	           NombreCliente          = clie.clnombre,
	           TipoOperacion          = mvto.motipope,
	           Monto                  = mvto.momonmo,
	           MonTransada            = mvto.mocodmon,
	           MonConversion          = mvto.mocodcnv,
	           TCCierre               = mvto.moticam,
	           TCCosto                = CASE 
	                          WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon =
	                               'USD' THEN mvto.CMX_TC_Costo_Trad
	                          WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon <>
	                               'USD' THEN mvto.motctra
	                          ELSE mvto.motctra
	                     END,
	           ParidadCierre = mvto.moparme,
	           ParidadCosto = CASE 
	                               WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon
	                                    = 'USD' THEN mvto.mopartr
	                               WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon
	                                    <> 'USD' THEN mvto.CMX_TC_Costo_Trad
	                               ELSE mvto.mopartr
	                          END,
	           MontoPesos = mvto.momonpe,
	           Operador = mvto.mooper,
	           MontoDolares = mvto.moussme,
	           ResultadoMesa = CASE 
	                                WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp
	                                ELSE mvto.moDifTran_Clp
	                           END,
	           Fecha = mvto.mofech --> CONVERT(CHAR(10), mvto.mofech, 103)
	           ,
	           Relacionado = CASE 
	                              WHEN mvto.monumfut > 0 AND mvto.moterm =
	                                   'SWAP SPOT' THEN 'Swap Spot'
	                              WHEN mvto.monumfut > 0 AND mvto.moterm =
	                                   'EMPRESAS' AND morutcli = 96665450 THEN 
	                                   'Neteo'
	                              ELSE 'Sin Relación'
	                         END,
	           FolioRelacionado = CASE 
	                                   WHEN mvto.monumfut > 0 AND mvto.moterm =
	                                        'SWAP SPOT' THEN mvto.monumfut
	                                   WHEN mvto.monumfut > 0 AND mvto.moterm =
	                                        'EMPRESAS' AND mvto.morutcli =
	                                        96665450 THEN mvto.monumfut
	                                   ELSE 0
	                              END,
	           FechaEmision = mvto.mofech,
	           FechaVencimiento = mvto.mofech,
	           SegmentoComercial = clie.Seg_Comercial
	    FROM   BacCamSuda.dbo.MEMOH mvto
	           INNER JOIN BacParamSuda.dbo.CLIENTE clie
	                ON  clie.clrut = mvto.morutcli
	                AND clie.clcodigo = mvto.mocodcli
	    WHERE  mvto.moestatus <> 'A'
	           AND mvto.moterm <> 'FORWARD'
	           AND mvto.moterm <> 'SWAP'
	           AND mvto.moterm <> 'OPCIONES'
	           AND mvto.mofech BETWEEN @FechaDesde AND @Fechahasta
	           AND mvto.moterm NOT IN ('DATATEC', 'BOLSA')
	END;
	
	SET NOCOUNT OFF;
END;
GO
