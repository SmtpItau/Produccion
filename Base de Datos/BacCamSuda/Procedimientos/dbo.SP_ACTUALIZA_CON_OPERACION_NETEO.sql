USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_CON_OPERACION_NETEO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_ACTUALIZA_CON_OPERACION_NETEO]
(
	@nOperacion 	float = 0,
	@nOperacionCDB	float = 0
)
AS
BEGIN
	if @nOperacionCDB = 0
		return

	UPDATE MEMO 
	   SET monumfut = @nOperacionCDB
	 where MONUMOPE = @nOperacion

END




GO
