USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Cuenta_Contable]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Busca_Cuenta_Contable]
		(
		@cuenta  CHAR(16)
		)
AS BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON

SELECT Descripcion  FROM PLAN_DE_CUENTA WHERE cuenta = @cuenta
END
GO
