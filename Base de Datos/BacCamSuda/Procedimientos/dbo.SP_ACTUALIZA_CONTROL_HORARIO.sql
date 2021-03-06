USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_CONTROL_HORARIO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_CONTROL_HORARIO]
	(	@HoraApertura	CHAR(10)
	,	@HoraCierre		CHAR(10)
	,	@Bloqueado		INT
	)
AS
BEGIN

	SET NOCOUNT ON

	DELETE FROM BacParamSuda.dbo.TBL_CONTROL_HORARIO_COMEX

	INSERT INTO BacParamSuda.dbo.TBL_CONTROL_HORARIO_COMEX
		(	Hora_Apertura
		,	Hora_Cierre
		,	Bloqueado
		)
	VALUES 
		(	@HoraApertura
		,	@HoraCierre
		,	@Bloqueado
		)

END

GO
