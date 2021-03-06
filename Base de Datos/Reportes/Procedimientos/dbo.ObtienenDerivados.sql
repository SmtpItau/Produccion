USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[ObtienenDerivados]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtienenDerivados]
AS
BEGIN

	SELECT id_sistema AS id,nombre_sistema AS nombre FROM [BacParamSuda].[dbo].[SISTEMA_CNT] WHERE operativo = 'S' AND id_Sistema NOT IN('BNY','PCA','TUR','SCF', 'SNY', 'BEX','BCC','BONOS' )
	UNION
	SELECT 'BFWAS' , 'FORWARD ASIÁTICO'
	UNION
	SELECT 'BTREX' , 'RENTA FIJA EXTERIOR'
    UNION
	SELECT 'PASIVOS' , 'PASIVOS'
	UNION
	SELECT 'PACTOS' , 'PACTOS'

END



GO
