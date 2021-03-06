USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CURVAS_FORWARD_RF]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CURVAS_FORWARD_RF]
(    @Modulo     varchar(5) 
   , @Producto    numeric(5) -- 11 o 10 
   , @Moneda1     numeric(5)
   , @Moneda2     numeric(5) 
   , @Serie       char(12)  
)
As Begin
    
	-- Dbo.SP_RIEFIN_CURVAS_FORWARD_RF 'FWD', 10,  999, 999 , 'CERO'
    -- Dbo.SP_RIEFIN_CURVAS_FORWARD_RF 'FWD', 11,  13, 13 , ''
	/****** Object:  StoredProcedure [dbo].[CONSULTA_CARTERA_SWAP]    Script Date: 03/25/2011 19:27:08 ******/
    SET NOCOUNT ON  
    declare @Hay   numeric(2)
    select  @Hay = 0
    select  @Hay = 1
	from
			ParametrosdboParametrizacion_RF PARAM_RF              --- select * from baclineas..ParametrosdboParametrizacion_RF
		,	ParametrosdboParametrizacion_Curvas PARAM_CURVAS             -- select codigo, * from ParametrosdboParametrizacion_Curvas
		,	ParametrosdboParametrizacion_Fwd_RF_Fmto FINANCIAMIENTO      -- select * from baclineas..ParametrosdboParametrizacion_Fwd_RF_Fmto
		,	ParametrosdboParametrizacion_Curvas PARAM_CURVA_FINANCIAMIENTO
		where    
		    ( PARAM_RF.Serie = @Serie or ( @Producto = 11 and PARAM_RF.Serie = '*' ) )
		AND PARAM_RF.Curva = PARAM_CURVAS.Curva
		AND PARAM_CURVAS.Producto = 'RF'
		AND FINANCIAMIENTO.Codigo_Moneda_BAC = @Moneda1
		AND PARAM_CURVA_FINANCIAMIENTO.Curva = FINANCIAMIENTO.Curva



    if @Hay = 0 
		begin
			select [Tasa Subyacente] = -10, [Tasa Financiamiento] = -10
            -- select * from debug_valores
            Insert into debug_valores select substring( @Modulo, 1, 3) 
                                          + ' Moneda ' + convert( varchar(4), @Moneda1 )
                                          + ' Serie   ' + convert( varchar(4), @Serie )
                                          , 0, 'CURVA NO EXISTE', 0
		end
    else
        select 
			[Tasa Subyacente] = PARAM_CURVAS.Codigo
		,	[Tasa Financiamiento] = PARAM_CURVA_FINANCIAMIENTO.Codigo

        from
			ParametrosdboParametrizacion_RF PARAM_RF              --- select * from baclineas..ParametrosdboParametrizacion_RF
		,	ParametrosdboParametrizacion_Curvas PARAM_CURVAS
		,	ParametrosdboParametrizacion_Fwd_RF_Fmto FINANCIAMIENTO      -- select * from baclineas..ParametrosdboParametrizacion_Fwd_RF_Fmto
		,	ParametrosdboParametrizacion_Curvas PARAM_CURVA_FINANCIAMIENTO
		where    
		     ( PARAM_RF.Serie = @Serie or ( @Producto = 11 and PARAM_RF.Serie = '*' ))
		AND PARAM_RF.Curva = PARAM_CURVAS.Curva
		AND PARAM_CURVAS.Producto = 'RF'
		AND FINANCIAMIENTO.Codigo_Moneda_BAC = @Moneda1
		AND PARAM_CURVA_FINANCIAMIENTO.Curva = FINANCIAMIENTO.Curva


End
GO
