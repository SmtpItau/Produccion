USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_OMADELSUDA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_OMADELSUDA]( 
					 @codigo	NUMERIC(2) 
					,@glosa		CHAR(40) 
					,@tipope	CHAR(1)  
					,@codoma	NUMERIC(2) 
					,@comercio	CHAR(6)
					)
AS
BEGIN
	SET NOCOUNT ON
	DELETE tbomadelsuda WHERE codi_opera = @codigo
	INSERT INTO tbomadelsuda(codi_opera 
				,conc_opera
				,op_concep
				,codi_oma
				,comercio
				)
	VALUES	(@codigo
		,@glosa
		,@tipope
		,@codoma
		,@comercio
		)
	SET NOCOUNT OFF
END
GO
