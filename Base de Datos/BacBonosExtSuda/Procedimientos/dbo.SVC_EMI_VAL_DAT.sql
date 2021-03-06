USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_EMI_VAL_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_EMI_VAL_DAT] 
	(	@rut		NUMERIC(9)	,
		@dv		CHAR(1)		,
		@cod		NUMERIC(9)	)
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT clnombre FROM BacParamSuda..Cliente WHERE clrut = @rut AND clcodigo = @cod AND CLDV = @dv) 
	BEGIN
	
		SELECT 	'1',clnombre,clvigente	
		FROM	BacParamSuda..Cliente
		WHERE	clrut = @rut
		AND	clcodigo = @cod
		AND	cldv = @dv

	END
	ELSE BEGIN
		SELECT '0',' ' 
	END		

	SET NOCOUNT OFF
END

GO
