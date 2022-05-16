USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_INSTRUMENTOS_MARGEN]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TRAE_INSTRUMENTOS_MARGEN]( @id_sistema CHAR(03) = '')
AS
BEGIN

SET DATEFORMAT dmy


   IF @id_sistema = 'BTR' OR @id_sistema = '' 
	SELECT	inserie
	,	incodigo
	,	inglosa
	,	CASE WHEN inmonemi <> 0 THEN (SELECT mnextranj FROM MONEDA WHERE inmonemi = mncodmon) ELSE 1 END
	FROM	INSTRUMENTO
	ORDER	BY inserie
--   ELSE

 --  IF @id_sistema = 'INV' 
--	SELECT	Nom_Familia,
--		Cod_familia,
--		Descrip_familia,
--		0
--	FROM	VIEW_INSTRUMENTO_INVERSION_EXTERIOR


END



-- select * from VIEW_INSTRUMENTO_INVERSION_EXTERIOR
--sp_Help
-- DBO.SP_TRAE_INSTRUMENTOS_MARGEN 'INV'
--SP_TRAE_INSTRUMENTOS_MARGEN 'btr'
--select * from view_moneda
GO
