USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeerCiuAux]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_LeerCiuAux] (@tbcod1 numeric (4),
				@tbcod2 numeric (4),
				@codcom numeric (4))
                 	
AS
BEGIN


   	SET DATEFORMAT DMY
	SET NOCOUNT ON



IF @tbcod1 = 3
BEGIN
    SELECT nom_ciu, cod_ciu, nombre  ,codigo_ciudad

    FROM   CIUDAD_COMUNA, CIUDAD

    WHERE cod_com                      = 0
	  and codigo_ciudad            = @tbcod2
	  AND convert(char(5),cod_pai) = codigo_ciudad
    ORDER BY nom_ciu
END

IF @tbcod1 = 180
BEGIN
    SELECT nom_ciu, cod_ciu, nombre  ,codigo_pais

    FROM   CIUDAD_COMUNA, PAIS

    WHERE cod_com                      = 0
	  and codigo_pais              = @tbcod2
	  AND convert(char(5),cod_pai) = codigo_pais 
    ORDER BY nom_ciu
END

IF @tbcod1 = 212
BEGIN
    SELECT nom_ciu, cod_ciu, Descripcion ,Codigo_Amortizacion

    FROM   CIUDAD_COMUNA, TIPO_AMORTIZACION

    WHERE cod_com                      = 0
	  and Codigo_Amortizacion      = @tbcod2
	  AND convert(char(5),cod_pai) = Codigo_Amortizacion
    ORDER BY nom_ciu
END

IF @tbcod1 = 1042
BEGIN
    SELECT nom_ciu, cod_ciu, Descripcion ,Codigo_Tasa

    FROM   CIUDAD_COMUNA, TIPO_TASA
    WHERE cod_com                      = 0
	  and Codigo_Tasa              = @tbcod2
	  AND convert(char(5),cod_pai) = Codigo_Tasa
    ORDER BY nom_ciu
END

IF @tbcod1 = 1050
BEGIN
    SELECT nom_ciu, cod_ciu, Descripcion ,Codigo_producto

    FROM   CIUDAD_COMUNA, PRODUCTO

    WHERE cod_com                      = 0
	  and Codigo_producto          = @tbcod2
	  AND convert(char(5),cod_pai) = Codigo_producto
    ORDER BY nom_ciu
END

IF @tbcod1 = 204
BEGIN
    SELECT nom_ciu, cod_ciu, Descripcion ,Codigo_Producto

    FROM   CIUDAD_COMUNA, TIPO_CARTERA

    WHERE cod_com                      = 0
	  and Codigo_Cartera           = @tbcod2
	  AND convert(char(5),cod_pai) = Codigo_Producto
    ORDER BY nom_ciu
END


RETURN
END




GO
