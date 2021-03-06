USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S007_Query_Resultado_C_OPT]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_S007_Query_Resultado_C_OPT]
(
    @FechaDesde        DATETIME,
    @FechaHasta        DATETIME,
    @dFechaProceso     DATETIME
)
AS
BEGIN
	/* sp_opciones */
	SET NOCOUNT ON;
	
	SELECT *
	       INTO #AnuladasyAnticipadas
	FROM   LNKOPC.CbMdbOpc.dbo.MoHisEncContrato
	WHERE  moTipoTransaccion         = 'ANULA'
	       OR  moTipoTransaccion     = 'ANTICIPA'
	       AND MoFechaContrato >= @FechaDesde
	       AND MoFechaContrato <= @FechaHasta
	
	SELECT *
	       INTO #AnuladasyAnticipadasII
	FROM   LNKOPC.CbMdbOpc.dbo.MoEncContrato
	WHERE  moTipoTransaccion         = 'ANULA'
	       OR  moTipoTransaccion     = 'ANTICIPA'
	       AND MoFechaContrato >= @FechaDesde
	       AND MoFechaContrato <= @FechaHasta
	
	
	IF (@FechaDesde = @FechaHasta AND @dFechaProceso = @FechaDesde)
	BEGIN
	    ---opciones diaria
	    
	    SELECT Modulo = 'OPT',
	           Producto              = MoCallPut,
	           Numero_Operacion      = LTRIM(RTRIM(mvto.MoNumContrato)),
	           Documento             = 0,
	           Correlativo           = 0,
	           Serie                 = '',
	           RutCliente            = LTRIM(RTRIM(CONVERT(CHAR(10), clie.Clrut))),
	           CodCliente            = MoCodigo,
	           DvCliente             = LTRIM(RTRIM(clie.Cldv)),
	           NombreCliente         = LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre)))),
	           TipoOperacion         = CASE 
	                                WHEN ctro.MoVinculacion = 'Individual' THEN 
	                                     ctro.MoCVOpc
	                                ELSE ''
	                           END,
	           Monto                 = ctro.MoMontoMon1,
	           MonTransada           = mon1.mnnemo,
	           MonConversion         = mon2.mnnemo,
	           TCCierre              = ctro.MoStrike,
	           TCCosto               = 0.0,
	           ParidadCierre         = 0.0,
	           ParidadCosto          = 0.0,
	           MontoPesos            = ctro.MoMontoMon2,
	           Operador              = mooperador,
	           MontoDolares          = ctro.MoMontoMon1,
	           ResultadoMesa         = ISNULL(mvto.MoResultadoVentasML, 0),
	           Fecha                 = CONVERT(CHAR(8), mvto.MoFechaContrato, 112),
	           Relacionado           = '--',
	           FolioRelacionado      = 0 --mvto.MoNumFolio
	           ,
	           FechaEmision          = CONVERT(CHAR(8), mvto.MoFechaContrato, 112),
	           FechaVencimiento      = CONVERT(CHAR(8), mvto.MoFechaContrato, 112),
	           SegmentoComercial     = clie.Seg_Comercial
	    FROM   LNKOPC.CbMdbOpc.dbo.MoEncContrato mvto
	           INNER JOIN LNKOPC.CbMdbOpc.dbo.MoDetContrato ctro
	                ON  ctro.MoNumFolio = mvto.MoNumFolio
	                AND ctro.MoNumEstructura = 1
	           INNER JOIN BacParamSuda.dbo.CLIENTE clie
	                ON  clie.clrut = mvto.MoRutCliente
	                AND clie.clcodigo = mvto.MoCodigo
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mon1
	                ON  mon1.mncodmon = ctro.MoCodMon1
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mon2
	                ON  mon2.mncodmon = ctro.MoCodMon2
	    WHERE  mvto.MoFechaContrato BETWEEN @FechaDesde AND @FechaHasta
	           AND mvto.MoResultadoVentasML <> 0
	           AND mvto.MoNumContrato NOT IN (SELECT MoNumcontrato
	                                          FROM   #AnuladasyAnticipadasII)
	           AND mvto.MoEstado <> 'C'
	END
	ELSE
	BEGIN
	    /* opciones historico */
	    SELECT Modulo = 'OPT',
	           Producto              = MoCallPut,
	           Numero_Operacion      = LTRIM(RTRIM(mvto.MoNumContrato)),
	           Documento             = 0,
	           Correlativo           = 0,
	           Serie                 = '',
	           RutCliente            = LTRIM(RTRIM(CONVERT(CHAR(10), clie.Clrut))),
	           CodCliente            = MoCodigo,
	           DvCliente             = LTRIM(RTRIM(clie.Cldv)),
	           NombreCliente         = LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre)))),
	           TipoOperacion         = CASE 
	                                WHEN ctro.MoVinculacion = 'Individual' THEN 
	                                     ctro.MoCVOpc
	                                ELSE ''
	                           END,
	           Monto                 = ctro.MoMontoMon1,
	           MonTransada           = mon1.mnnemo,
	           MonConversion         = mon2.mnnemo,
	           TCCierre              = ctro.MoStrike,
	           TCCosto               = 0.0,
	           ParidadCierre         = 0.0,
	           ParidadCosto          = 0.0,
	           MontoPesos            = ctro.MoMontoMon2,
	           Operador              = mooperador,
	           MontoDolares          = ctro.MoMontoMon1,
	           ResultadoMesa         = ISNULL(mvto.MoResultadoVentasML, 0),
	           Fecha                 = CONVERT(CHAR(8), mvto.MoFechaContrato, 112),
	           Relacionado           = '--',
	           FolioRelacionado      = 0 --mvto.MoNumFolio
	           ,
	           FechaEmision          = CONVERT(CHAR(8), mvto.MoFechaContrato, 112),
	           FechaVencimiento      = CONVERT(CHAR(8), mvto.MoFechaContrato, 112),
	           SegmentoComercial     = clie.Seg_Comercial
	    FROM   LNKOPC.CbMdbOpc.dbo.MoHisEncContrato mvto
	           INNER JOIN BacParamSuda.dbo.CLIENTE clie
	                ON  clie.clrut = mvto.MoRutCliente
	                AND clie.clcodigo = mvto.MoCodigo
	           INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato ctro
	                ON  mvto.MoNumFolio = ctro.MoNumFolio
	                AND ctro.MoNumEstructura = 1
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mon1
	                ON  mon1.mncodmon = ctro.MoCodMon1
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mon2
	                ON  mon2.mncodmon = ctro.MoCodMon2
	    WHERE  mvto.MoFechaContrato BETWEEN @FechaDesde AND @FechaHasta
	           AND mvto.MoResultadoVentasML <> 0
	           AND mvto.MoNumContrato NOT IN (SELECT MoNumcontrato
	                                          FROM   #AnuladasyAnticipadas)
	           AND mvto.moestado <> 'C';
	END;
	
	SET NOCOUNT OFF;
END;
GO
