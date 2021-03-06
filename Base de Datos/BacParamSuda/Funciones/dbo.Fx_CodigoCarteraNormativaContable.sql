USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_CodigoCarteraNormativaContable]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_CodigoCarteraNormativaContable] (
                            @IdSistema		  CHAR(03)           -- BNY
						,	@Tipo_movimiento  CHAR(05)	         -- DEV, MOV, TMF
						,	@Tipo_Operacion	  CHAR(05)	         -- CP, DCP, TMCP, V, VCP, VP, nuevo: ETMCP
						,   @Tipo_Emisor      integer            -- 1, 2, 4
						,   @Origen_Emisor    integer            -- 1, 2, 3 
                        ,   @Cartera_Super    char(10)           -- A, P, T
						,   @SubCartera_Super char(10)      = ''  
						,   @Tipo_Instrumento integer       = 0
						,   @Moneda           integer       = 0 
						,   @Objeto_Cubierto integer        = 0      -- 0
						,	@EstadoCobertura	CHAR(5)		= 'DCBTO'--
						,   @Contraparte     numeric(9)     = 0 
						,   @Desde           integer        = 0
						,   @Hasta           integer        = 0
)
RETURNS char(10)            
AS
BEGIN
   /*
   select BacParamSuda.dbo.Fx_CodigoCarteraNormativaContable( 'BNY', 'DEV', 'DCP', 1, 1, 'A' 
           , default, default, default, default, default, default, default, default)

   select * from BACPARAMSUDA..TBL_CLASIFICACION_CARTERA_INSTRUMENTO 
      where id_sistema = 'BNY'
	    and tipo_operacion = 

   */
			DECLARE @NA_Tipo_Intrumento	CHAR(01) 
				,	@NA_Tipo_Emisor		CHAR(01)
				,	@NA_Origen_Emisor	CHAR(01)
				,	@NA_Cubierto		CHAR(01)
				,	@NA_Contraparte		CHAR(01)
				,	@NA_Moneda		CHAR(01)
				,	@NA_Desde_Hasta		CHAR(01)
				,	@NA_SubCartera		CHAR(01)
				,	@NA_TipoMovimiento	CHAR(01)
				,	@NA_TipoOperacion	CHAR(01)

			SELECT	@NA_TipoMovimiento	= 'F'
			,	@NA_TipoOperacion	= 'F'
			,	@NA_Tipo_Emisor		= 'F'
			,	@NA_Cubierto		= CASE WHEN @Tipo_movimiento <> 'TMF' THEN 'V' ELSE 'F' END
			,	@NA_Moneda		= 'V'
			,	@NA_Desde_Hasta		= 'V'
			,	@NA_SubCartera		= 'V'
			,	@NA_Contraparte		= 'V'
			,	@NA_Tipo_Intrumento	= 'V'
			,	@NA_Origen_Emisor	= 'F'


	select	@Objeto_Cubierto	= 0 /*CASE WHEN codigo_carterasuper = 'A'THEN 0 ELSE 
										ISNULL(CASE WHEN @EstadoCobertura = 'CBTO'  THEN 1  
									  WHEN @EstadoCobertura = 'DCBTO' THEN 2 
															 END,0)
										end*/

	DECLARE @CodClas	CHAR(10) = ''
	
	SELECT	TOP 1 @CodClas	= CodigoCartera
	FROM	BACPARAMSUDA.dbo.TBL_CLASIFICACION_CARTERA_INSTRUMENTO
	WHERE	id_Sistema		= @IdSistema	
	AND	(@NA_TipoMovimiento	= 'V'	OR Tipo_movimiento	 = @Tipo_movimiento	)
	AND	(@NA_TipoOperacion	= 'V'	OR Tipo_operacion	 = @Tipo_Operacion	)
	AND	(@NA_Tipo_Intrumento	= 'V'	OR TipoInstrumento	 = @Tipo_Instrumento	)
	AND	(@NA_Moneda		= 'V'	OR Moneda		 = @Moneda		)
	AND	(@NA_Tipo_Emisor	= 'V'	OR TipoEmisor		 = @Tipo_Emisor		)
	AND	(@NA_Origen_Emisor	= 'V'	OR OrigenEmision	 = @Origen_Emisor	)
	AND	(@NA_Cubierto		= 'V'	OR ObjetoCubierto	 = @Objeto_Cubierto	)
	AND	(@NA_Contraparte	= 'V'	OR Contraparte		 = @Contraparte		)
	AND	(@NA_Desde_Hasta	= 'V'	OR (Desde		>= @Desde	AND Hasta	<= @Hasta ))
	AND	 CarteraNormativa	= @Cartera_Super
	AND	(@NA_SubCartera		= 'V'	OR SubcarteraNormativa	 = @SubCartera_Super	)

   return ( @CodClas )
END


 
GO
