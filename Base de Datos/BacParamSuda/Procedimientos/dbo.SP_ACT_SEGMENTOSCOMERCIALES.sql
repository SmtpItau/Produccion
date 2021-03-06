USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_SEGMENTOSCOMERCIALES]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ACT_SEGMENTOSCOMERCIALES]	(	@SgmCod		CHAR(6)		
						,	@SgmNem		CHAR(10)	
						,	@SgmDesc	VARCHAR(40)	
						,	@RecMtdCod	NUMERIC(5)		
						)
AS
BEGIN

	SET NOCOUNT ON 

	INSERT INTO TBL_SEGMENTOSCOMERCIALES
	(		
		SgmCod			
	,	SgmNem		
	,	SgmDesc	
	,	RecMtdCod	
	)
	VALUES (
	
		@SgmCod			
	,	@SgmNem		
	,	@SgmDesc	
	,	@RecMtdCod	
	)

	SET NOCOUNT OFF

END
GO
