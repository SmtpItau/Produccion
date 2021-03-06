USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CONTROL_ACTIVO]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_CON_CONTROL_ACTIVO](
                                       @sId_Sistema   Char(3)   ,
                                       @sProducto     Char(5)   ,
                                       @nInstrumento  Numeric(5),
                                       @sControl      Char(5)
                                     )
AS
BEGIN --INICIO SP

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @SGRUPO   CHAR(10)  


	SELECT	estado,
		codigo_grupo
	FROM	PRODUCTO_CONTROL  WITH (NOLOCK)
	WHERE	codigo_control = @sControl
	AND	id_sistema         = @sId_Sistema
	AND	codigo_producto    = @sProducto

/*
   IF @nInstrumento=0 BEGIN

	SELECT	@NINSTRUMENTO	= INCODIGO
	FROM	INSTRUMENTO
	WHERE	INSERIE=@sProducto

   END

   SELECT @SGRUPO = (SELECT codigo_grupo 
                       FROM GRUPO_PRODUCTO_DETALLE 
                      WHERE id_sistema         = @sId_Sistema  AND
                            codigo_producto    = @sProducto    AND
                            codigo_instrumento = @nInstrumento
                     )

   SELECT ISNULL(estado,''), ISNULL(codigo_grupo ,'')
     FROM PRODUCTO_CONTROL
    WHERE codigo_grupo   = @SGRUPO       AND
          codigo_control = @sControl
*/

END   --FIN SP

-- select * from PRODUCTO_CONTROL




GO
