USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_forma_de_pago]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE VIEW [dbo].[view_forma_de_pago]
AS 
	SELECT 	Codigo,
		Glosa,
		Perfil,
		Codgen,
		Glosa2,
		Cc2756,
		Afectacorr,
		Diasvalor,
		Numcheque,
		Ctacte
	FROM 	bacparamsuda..forma_de_pago





GO
