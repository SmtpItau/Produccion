USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_AYUDACLIENTEGRUPO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AYUDACLIENTEGRUPO]
( 
             @tipo INTEGER = 0 
)
AS 
BEGIN
   SET NOCOUNT ON


	IF @tipo <> 0
		BEGIN
			SELECT 	'RUT'	= STR(clrut) + '-' + cldv	,
				clcodigo				,
				clnombre				,
				STR(clrut)				,
				cldv					,
				cltipcli
			FROM 	VIEW_CLIENTE
			WHERE	cltipcli = @tipo 	AND
				NOT EXISTS( 	SELECT 	1 
						FROM 	CLIENTE_RELACIONADO 
						WHERE 	CLIENTE_RELACIONADO.clrut_hijo	  = VIEW_CLIENTE.clrut  AND 
							CLIENTE_RELACIONADO.clcodigo_hijo = VIEW_CLIENTE.clcodigo )
			ORDER BY
				clnombre

		END
	ELSE
		BEGIN
			SELECT 	'RUT'	= STR(clrut) + '-' + cldv	,
				clcodigo				,
				clnombre				,
				STR(clrut)				,
				cldv					,
				cltipcli
			FROM 	VIEW_CLIENTE
			WHERE	cltipcli <> 1	AND
				NOT EXISTS( 	SELECT 	1 
						FROM 	CLIENTE_RELACIONADO 
						WHERE 	CLIENTE_RELACIONADO.clrut_hijo	  = VIEW_CLIENTE.clrut  AND 
							CLIENTE_RELACIONADO.clcodigo_hijo = VIEW_CLIENTE.clcodigo )
			ORDER BY
				clnombre

		END

   SET NOCOUNT OFF

END
GO
