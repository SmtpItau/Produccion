USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CURVAS_FORWARD]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CURVAS_FORWARD]
(    @Modulo     varchar(5)  
   , @Moneda1     numeric(5)
   , @Moneda2     numeric(5)   
)
As Begin
    
	-- Dbo.SP_RIEFIN_CURVAS_FORWARD 'FWD', 13, 999 
	-- Dbo.SP_RIEFIN_CURVAS_FORWARD 'FWD', 142, 13  -- 1 y 5
	/****** Object:  StoredProcedure [dbo].[CONSULTA_CARTERA_SWAP]    Script Date: 03/25/2011 19:27:08 ******/
    SET NOCOUNT ON  
    declare @Hay   numeric(2)
    select  @Hay = 0
    select  @Hay = 1
	from
			ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_1
		,	ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_2
		,	ParametrosdboParametrizacion_Fwd PARAMETRIZA_FWD
		,	ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_1
		,	ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_2   -- select Codigo,* from parametrosdboParametrizacion_curvas where producto = 'Forward'
	where	PARAMETRIZA_MONEDA_1.Codigo_BAC = @Moneda1
		AND	PARAMETRIZA_MONEDA_2.Codigo_BAC = @Moneda2
		AND	PARAMETRIZA_FWD.Moneda_1 = @Moneda1
		AND	PARAMETRIZA_FWD.Moneda_2 = @Moneda2
		AND	PARAMETRIZA_FWD.Curva_1 = PARAMETRIZA_CURVAS_1.Curva
		AND	PARAMETRIZA_FWD.Curva_2 = PARAMETRIZA_CURVAS_2.Curva
		AND	PARAMETRIZA_CURVAS_1.Producto = 'Forward'
		AND	PARAMETRIZA_CURVAS_2.Producto = 'Forward'

    if @Hay = 0 
		begin
			select 'Curva M1' = -10, 'Curva M2' = -10
            -- select * from debug_valores
            Insert into debug_valores select substring( @Modulo, 1, 3) 
                                          + ' Moneda ' + convert( varchar(4), @Moneda1 )
                                          + ' Moneda1   ' + convert( varchar(4), @Moneda2 )
                                          , 0, 'CURVA NO EXISTE', 0
		end
    else
		select 
					'Curva M1' = PARAMETRIZA_CURVAS_1.Codigo 
				,	'Curva M2' = PARAMETRIZA_CURVAS_2.Codigo
		from
			ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_1
		,	ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_2
		,	ParametrosdboParametrizacion_Fwd PARAMETRIZA_FWD
		,	ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_1
		,	ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_2
	where	PARAMETRIZA_MONEDA_1.Codigo_BAC = @Moneda1
		AND	PARAMETRIZA_MONEDA_2.Codigo_BAC = @Moneda2
		AND	PARAMETRIZA_FWD.Moneda_1 = @Moneda1
		AND	PARAMETRIZA_FWD.Moneda_2 = @Moneda2
		AND	PARAMETRIZA_FWD.Curva_1 = PARAMETRIZA_CURVAS_1.Curva
		AND	PARAMETRIZA_FWD.Curva_2 = PARAMETRIZA_CURVAS_2.Curva
		AND	PARAMETRIZA_CURVAS_1.Producto = 'Forward'
		AND	PARAMETRIZA_CURVAS_2.Producto = 'Forward'


End
GO
