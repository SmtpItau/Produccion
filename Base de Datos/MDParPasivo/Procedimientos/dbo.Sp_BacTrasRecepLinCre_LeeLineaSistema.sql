USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacTrasRecepLinCre_LeeLineaSistema]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacTrasRecepLinCre_LeeLineaSistema]

	(@rut_cliente	NUMERIC(9))

AS BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	IF EXISTS(SELECT rut_cliente, '' --id_sistema 
                  FROM LINEA_SISTEMA WHERE @rut_cliente = rut_cliente)

	   BEGIN

		SELECT rut_cliente, ''--id_sistema 
                           FROM LINEA_SISTEMA WHERE @rut_cliente = rut_cliente

	   RETURN

	END

	SELECT "NO HAY"

	SET NOCOUNT OFF
END

--SELECT * FROM LINEA_SISTEMA




GO
