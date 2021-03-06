USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_LOG]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_LOG](@xSistema  CHAR(3)  ,  
				@xUsuario		CHAR(10)	,
				@xFechaProc		DATETIME	,
				@xEvento		CHAR(255)	)
 AS
 BEGIN

 INSERT INTO BACPARAMDRESDNER..Gen_Log 	(	LogSistema		,
						LogUser			,
						LogFecha		,
						LogFechaApp		,
						LogHora			,
						LogEvento		)
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
