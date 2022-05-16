USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_MODIFICACION_MXCLP]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CONTROL_MODIFICACION_MXCLP]
	(	@nContrato	NUMERIC(9)	)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @iFound		INT
		SET @iFound		= -1
	SELECT	@iFound		= 0
	FROM	BacFwdSuda.dbo.MFCA
	WHERE	canumoper	= @nContrato 
	AND		var_moneda2 > 0
	
	IF @iFound = 0
	BEGIN
		SELECT -1, 'No es posible modificar este tipo de producto.'
	END ELSE 
	BEGIN
	     SELECT 0, 'Ok'
	END
	
END
GO
