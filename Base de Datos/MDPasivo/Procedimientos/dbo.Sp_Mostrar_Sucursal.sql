USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_Sucursal]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Mostrar_Sucursal]
   ( @codigo_sucursal CHAR(5) = ' ')
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

	SELECT  codigo_sucursal,
		nombre 
	FROM SUCURSAL
	WHERE codigo_sucursal = @codigo_sucursal OR @codigo_sucursal = ' '
	ORDER BY nombre

END


GO
