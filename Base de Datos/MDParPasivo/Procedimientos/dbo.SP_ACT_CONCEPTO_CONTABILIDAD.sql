USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CONCEPTO_CONTABILIDAD]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_ACT_CONCEPTO_CONTABILIDAD]
               ( @ccodigo_concepto         CHAR(05)
               , @cdescripcion             CHAR(50)
               , @ninventario              NUMERIC(01)
               , @nresultado               NUMERIC(01)
	       , @nProducto		   NUMERIC(01)
	       , @nGarantia		   NUMERIC(01)
	       , @nTipoPlazo		   NUMERIC(01)
	       , @nFinancia		   NUMERIC(01)
	       , @nSector		   NUMERIC(01)
	       , @nCorresponsal		   NUMERIC(01)
	       , @nPropiedad		   NUMERIC(01)
	       , @nCuota		   NUMERIC(01)
	       , @nColocacion		   NUMERIC(01)
	       , @nRecup		   NUMERIC(01)
	       , @nDivisa		   NUMERIC(01)
	       , @nTipoMoneda		   NUMERIC(01)
               , @nReferencia              INTEGER
               , @nCodigoOperacion         NUMERIC(01)
               )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy


   IF NOT EXISTS (SELECT * FROM CONCEPTO_CONTABLE
                          WHERE concepto_contable = @ccodigo_concepto )

      INSERT INTO CONCEPTO_CONTABLE
                ( concepto_contable
                , descripcion
                , inventario   
                , resultado
		, switch_producto
		, switch_garantia
		, switch_tipo_plazo
		, switch_financia
		, switch_sector
		, switch_corresponsal
		, switch_propiedad
		, switch_cuota
		, switch_colocacion
		, switch_recup
		, switch_divisa
		, switch_tipo_moneda
                , referencia
                , switch_Codigo_Operacion
                )
                VALUES
                ( @ccodigo_concepto
                , @cdescripcion
                , @ninventario   
                , @nresultado
 	        , @nProducto
	        , @nGarantia
	        , @nTipoPlazo
	        , @nFinancia
	        , @nSector
	        , @nCorresponsal
	        , @nPropiedad
	        , @nCuota
	        , @nColocacion
	        , @nRecup
	        , @nDivisa
	        , @nTipoMoneda
                , @nReferencia
                , @nCodigoOperacion
                )

   ELSE

      UPDATE CONCEPTO_CONTABLE 
         SET descripcion   	    = @cdescripcion
        , inventario      	    = @ninventario
        , resultado       	    = @nresultado
	, switch_producto	    = @nProducto
	, switch_garantia	    = @nGarantia
	, switch_tipo_plazo	    = @nTipoPlazo
	, switch_financia	    = @nFinancia
	, switch_sector		    = @nSector
	, switch_corresponsal	    = @nCorresponsal
	, switch_propiedad	    = @nPropiedad
	, switch_cuota		    = @nCuota
	, switch_colocacion	    = @nColocacion
	, switch_recup		    = @nRecup
	, switch_divisa		    = @nDivisa
	, switch_tipo_moneda	    = @nTipoMoneda
        , referencia                = @nReferencia
        , switch_codigo_operacion   = @nCodigoOperacion
       WHERE concepto_contable      = @ccodigo_concepto

   SET NOCOUNT OFF

END





GO
