USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_OPERADORES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_OPERADORES]
AS
BEGIN
--Area de Negocio
	select	nombre,
		usuario
	from 	VIEW_USUARIO 
END

GO
