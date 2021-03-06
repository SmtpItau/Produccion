USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_CLAVE_DCV]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_CLAVE_DCV]	(	@Clave	CHAR(10)	= ''	)
AS
BEGIN 
	SET NOCOUNT ON

	DECLARE	@Fecha_Proceso	DATETIME
	,	@Existe_Clave	CHAR(10)
	
	SELECT	@Fecha_Proceso = acfecproc
	FROM	MDAC

	SELECT	@Existe_Clave = ''

	SELECT	DISTINCT @Existe_Clave	= ISNULL('EXISTE','') 
	FROM	MDMO
	WHERE	mofecpro	= @Fecha_Proceso
	AND	modcv		= 'D'
	AND	moclave_dcv	= @Clave

	IF @Existe_Clave = '' Begin
		SELECT	DISTINCT @Existe_Clave	= ISNULL('EXISTE','') 
		FROM	MDMOPM
		WHERE	mofecpro	= @Fecha_Proceso
		AND	modcv		= 'D'
		AND	moclave_dcv	= @Clave			
	END				
				
	SELECT	@Existe_Clave

	SET NOCOUNT OFF
END

GO
