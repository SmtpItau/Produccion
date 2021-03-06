USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONSOLIDA_REC_CCB]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CONSOLIDA_REC_CCB]
AS
BEGIN
	-- SP_RIEFIN_CONSOLIDA_REC_CCB

	SET NOCOUNT ON;
    DECLARE @Fecha    DATETIME
	DECLARE @FechaAnt DATETIME
	
	-- Importa las fechas relevantes
	SELECT
		@Fecha = acfecproc     
	,	@FechaAnt = acfecante
	FROM
		BacTraderSuda.dbo.Mdac  -- select * from BacTraderSuda..Mdac
	-- Importa las fechas relevantes
    
	DELETE TBL_RIEFIN_General_REC_FIL WHERE Fecha =  @Fecha  and Vehiculo = 'CCB'  
    
    -- Insert statements for procedure here
	INSERT TBL_RIEFIN_General_REC_FIL  
	SELECT
		Fecha  = MAXEXP.Fecha
	,	Rut    = MAXEXP.Rut
	,	Codigo = MAXEXP.Codigo
    ,   Codigo_Metodologia = 0
	,	Nombre = isnull( ClNombre, 'No está creado en BAC' )
	,	Linea  = 0
    ,   Threshold = 0		
	,	Valor_Mercado = ROUND(MAXEXP.MtM ,0)
	,	Exposicion_Maxima = ROUND(MAXEXP.Maxima_Exposicion ,0)
	,	VaR90D = ROUND(SUM(VaR90D.VaR90D) ,0)
	,	AddOnAlVcto  = ROUND(SUM(AddOnVcto.AddOnVcto) ,0)    
	,	Garantia_Ejecutada = ''
	,	Consumo_Linea = 0
	,	Holgura = 0
    ,   Estado_linea = 'Sin linea otorgada Conocida'
    ,   Rec_tradicional = ROUND(SUM( case when AddOnVcto.AddOnVcto + AddOnVcto.MtoM < 0.0 then 0.0 else AddOnVcto.AddOnVcto + AddOnVcto.MtoM end ), 0 )
    ,   Met_ConNettingConTreshold = 0.0 
    ,   Met_ConNettingSinTreshold = 0.0 
    ,   Tipo_Cambio  = 0.0
    ,   Vehiculo = 'CCB'
	FROM
		BacLineas.dbo.TBL_RieFinTabla_Max_Exp    MAXEXP  
        LEFT JOIN BacParamSuda.dbo.Cliente On ClRut = MAXEXP.Rut and ClCodigo = MAXEXP.Codigo
	,	BacLineas.dbo.TBL_RIEFIN_Tabla_VaR90D    VaR90D                           
	,   BacLineas.dbo.TBL_RIEFIN_Tabla_AddOnVcto AddOnVcto                        
    
	WHERE
        MAXEXP.Vehiculo = 'CCB'
    AND VaR90D.Vehiculo = 'CCB'
    AND AddOnVcto.Vehiculo = 'CCB'
    AND MAXEXP.fecha = @Fecha
    AND VaR90D.fecha = @Fecha
    AND AddOnVcto.fecha = @Fecha
	AND	MAXEXP.Rut = VaR90D.Rut
	AND	VaR90D.Rut = AddOnVcto.Rut
    AND MAXEXP.Codigo = VaR90D.Codigo 
    AND VaR90D.Codigo = AddOnVcto.Codigo 
    AND VaR90D.Tipo_Operacion = AddOnVcto.Tipo_operacion 
    AND VaR90D.numero_Operacion = AddOnVcto.numero_operacion

	GROUP BY
		MAXEXP.Fecha
	,	MAXEXP.Rut
    ,   MAXEXP.Codigo
	,	isnull( ClNombre, 'No está creado en BAC' )
	,	MAXEXP.MtM
	,	MAXEXP.Maxima_Exposicion
	
	
	
	-- Convierte a USD todos los montos
    -- Calcula la metodologia 1, 2, 3
    declare @Valor_USD float
    select  @Valor_USD = Tipo_Cambio from BacParamsuda..valor_moneda_contable 
        where fecha = @FechaAnt and Codigo_Moneda = 994

    
	UPDATE TBL_RIEFIN_General_REC_FIL
	SET 
        Met_ConNettingConTreshold = case when   Treshold > Valor_Mercado / @Valor_USD        
                                         then ( Exposicion_Maxima + VaR90D ) / @Valor_USD
                                         else  ( Treshold + + VaR90D ) / @Valor_USD
                                    end
    ,   Met_ConNettingSinTreshold = ( Exposicion_Maxima + AddOnAlVcto ) / @Valor_USD 
    ,   Rec_tradicional           = Rec_tradicional / @Valor_USD
    ,   Tipo_Cambio               = @Valor_USD
	WHERE
	  	 Fecha = @Fecha 
     and Vehiculo = 'CCB'
	

    
	UPDATE TBL_RIEFIN_General_REC_FIL
	SET 
        Met_ConNettingConTreshold = Case when Met_ConNettingConTreshold > 0 then Met_ConNettingConTreshold else 0 end
      , Met_ConNettingSinTreshold = Case when Met_ConNettingSinTreshold > 0 then Met_ConNettingSinTreshold else 0 end
	WHERE
	  	 Fecha = @Fecha 
     and Vehiculo = 'CCB'
	
END
GO
