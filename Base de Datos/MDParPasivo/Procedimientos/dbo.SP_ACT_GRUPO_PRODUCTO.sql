USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_GRUPO_PRODUCTO]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACT_GRUPO_PRODUCTO]
                                                @cCodigo_Grupo        CHAR(10)
                                          ,     @cDescripcion         CHAR(50)
                                          ,     @cId_Sistema          CHAR(03)
                                          ,     @cCodigo_Producto     CHAR(05)
                                          ,     @nCodigo_Instrumento  NUMERIC(03)
                                          ,     @Primera_Vez          INTEGER
					  ,	@riesgo		      CHAR(10)
AS
BEGIN

    SET NOCOUNT ON
    SET DATEFORMAT dmy

    IF @Primera_Vez = 1 BEGIN
        IF EXISTS(SELECT 1 FROM GRUPO_PRODUCTO WHERE codigo_grupo = @cCodigo_Grupo) BEGIN
            DELETE FROM GRUPO_PRODUCTO_DETALLE WHERE codigo_grupo = @cCodigo_Grupo

            	UPDATE 	GRUPO_PRODUCTO 
		SET 	descripcion = @cDescripcion	,
			riesgo	    = @riesgo
            	WHERE 	codigo_grupo = @cCodigo_Grupo


        END ELSE BEGIN
            INSERT GRUPO_PRODUCTO(
                                    codigo_grupo
                                ,   descripcion
				,   riesgo
                                 )
                        VALUES   (  @cCodigo_Grupo
                                ,   @cDescripcion
				,   @riesgo
                                 )
        END
    END

    INSERT GRUPO_PRODUCTO_DETALLE(
                                    codigo_grupo
                                 ,  id_sistema
                                 ,  codigo_producto
                                 ,  codigo_instrumento
                                 )
                        VALUES   (  @cCodigo_Grupo
                                 ,  @cId_Sistema
                                 ,  @cCodigo_Producto
                                 ,  @nCodigo_Instrumento
                                  )

    SET NOCOUNT OFF

END



GO
