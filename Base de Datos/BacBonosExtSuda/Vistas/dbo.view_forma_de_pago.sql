USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[view_forma_de_pago]    Script Date: 11-05-2022 16:32:48 ******/
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
	FROM 	BACPARAMsuda..forma_de_pago





GO
