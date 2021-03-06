USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_REL_USU_CART_VOLCKER_RULE]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ACT_REL_USU_CART_VOLCKER_RULE]	
(						@Usuario	CHAR(15)	
					,	@Sistema	CHAR(05)	
					,	@Producto	CHAR(05)	
					,	@Codigo_Cart	CHAR(10)
					,	@Default	CHAR(1)
					)
AS
BEGIN

	SET NOCOUNT ON 

/* LD1-COR-035 FUSION CORPBANCA - ITAU --> MANTENEDOR USUARIO - CARTERA **/
/***********************************************************************/


   IF EXISTS( SELECT 1 FROM TBL_REL_USU_CART_VOLCKER_RULE with(nolock) WHERE Ucvr_Usuario		= @Usuario
																		AND	Ucvr_Sistema		= @Sistema	
																		AND	Ucvr_Producto		= @Producto
																		AND	Ucvr_Codigo_Cart	= @Codigo_Cart	)

		
   BEGIN
      DELETE FROM TBL_REL_USU_CART_VOLCKER_RULE
            WHERE Ucvr_Usuario	 = @Usuario
            AND   Ucvr_Sistema	 = @Sistema 
            AND   Ucvr_Producto	 = @Producto 
            AND   Ucvr_Codigo_Cart = @Codigo_Cart
   END


	INSERT INTO TBL_REL_USU_CART_VOLCKER_RULE
	(		
		 Ucvr_Usuario	
	,	Ucvr_Sistema	
	,	Ucvr_Producto	
	,	Ucvr_Codigo_Cart
	,	Ucvr_Default
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
