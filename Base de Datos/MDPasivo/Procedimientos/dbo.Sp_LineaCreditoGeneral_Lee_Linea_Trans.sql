USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LineaCreditoGeneral_Lee_Linea_Trans]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_LineaCreditoGeneral_Lee_Linea_Trans]
		(@rut_cliente NUMERIC(9), @id_sistema CHAR(3)=' ')
AS BEGIN

     SET NOCOUNT ON
     SET DATEFORMAT dmy

	IF @id_sistema =' ' 
	   BEGIN
		SELECT DISTINCT rut_cliente
				FROM LINEA_TRANSACCION
				WHERE rut_cliente = @rut_cliente
		RETURN 0
	 END
		SELECT DISTINCT rut_cliente,
				id_sistema
				--Codigo_Producto 
				FROM LINEA_TRANSACCION
				WHERE rut_cliente = @rut_cliente and
				      id_sistema  = @id_sistema

     SET NOCOUNT OFF
END
	










GO
