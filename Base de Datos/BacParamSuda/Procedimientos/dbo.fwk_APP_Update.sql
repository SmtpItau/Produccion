USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_APP_Update]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_APP_Update] 
(
    @IdAplicacion      NVARCHAR(30)
   ,@Descripcion       VARCHAR(100)
   ,@Mode              VARCHAR(3)
   ,@SepDecimal        VARCHAR(1)
   ,@SepMiles          VARCHAR(1)
   ,@SepFecha          VARCHAR(1)
   ,@DecimalPlaces     SMALLINT
)
--WITH ENCRYPTION
AS
	/*
Actualiza la informacion de las aplicaciones

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_APP_Update ...

*/

BEGIN
	IF EXISTS (
	       SELECT id_aplicacion
	       FROM   FWK_APLICACIONES
	       WHERE  id_aplicacion = @IdAplicacion
	   )
	BEGIN
	    -- actualizar la informacion
	    UPDATE FWK_APLICACIONES
	    SET    descripcion           = @Descripcion
	          ,mode                  = @Mode
	          ,separador_decimal     = @SepDecimal
	          ,separador_miles       = @SepMiles
	          ,separador_fecha       = @SepFecha
	          ,decimal_places        = @DecimalPlaces
	    WHERE  id_aplicacion         = @IdAplicacion
	END
	ELSE
	BEGIN
	    -- generar la informacion
	    INSERT INTO FWK_APLICACIONES
	      (
	        id_aplicacion
	       ,descripcion
	       ,mode
	       ,separador_decimal
	       ,separador_miles
	       ,separador_fecha
	       ,decimal_places
	      )
	    VALUES
	      (
	        @IdAplicacion
	       ,@Descripcion
	       ,@Mode
	       ,@SepDecimal
	       ,@SepMiles
	       ,@SepFecha
	       ,@DecimalPlaces
	      )
	END
END
GO
