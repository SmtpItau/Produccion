USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[FUSION_SP_EliminaReg_Contrato_CondicionesGenerales]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FUSION_SP_EliminaReg_Contrato_CondicionesGenerales]
AS
BEGIN

	DELETE FROM FUSION_Contrato_CondicionesGenerales 

END

GO
