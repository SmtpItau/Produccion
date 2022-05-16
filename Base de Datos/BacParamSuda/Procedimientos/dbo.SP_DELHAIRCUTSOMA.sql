USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DELHAIRCUTSOMA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DELHAIRCUTSOMA] 	(  @TipoOpe	 CHAR(03)		
					)
AS
BEGIN

	SET NOCOUNT ON 

	DELETE	 HAIRCUT_SOMA
	WHERE    hctipoper = @TipoOpe                  
	
	SET NOCOUNT OFF

END
GO
