USE [BacCamSuda]
GO
/****** Object:  View [dbo].[VIEW_CORRESPONSAL]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[VIEW_CORRESPONSAL]
AS
SELECT 
     rut_cliente
    ,codigo_cliente
    ,codigo_moneda
    ,codigo_pais
    ,codigo_plaza
    ,codigo_swift
    ,nombre
    ,cuenta_corriente
    ,swift_santiago
    ,banco_central
    ,fecha_vencimiento
    ,codigo_corres
    ,cod_corresponsal 
    ,rut_corresponsal
FROM bacparamsuda..CORRESPONSAL


--  sp_autoriza_ejecutar_vista 'bacuser'
-- update view_corresponsal set codigo_swift = 'PNBPUS3NNYC' WHERE CODIGO_SWIFT = 'PNBPUS3NNY'

--SELECT * FROM View_corresponsal WHERE CODIGO_SWIFT = 'PNBPUS3NNY'

GO
