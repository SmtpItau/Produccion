USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTMETODOLOGIAREC]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ACTMETODOLOGIAREC]	(	@RecMtdCod	NUMERIC(5,0)		
					,	@RecMtdNemo	VARCHAR(20)		
					,	@RecMtdDsc	VARCHAR(30)		
					)
AS
BEGIN

	SET NOCOUNT ON 

	INSERT INTO 	BACLINEAS..TBL_METODOLOGIAREC
	(		
		RecMtdCod			
	,	RecMtdNemo			
	,	RecMtdDsc	
	)
	VALUES (
	
		@RecMtdCod	
	,	@RecMtdNemo
	,	@RecMtdDsc	
	)

	SET NOCOUNT OFF

END
GO
