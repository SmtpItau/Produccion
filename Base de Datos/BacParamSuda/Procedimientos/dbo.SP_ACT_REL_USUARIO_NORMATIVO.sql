USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_REL_USUARIO_NORMATIVO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACT_REL_USUARIO_NORMATIVO]	(	@Usuario		CHAR(15)	
						,	@Sistema		CHAR(05)	
						,	@Producto		CHAR(05)	
						,	@Codigo_Lib		CHAR(10)
						,	@Codigo_CartN		CHAR(10)	
						,	@Codigo_SubCartN	CHAR(10)
						,	@Default		CHAR(1)
						)
AS
BEGIN

	SET NOCOUNT ON 

   IF EXISTS( SELECT 1 FROM TBL_REL_USUARIO_NORMATIVO WHERE Ucn_Usuario      = @Usuario      AND Ucn_Sistema         = @Sistema 
                                                        AND Ucn_Producto     = @Producto     AND Ucn_Codigo_Lib      = @Codigo_Lib
                                                        AND Ucn_Codigo_CartN = @Codigo_CartN AND Ucn_Codigo_SubCartN = @Codigo_SubCartN)
   BEGIN

      DELETE FROM TBL_REL_USUARIO_NORMATIVO WHERE Ucn_Usuario      = @Usuario      AND Ucn_Sistema         = @Sistema 
                                              AND Ucn_Producto     = @Producto     AND Ucn_Codigo_Lib      = @Codigo_Lib
                                              AND Ucn_Codigo_CartN = @Codigo_CartN AND Ucn_Codigo_SubCartN = @Codigo_SubCartN
   END

	INSERT INTO TBL_REL_USUARIO_NORMATIVO
	(		
		Ucn_Usuario
	,	Ucn_Sistema
	,	Ucn_Producto
	,	Ucn_Codigo_Lib
	,	Ucn_Codigo_CartN
	,	Ucn_Codigo_SubCartN
	,	Ucn_Default
	)
	VALUES (
	
		@Usuario	
	,	@Sistema	
	,	@Producto	
	,	@Codigo_Lib
	,	@Codigo_CartN
	,	@Codigo_SubCartN
	,	@default	
	)

	SET NOCOUNT OFF

END
GO
