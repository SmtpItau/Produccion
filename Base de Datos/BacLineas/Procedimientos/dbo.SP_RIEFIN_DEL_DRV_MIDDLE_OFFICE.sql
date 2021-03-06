USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_DEL_DRV_MIDDLE_OFFICE]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_DEL_DRV_MIDDLE_OFFICE]
	(	@MddMod								VARCHAR(3)
	,	@MddNumOpe							NUMERIC(10,0)
	)	
	
AS
BEGIN
	SET NOCOUNT ON	
	DECLARE @EXISTE INT
	SET @EXISTE = 0

	SELECT	@EXISTE =1
	FROM	TBL_RIEFIN_DRV_MIDDLE_OFFICE 
	WHERE	MddMod = @MddMod 
	AND		MddNumOpe = @MddNumOpe

	IF @EXISTE =0
	BEGIN
		SELECT -1,'No puede eliminar, Registro no existe'
		RETURN	
	END
	
	IF @EXISTE =1
	BEGIN
		DELETE	 TBL_RIEFIN_DRV_MIDDLE_OFFICE
		WHERE	 MddMod = @MddMod 
		AND		 MddNumOpe = @MddNumOpe
	END
END 
SET NOCOUNT OFF
GO
