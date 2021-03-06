USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CURVAS_DSC_FWD]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CURVAS_DSC_FWD]
(    @Modulo     varchar(5)  
   , @Moneda     numeric(5)
   , @CodigoTasa numeric(5)
   , @TipoSwap   numeric(5)
   
)
As Begin
    
	-- Dbo.SP_RIEFIN_CURVAS_DSC_FWD 'PCS', 999, 10, 1
	-- Dbo.SP_RIEFIN_CURVAS_DSC_FWD 'PCS', 999, 300, 1
	/****** Object:  StoredProcedure [dbo].[CONSULTA_CARTERA_SWAP]    Script Date: 03/25/2011 19:27:08 ******/
    SET NOCOUNT ON  
    declare @Hay   numeric(2)
    select  @Hay = 0
    select  @Hay = 1
	from
				ParametrosdboParametrizacion_Swap PARAMETRIZA_SWAP
			,	ParametrosdboParametrizacion_Curvas PARAMETRIZA_DESCTO -- select * from ParametrosdboParametrizacion_Curvas
			,	ParametrosdboParametrizacion_Curvas PARAMETRIZA_FORWARD
	where
				PARAMETRIZA_SWAP.Moneda   = @Moneda        -- Parametro
			AND	PARAMETRIZA_SWAP.Tasa     = @CodigoTasa    -- compra_codigo_tasa
			AND	PARAMETRIZA_SWAP.Producto = @TipoSwap      -- CARTERA.tipo_swap
			AND	PARAMETRIZA_DESCTO.curva  = PARAMETRIZA_SWAP.Curva_descuento
			AND	PARAMETRIZA_FORWARD.curva = PARAMETRIZA_SWAP.Curva_forward
    if @Hay = 0 
		begin
			select 'Curva Descuento ' = -10, 'Curva Forward' = -10
            -- select * from debug_valores
            Insert into debug_valores select substring( @Modulo, 1, 3) 
                                          + ' Moneda ' + convert( varchar(4), @Moneda )
                                          + ' Tasa   ' + convert( varchar(4), @CodigoTasa )
                                          + ' Tipo Swap ' + convert( varchar(4), @TipoSwap ) 
                                             , 0, 'CURVA NO EXISTE', 0
		end
    else
		select 
					'Curva Descuento' = PARAMETRIZA_DESCTO.codigo
				,	'Curva Forward' = PARAMETRIZA_FORWARD.codigo
		from
					ParametrosdboParametrizacion_Swap PARAMETRIZA_SWAP
				,	ParametrosdboParametrizacion_Curvas PARAMETRIZA_DESCTO -- select * from ParametrosdboParametrizacion_Curvas
				,	ParametrosdboParametrizacion_Curvas PARAMETRIZA_FORWARD
		where
					PARAMETRIZA_SWAP.Moneda   = @Moneda        -- Parametro
				AND	PARAMETRIZA_SWAP.Tasa     = @CodigoTasa    -- compra_codigo_tasa
				AND	PARAMETRIZA_SWAP.Producto = @TipoSwap      -- CARTERA.tipo_swap
				AND	PARAMETRIZA_DESCTO.curva  = PARAMETRIZA_SWAP.Curva_descuento
				AND	PARAMETRIZA_FORWARD.curva = PARAMETRIZA_SWAP.Curva_forward

End
GO
