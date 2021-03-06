USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Grabar_Log]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Sp_Grabar_Log](	@xSistema		CHAR(3)		,
				@xUsuario		CHAR(15)	,
				@xFechaProc		DATETIME	,
				@xEvento		CHAR(255)	)
AS
BEGIN




   	SET DATEFORMAT DMY
	SET NOCOUNT ON

INSERT INTO LOG_USUARIO 	(	logsistema		,
						loguser			,
						logfecha		,
						logfechaapp		,
						loghora			,
						logevento		)
				VALUES	(	@xSistema		,
						@xUsuario		,
						convert(char(10),getdate(),112),
						@xFechaProc		,
						convert(CHAR(10),getdate(),108),
						@xEvento		)

IF @@error <> 0 BEGIN
   SELECT 'NO'
END

SELECT 'SI'
END




GO
