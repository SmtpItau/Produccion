USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VMGRABAR]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_VMGRABAR]
	(	@vmcodigo1 NUMERIC(03,0)
	,	@vmvalor1  NUMERIC(18,10)
	,	@vmfecha1  DATETIME
	)
AS   
BEGIN 

	SELECT 'OK'
    SET NOCOUNT ON
    RETURN

	/*
	SET NOCOUNT ON

	IF EXISTS(SELECT vmcodigo FROM VIEW_VALOR_MONEDA WHERE  vmcodigo =  @vmcodigo1 AND vmfecha = @vmfecha1)
		UPDATE	VIEW_VALOR_MONEDA
		SET		vmcodigo = @vmcodigo1
		,		vmvalor  = @vmvalor1
		,		vmfecha  = @vmfecha1
		WHERE	vmcodigo = @vmcodigo1
		AND		vmfecha  = @vmfecha1 
	ELSE
		INSERT INTO VIEW_VALOR_MONEDA	(	vmcodigo,	vmvalor,	vmfecha		)
								VALUES	(	@vmcodigo1,	@vmvalor1,	@vmfecha1	)
	SELECT 'OK'
    SET NOCOUNT ON
    RETURN
    */
    
END
GO
