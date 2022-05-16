USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_borra_Subproducto]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_borra_Subproducto]
		( @nSubProd	CHAR(15),
		  @Id_Sistema	CHAR(03),
		  @nCodprod	CHAR(05)
		)

as
begin

	SET DATEFORMAT DMY
	SET NOCOUNT ON


      DELETE TIPO_CARTERA WHERE 
		   Id_Sistema          = @Id_Sistema	AND
--                   Codigo_subproducto  = @nSubProd	AND
		   Codigo_Producto     = @nCodprod

END


GO
