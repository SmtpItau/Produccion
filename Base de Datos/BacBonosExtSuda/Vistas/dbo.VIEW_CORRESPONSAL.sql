USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[VIEW_CORRESPONSAL]    Script Date: 11-05-2022 16:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[VIEW_CORRESPONSAL]
AS
SELECT 	rut_cliente,
	codigo_cliente,
	codigo_moneda,
	codigo_pais,
	codigo_plaza,
	codigo_swift,  
	nombre,
	cuenta_corriente,
	swift_santiago,
	banco_central,
	fecha_vencimiento,
	codigo_corres,
	codigo_contable,
	cod_corresponsal,
	Rut_Corresponsal  

FROM BacParamSuda..CORRESPONSAL
-- SELECT * FROM BacParamSuda..cliente_CORRESPONSAL



GO
