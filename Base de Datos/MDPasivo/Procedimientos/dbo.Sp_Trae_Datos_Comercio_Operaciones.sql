USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Datos_Comercio_Operaciones]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Trae_Datos_Comercio_Operaciones]
      (
		@SW		NUMERIC	(02),
		@ID_SISTEMA	CHAR	(03)
      )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

IF @SW =  1
BEGIN
      -- << CODIGO OMA >>
      SELECT  codigo_oma , glosa
      FROM    CODIGO_COMERCIO
END

IF @SW = 2 
BEGIN
      -- << CODIGO PRODUCTO >>

	IF @ID_SISTEMA IN ('BCC' , 'SWP', 'BFW')
	BEGIN
		SELECT  codigo_producto , descripcion
		FROM    PRODUCTO
		WHERE   ID_SISTEMA = 'BCC'
	END
	ELSE
	BEGIN
		SELECT  codigo_producto , descripcion
		FROM    PRODUCTO
		WHERE   ID_SISTEMA = @ID_SISTEMA
	END
END

IF @SW = 3
BEGIN
      -- << TIPO CLIENTE >>
      SELECT  Codigo_Tipo_Cliente
      ,       descripcion 
      FROM    TIPO_CLIENTE
      ORDER BY Codigo_Tipo_Cliente
END

IF @SW = 5
BEGIN

      SELECT  mncodmon
      ,       LTRIM(RTRIM(CONVERT(VARCHAR(4),mnnemo)))  + SPACE(12 - LEN(LTRIM(RTRIM(mnnemo))))  + LTRIM(RTRIM(CONVERT( VARCHAR(30), mnglosa )))      FROM    PRODUCTO_MONEDA
      ,       MONEDA
      WHERE   mpsistema     = 'BCC'
      AND     mpproducto    = 'PTAS'
      AND     mncodmon      =  mpcodigo
      AND     ESTADO	    <> 'A'
      ORDER BY mnnemo
END


IF @SW =  7
BEGIN
      -- << CODIGO COMERCIO >>
      SELECT  ' ' , glosa
      FROM    CODIGO_COMERCIO
END

IF @SW =  8
BEGIN
      -- << CODIGO CONCEPTO >>
      SELECT  ' ' , glosa
      FROM    CODIGO_COMERCIO
END

END

GO
