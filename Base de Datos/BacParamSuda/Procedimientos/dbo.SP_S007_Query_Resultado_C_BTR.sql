USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S007_Query_Resultado_C_BTR]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_S007_Query_Resultado_C_BTR]
(
    @FechaDesde        DATETIME,
    @FechaHasta        DATETIME,
    @dFechaProceso     DATETIME,
    @Tipo_Cambio       DECIMAL
)
AS
BEGIN
	SET NOCOUNT ON;
	IF (@FechaDesde = @FechaHasta AND @dFechaProceso = @FechaDesde)
	BEGIN
	    ---Consulta Diaria
	    
	    SELECT Modulo = 'BTR',
	           Producto               = CASE 
	                           WHEN mvto.motipoper = 'CP' THEN 'COMPRA PROPIA'
	                           WHEN mvto.motipoper = 'CI' THEN 'COMPRA C/ PACTO'
	                           WHEN mvto.motipoper = 'VP' THEN 'VENTA PROPIA'
	                           WHEN mvto.motipoper = 'VI' THEN 'VENTA C/ PACTO'
	                           WHEN mvto.motipoper = 'IB' THEN 'INTERBANCARIO'
	                      END,
	           Numero_Operacion       = mvto.monumoper,
	           Numero_Documento       = mvto.monumdocu,
	           Numero_Correlativo     = mvto.mocorrela,
	           Serie                  = mvto.moinstser,
	           RutCliente             = clie.clrut,
	           CodCliente             = clie.clcodigo,
	           DvCliente              = clie.cldv,
	           NombreCliente          = clie.clnombre,
	           TipoOperacion          = CASE 
	                                WHEN mvto.motipoper = 'CP' THEN 'C'
	                                WHEN mvto.motipoper = 'CI' THEN 'C'
	                                WHEN mvto.motipoper = 'VP' THEN 'V'
	                                WHEN mvto.motipoper = 'VI' THEN 'V'
	                                WHEN mvto.motipoper = 'IB' THEN mvto.moinstser
	                           END,
	           Monto                  = mvto.movpresen,
	           MonTransada            = mone.mnnemo,
	           MonConversion          = mone.mnnemo,
	           TCCierre               = mvto.motir,
	           TCCosto                = mvto.moTirTran,
	           ParidadCierre          = 0.0,
	           ParidadCosto           = 0.0,
	           MontoPesos             = CASE 
	                             WHEN mvto.motipoper IN ('VI', 'VP') THEN mvto.movalven
	                             ELSE mvto.movpresen
	                        END,
	           Operador               = mvto.mousuario,
	           MontoDolares           = (
	               CASE 
	                    WHEN mvto.motipoper IN ('VI', 'VP') THEN mvto.movalven
	                    ELSE mvto.movpresen
	               END
	           ) / @Tipo_Cambio,
	           ResultadoMesa          = mvto.moDifTran_CLP,
	           Fecha                  = mvto.mofecpro --> CONVERT(CHAR(10), mvto.mofecpro, 103)
	           ,
	           Relacionado            = '--',
	           FolioRelacionado       = 0,
	           FechaEmision           = mofecemi,
	           FechaVencimiento       = mofecven,
	           SegmentoComercial      = clie.Seg_Comercial
	    FROM   BacTraderSuda.dbo.MDMO mvto
	           INNER JOIN BacParamSuda.dbo.CLIENTE clie
	                ON  clie.clrut = mvto.morutcli
	                AND clie.clcodigo = mvto.mocodcli
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mone
	                ON  mone.mncodmon = mvto.momonemi
	    WHERE  mvto.motipoper      IN ('CP', 'CI', 'VP', 'VI', 'IB')
	           AND mvto.mostatreg <> 'A'
	           AND mvto.mofecpro BETWEEN @FechaDesde AND @Fechahasta
	    ORDER BY
	           mvto.monumoper,
	           mvto.monumdocu,
	           mvto.mocorrela
	END
	ELSE
	BEGIN
	    SELECT Modulo = 'BTR',
	           Producto               = CASE 
	                           WHEN mvto.motipoper = 'CP' THEN 'COMPRA PROPIA'
	                           WHEN mvto.motipoper = 'CI' THEN 'COMPRA C/ PACTO'
	                           WHEN mvto.motipoper = 'VP' THEN 'VENTA PROPIA'
	                           WHEN mvto.motipoper = 'VI' THEN 'VENTA C/ PACTO'
	                           WHEN mvto.motipoper = 'IB' THEN 'INTERBANCARIO'
	                      END,
	           Numero_Operacion       = mvto.monumoper,
	           Numero_Documento       = mvto.monumdocu,
	           Numero_Correlativo     = mvto.mocorrela,
	           Serie                  = mvto.moinstser,
	           RutCliente             = clie.clrut,
	           CodCliente             = clie.clcodigo,
	           DvCliente              = clie.cldv,
	           NombreCliente          = clie.clnombre,
	           TipoOperacion          = CASE 
	                                WHEN mvto.motipoper = 'CP' THEN 'C'
	                                WHEN mvto.motipoper = 'CI' THEN 'C'
	                                WHEN mvto.motipoper = 'VP' THEN 'V'
	                                WHEN mvto.motipoper = 'VI' THEN 'V'
	                                WHEN mvto.motipoper = 'IB' THEN mvto.moinstser
	                           END,
	           Monto                  = mvto.movpresen,
	           MonTransada            = mone.mnnemo,
	           MonConversion          = mone.mnnemo,
	           TCCierre               = mvto.motir,
	           TCCosto                = mvto.moTirTran,
	           ParidadCierre          = 0.0,
	           ParidadCosto           = 0.0,
	           MontoPesos             = CASE 
	                             WHEN mvto.motipoper IN ('VI', 'VP') THEN mvto.movalven
	                             ELSE mvto.movpresen
	                        END,
	           Operador               = mvto.mousuario,
	           MontoDolares           = (
	               CASE 
	                    WHEN mvto.motipoper IN ('VI', 'VP') THEN mvto.movalven
	                    ELSE mvto.movpresen
	               END
	           ) / @Tipo_Cambio,
	           ResultadoMesa          = mvto.moDifTran_CLP,
	           Fecha                  = mvto.mofecpro --> CONVERT(CHAR(10), mvto.mofecpro, 103)
	           ,
	           Relacionado            = '--',
	           FolioRelacionado       = 0,
	           FechaEmision           = mofecemi,
	           FechaVencimiento       = mofecven,
	           SegmentoComercial      = clie.seg_comercial
	    FROM   BacTraderSuda.dbo.MDMH mvto
	           INNER JOIN BacParamSuda.dbo.CLIENTE clie
	                ON  clie.clrut = mvto.morutcli
	                AND clie.clcodigo = mvto.mocodcli
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mone
	                ON  mone.mncodmon = mvto.momonemi
	    WHERE  mvto.motipoper      IN ('CP', 'CI', 'VP', 'VI', 'IB')
	           AND mvto.mostatreg <> 'A'
	           AND mvto.mofecpro BETWEEN @FechaDesde AND @Fechahasta
	    ORDER BY
	           mvto.monumoper,
	           mvto.monumdocu,
	           mvto.mocorrela
	END;
	
	SET NOCOUNT OFF;
END;
GO
