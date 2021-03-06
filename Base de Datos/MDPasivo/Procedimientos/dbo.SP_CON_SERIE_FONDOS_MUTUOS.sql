USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SERIE_FONDOS_MUTUOS]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CON_SERIE_FONDOS_MUTUOS]
	(
		@Serie CHAR(12)
	)
AS
BEGIN
        SET NOCOUNT ON
        SET DATEFORMAT dmy

	SELECT  C.clRut, 
		C.cldv, 
		ClNombre, 
		C.clcodigo, 
		M.mncodmon, 
		M.mnglosa,
		F.Descripcion
	FROM 	FMUTUO_SERIE	F,
		CLIENTE		C,
		MONEDA		M
	WHERE
		C.clrut		=	F.rut_cliente 		AND
		C.clcodigo	=	F.codigo_cliente	AND
		M.mncodmon	=	F.codigo_moneda		AND
		F.serie		=	@Serie

END



GO
