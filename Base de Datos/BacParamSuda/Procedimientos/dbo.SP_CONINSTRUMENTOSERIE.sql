USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONINSTRUMENTOSERIE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONINSTRUMENTOSERIE]	(	@OPCION  	INT = 0	
						,	@SERIE		CHAR(30)
						)
AS
BEGIN
SET NOCOUNT ON

	IF @OPCION =1 BEGIN
       
	   execute bactradersuda..SP_CHKINSTSER  @SERIE
	      
	END

END
SET NOCOUNT OFF
GO
