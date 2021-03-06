USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CONTROL_PRECIO]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ACT_CONTROL_PRECIO]
                                                    @cId_Sistema            	CHAR(03)
                                                ,   @cCodigo_Producto       	CHAR(05)
                                                ,   @cCodigo_Subproducto  CHAR(15)
                                                ,   @nSpread_Minimo         	FLOAT
                                                ,   @nSpread_Maximo         	FLOAT
	        	                     ,   @nPlazo_Minimo         	FLOAT
                                                ,   @nPlazo_Maximo         	FLOAT
			        ,   @cAccion		CHAR(10)		
			

AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON
  


	IF(@cAccion='INS')
	BEGIN
          		INSERT CONTROL_PRECIO(   
			id_sistema
                                	,   codigo_producto
                                	,   codigo_subproducto
                                	,   spread_minimo
                                	,   spread_maximo
			,   nplazo_minimo
			,   nplazo_maximo
                                  )
                        	VALUES (  
			 @cId_Sistema
                                	,   @cCodigo_Producto
                                	,   @cCodigo_Subproducto
                                	,   @nSpread_Minimo
                                	,   @nSpread_Maximo
			,   @nPlazo_Minimo
  			,   @nPlazo_Maximo
                                )
	END 
	IF(@cAccion='DEL')
	BEGIN
		DELETE FROM CONTROL_PRECIO WHERE id_sistema=@cId_Sistema AND codigo_producto=@cCodigo_Producto AND codigo_subproducto=@cCodigo_Subproducto
	END
	IF(@cAccion='BUS')
	BEGIN

		 SELECT    spread_minimo     
			,    spread_maximo
			,    nplazo_minimo
			,    nplazo_maximo

            		FROM CONTROL_PRECIO
            		WHERE 	id_sistema         = @cId_Sistema
              			AND codigo_producto    = @cCodigo_Producto
              			AND codigo_subproducto = @cCodigo_SubProducto
	END
END

/*CREATE PROCEDURE dbo.SP_ACT_CONTROL_PRECIO
                                                    @cId_Sistema            CHAR(03)
                                                ,   @cCodigo_Producto       CHAR(05)
                                                ,   @cCodigo_Subproducto    CHAR(15)
                                                ,   @nSpread_Minimo         FLOAT
                                                ,   @nSpread_Maximo         FLOAT
AS
BEGIN

   SET DATEFORMAT dmy   

    IF EXISTS(SELECT 1 FROM CONTROL_PRECIO WHERE id_sistema        = @cId_Sistema
                                             AND codigo_producto   = @cCodigo_Producto
                                             AND codigo_subproducto= @cCodigo_Subproducto)

            UPDATE CONTROL_PRECIO SET spread_minimo = @nSpread_Minimo
                                    , spread_maximo = @nSpread_Maximo
                        WHERE id_sistema         = @cId_Sistema
                          AND codigo_producto    = @cCodigo_Producto
                          AND codigo_subproducto = @cCodigo_Subproducto

    ELSE
            INSERT CONTROL_PRECIO(
                                    id_sistema
                                ,   codigo_producto
                                ,   codigo_subproducto
                                ,   spread_minimo
                                ,   spread_maximo
                                  )
                        VALUES  (   @cId_Sistema
                                ,   @cCodigo_Producto
                                ,   @cCodigo_Subproducto
                                ,   @nSpread_Minimo
                                ,   @nSpread_Maximo
                                )

END
*/



GO
