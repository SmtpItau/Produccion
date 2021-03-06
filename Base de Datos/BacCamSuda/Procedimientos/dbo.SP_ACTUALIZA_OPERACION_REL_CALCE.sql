USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_OPERACION_REL_CALCE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_ACTUALIZA_OPERACION_REL_CALCE]
(
	@nOperacion_a_Relacionar 	float,
	@nNewOpecion			    float
)
AS
BEGIN
	UPDATE MEMO 
	   SET monumfut     = @nNewOpecion,
	       Observacion  = 'OperaciÃ³n corredora relacionada a la operaciÃ³n Nro. #' + str(@nNewOpecion)
	 where MONUMOPE = @nOperacion_a_Relacionar 
	   and moterm   = 'CORREDORA'
	   and MOTIPMER = 'CCBB'
END



GO
