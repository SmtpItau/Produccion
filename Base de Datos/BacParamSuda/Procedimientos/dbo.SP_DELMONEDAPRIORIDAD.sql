USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DELMONEDAPRIORIDAD]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DELMONEDAPRIORIDAD] 	(  @CodMoneda	 Numeric(5,0)		
					)
AS
BEGIN

	SET NOCOUNT ON 

	DELETE	 MonedaPrioridad
	WHERE    MnCodMon = @CodMoneda	                 
	
	SET NOCOUNT OFF

END
GO
