USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_DETALLE_PACTOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_DETALLE_PACTOS] (
           @usuario                            VARCHAR(15)        = 'ADMINISTRA'
         , @ventana                            NUMERIC(9,0)       = 0
         , @serie                              VARCHAR(20)        = ''
         , @documento                          NUMERIC(9,0)       = 0
         , @Correlativo                        NUMERIC(9,0)       = 0
         , @Nominal_Venta            	       FLOAT              = 0
         , @vPresente_Venta                    NUMERIC(19,4)      = 0 
         , @vInicial_Venta           	       NUMERIC(19,4)      = 0
	 , @cCustodia 			       CHAR (01) 	  = ''
	 , @cClave    			       CHAR (15) 	  = '' 	 
)
AS
BEGIN
         IF EXISTS (SELECT * FROM BacTraderSuda..DETALLE_VTAS_CON_PCTO
                                      WHERE usuario = @usuario
                                               AND serie = @serie
                                                        AND ventana = @ventana
                                                                  AND documento = @documento 
                                                                           AND Correlativo = @Correlativo
                                                                                     )
                 
	DECLARE @RutEmisor  NUMERIC(10)
	SET @RutEmisor = 0
	
	DECLARE @CartNorm  CHAR(10)
	SET @CartNorm = ''

	SELECT 	@RutEmisor = Rut_emisor
	,	@CartNorm  = CarteraSuper
	FROM 	BacTraderSuda..DETALLE_VTAS_CON_PCTO
	WHERE 	usuario      = @usuario
   	AND 	Serie        = @serie
        AND 	Ventana      = @ventana
  	AND 	Documento    = @documento 
        AND 	Correlativo  = @Correlativo
		

                   UPDATE BacTraderSuda..DETALLE_VTAS_CON_PCTO  -- select * from BacTraderSuda..DETALLE_VTAS_CON_PCTO 
   		   SET     Nominal_Venta       = @Nominal_Venta
            		   ,Tasa_Venta         = ISNULL(( select max(Tasa_venta) 
                                    			  from 	BacTraderSuda..DETALLE_VTAS_CON_PCTO
                                    			  WHERE usuario      =    @usuario
                                                	  AND 	serie        =    @serie
                                                	  AND 	ventana      =    @ventana
                                                	  AND 	MArca        =    'S'
                                                	  AND 	Rut_emisor   =    @RutEmisor                                                    
                                                	  AND 	CarteraSuper =    @CartNorm 		--misma cartera normativa
                                  	   	 	),      Tasa_Compra) 				-- si es nullo dejar Tasa_Compra.
                            ,vPresente_Venta   = @vPresente_Venta
                            ,vInicial_Venta    = @vInicial_Venta
			    ,cCustodia	       = @cCustodia
			    ,cClave	       = @cClave
                            ,Marca             = case when @Nominal_Venta > 0 then 'S'
                                                 else 'N' end 
                                                         
                        

                   WHERE    usuario             = @usuario
                            AND serie           = @serie
                            AND ventana         = @ventana
                            AND documento       = @documento 
                            AND correlativo 	= @Correlativo

                   IF @@ERROR <> 0
                   BEGIN
                            SELECT -1, 'Error al actualizar Tabla DETALLE_VTAS_CON_PCTO'
                            RETURN 0
                   END

END

GO
