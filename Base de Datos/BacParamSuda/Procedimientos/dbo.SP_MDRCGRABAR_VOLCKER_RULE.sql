USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDRCGRABAR_VOLCKER_RULE]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MDRCGRABAR_VOLCKER_RULE]	(	
						@ncodpro			CHAR(5)
					,	@Id_Sistema			CHAR(3)					
					,	@Id_Cartera_VR		NUMERIC(9,0)   
					)
AS 
BEGIN
	SET NOCOUNT ON

/* LD1-COR-035 FUSION CORPBANCA - ITAU --> MANTENEDOR CARTERA VOLCKER RULE**/
/***************************************************************************/
/*SISTEMA: BACPARAMETROS */



	IF EXISTS( SELECT * FROM  TBL_CARTERA_PRODUCTO_VOLCKER_RULE with(nolock)
						WHERE	Id_Sistema		= @Id_Sistema     
							AND	Id_Producto		= @ncodpro        
							AND	Id_Cartera_VR   = @Id_Cartera_VR) BEGIN


		UPDATE  TBL_CARTERA_PRODUCTO_VOLCKER_RULE
		   set  @Id_Cartera_VR  = @Id_Cartera_VR
		  WHERE	Id_Sistema		= @Id_Sistema     
			AND	Id_Producto		= @ncodpro        
			AND	Id_Cartera_VR   = @Id_Cartera_VR
          
	END 
	ELSE BEGIN

		INSERT INTO TBL_CARTERA_PRODUCTO_VOLCKER_RULE 
		(	Id_Sistema	 
		,	Id_Producto	 
		,	Id_Cartera_VR 		
		)
		VALUES
		(	 @Id_Sistema     
		,	 @ncodpro        
		,	 @Id_Cartera_VR		
		)
	END
   
	SET NOCOUNT OFF

END

GO
