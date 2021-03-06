USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_PRODCONLINEA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_PRODCONLINEA]( @Sistema   CHAR(03) )
AS
BEGIN
	SET NOCOUNT ON
		SELECT   codigo_producto
			,descripcion
			,id_sistema
			,estado	
		FROM	producto 
		WHERE	id_sistema	  = @Sistema
		ORDER BY id_sistema
			,codigo_producto
END

-- SP_AUTORIZA_EJECUTAR 'bacuser'
-- Sp_Leer_ProdConLinea 'BCC'

-- sp_helptext sp_Leer_DocPagoMoneda
GO
