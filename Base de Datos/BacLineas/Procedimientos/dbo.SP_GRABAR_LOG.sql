USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_LOG]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_LOG]
			(	@xsistema		char(3)		,
				@xusuario		char(10)	,
				@xfechaproc		datetime	,
				@xevento		char(255)	)
AS
BEGIN 
	SET NOCOUNT ON
--BEGIN TRANSACTION

INSERT INTO VIEW_LOG_USUARIO 	(	logsistema		,
					loguser			,
					logfecha		,
					logfechaapp		,
					loghora			,
					logevento)

				VALUES	(@xsistema		,
					 @xusuario		,
					 convert(char(10),getdate(),112),
					 @xfechaproc		,
					 convert(char(10),getdate(),108),
					 @xevento)


   IF @@ERROR <> 0 
      BEGIN
      --ROLLBACK TRANSACTION
       SELECT 'NO'          -- SI OCURRE ALGUN ERROR NO GRABA
      SET NOCOUNT OFF
      RETURN	
   END
   --COMMIT TRANSACTION   -- SI GRABA 
   SELECT 'SI'
   SET NOCOUNT OFF
END
GO
