USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDRCELIMINACAR_VOLCKER_RULE]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MDRCELIMINACAR_VOLCKER_RULE]
       ( 
        @ncodpro			CHAR(5),
        @Id_Sistema			CHAR(3),
        @Id_Cartera_VR		NUMERIC ( 9, 0 )
       )
AS
BEGIN      
SET NOCOUNT ON 


/* LD1-COR-035 FUSION CORPBANCA - ITAU --> MANTENEDOR CARTERA VOLCKER RULE **/
/***********************************************************************/
/*SISTEMA: BACPARAMETROS */



  /*=======================================================================*/
   /*=======================================================================*/
   DELETE FROM [TBL_CARTERA_PRODUCTO_VOLCKER_RULE] 
   WHERE Id_Sistema		= @Id_Sistema 
   AND	 Id_Producto	=  @ncodpro 
   AND	 Id_Cartera_VR	= @Id_Cartera_VR
   /*=======================================================================*/
   /*=======================================================================*/
SET NOCOUNT OFF
SELECT 0
END


GO
