USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_REL_USU_CART_FIN]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACT_REL_USU_CART_FIN]	(	@Usuario	CHAR(15)	
					,	@Sistema	CHAR(05)	
					,	@Producto	CHAR(05)	
					,	@Codigo_Cart	CHAR(10)
					,	@Default	CHAR(1)
					)
AS
BEGIN

	SET NOCOUNT ON 

   IF EXISTS( SELECT 1 FROM TBL_REL_USU_CART_FINANCIERA WHERE Ucf_Usuario     = @Usuario
                                                         AND  Ucf_Sistema     = @Sistema 
                                                         AND  Ucf_Producto    = @Producto 
                                                         AND  Ucf_Codigo_Cart = @Codigo_Cart)
   BEGIN
      DELETE FROM TBL_REL_USU_CART_FINANCIERA 
            WHERE Ucf_Usuario     = @Usuario
            AND  Ucf_Sistema     = @Sistema 
            AND  Ucf_Producto    = @Producto 
            AND  Ucf_Codigo_Cart = @Codigo_Cart
   END

	INSERT INTO TBL_REL_USU_CART_FINANCIERA
	(		
		Ucf_Usuario
	,	Ucf_Sistema
	,	Ucf_Producto
	,	Ucf_Codigo_Cart
	,	Ucf_Default
	)
	VALUES (
	
		@Usuario	
	,	@Sistema	
	,	@Producto	
	,	@Codigo_Cart
	,	@default	
	)

	SET NOCOUNT OFF

END
GO
