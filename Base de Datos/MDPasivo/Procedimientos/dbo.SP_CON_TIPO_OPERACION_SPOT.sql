USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TIPO_OPERACION_SPOT]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_CON_TIPO_OPERACION_SPOT]
AS
BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	SELECT   Codigo
	,        Glosa
        ,        Afecta_Posicion_Contable
        ,        Afecta_Descalce_Tc
        ,        Codigo_Producto  
	,	 afecta_contable
	,	 codigo_comercio
	FROM     PRODUCTO_DESCALCE
	ORDER BY Codigo

END

GO
