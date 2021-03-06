USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_TC]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Leer_TC]( @codtab integer  = 0 ,
                             @codigo integer  = 0 ,
                             @glosa  char(25) = ' ')
AS   
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

IF @codtab = 3
BEGIN
	SELECT @codtab, Codigo_Ciudad, Nombre
	FROM	CIUDAD
	WHERE	( Codigo_Ciudad = @codigo or @codigo = 0 )
	AND	( Nombre LIKE '%' + @glosa + '%' or @glosa = ' ' )
	ORDER BY Codigo_Ciudad
END

IF @codtab = 180
BEGIN
	SELECT @codtab, Codigo_Pais, Nombre
	FROM	PAIS
	WHERE	( Codigo_Pais = @codigo or @codigo = 0 )
	AND	( Nombre LIKE '%' + @glosa + '%' or @glosa = ' ' )
	ORDER BY Codigo_Pais
END

IF @codtab = 212
BEGIN
	SELECT @codtab, Codigo_Amortizacion, Descripcion
	FROM	TIPO_AMORTIZACION
	WHERE	( Codigo_Amortizacion = @codigo or @codigo = 0 )
	AND	( Descripcion LIKE '%' + @glosa + '%' or @glosa = ' ' )
	ORDER BY Codigo_Amortizacion
END

IF @codtab = 1042
BEGIN
	SELECT @codtab, Codigo_Tasa, Descripcion
	FROM	TIPO_TASA
	WHERE	( Codigo_Tasa = @codigo or @codigo = 0 )
	AND	( Descripcion LIKE '%' + @glosa + '%' or @glosa = ' ' )
	ORDER BY Codigo_Tasa
END

IF @codtab = 1050
BEGIN
	SELECT @codtab, Codigo_Producto, Descripcion
	FROM	PRODUCTO
	WHERE	--( Codigo_Producto = @codigo or @codigo = 0 ) AND
		( Descripcion LIKE '%' + @glosa + '%' or @glosa = ' ' )
	ORDER BY Codigo_Producto
END

IF @codtab = 204
BEGIN
	SELECT @codtab, Codigo_Cartera, Descripcion
	FROM	TIPO_CARTERA
	WHERE	( Codigo_Cartera = @codigo or @codigo = 0 )
	AND	( Descripcion LIKE '%' + @glosa + '%' or @glosa = ' ' )
	ORDER BY Codigo_Cartera
END




-- SELECT * FROM TIPO_CARTERA
        
--     SELECT tbcateg, tbcodigo1, tbglosa
--       FROM TABLA_GENERAL_DETALLE
--      WHERE (tbcateg = @codtab or @codtab =  0)
--        AND (tbcodigo1 = @codigo or @codigo =  0)
--        AND (tbglosa LIKE '%' + @glosa + '%' or @glosa = ' ')
--     ORDER BY tbcateg,tbcodigo1
END

GO
