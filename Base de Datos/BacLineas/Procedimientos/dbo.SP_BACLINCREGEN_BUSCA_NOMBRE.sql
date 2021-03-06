USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACLINCREGEN_BUSCA_NOMBRE]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACLINCREGEN_BUSCA_NOMBRE]
		(						@rut_cliente	NUMERIC(9),
		@cod_cliente	NUMERIC(5)
		)

AS
BEGIN

	DECLARE @nombre CHAR(70)	

	SET NOCOUNT ON

		SELECT clnombre
                ,      clrut
                ,      cldv
                ,      clcodigo
                  FROM VIEW_CLIENTE 
                 WHERE clrut        = @rut_cliente 
                   AND @cod_cliente = clcodigo

	SET NOCOUNT OFF

END
GO
