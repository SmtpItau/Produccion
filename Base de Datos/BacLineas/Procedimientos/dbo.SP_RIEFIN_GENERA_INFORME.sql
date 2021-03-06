USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_GENERA_INFORME]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_GENERA_INFORME]
	-- Add the parameters for the stored procedure here
AS
BEGIN
    -- SP_RIEFIN_GENERA_INFORME
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    declare @Ramonada numeric(1)

    declare @fecha datetime

    SELECT @Fecha = acFecProc
      FROM bactradersuda..mdac   -- select * from bactradersuda..mdac

    select  @Ramonada = 0
    select @Ramonada = 1 from TBL_RIEFIN_General_REC_FIL 
    WHERE Fecha =  @Fecha  and Vehiculo = 'CCB'
    
    if @Ramonada = 1 
		SELECT
			*
		FROM
			TBL_RIEFIN_General_REC_FIL 
		WHERE Fecha =  @Fecha  and Vehiculo = 'CCB'
    else
      select Fecha   = '19000101'
            , Rut    = 0
            , Codigo = 0
            , Codigo_Metodologia = 0
            , Nombre = 'NO HAY RESULTADOS'
            , Linea  = 0
            , Treshold = 0
            , Valor_mercado = 0
            , Exposicion_Maxima = 0
            , VaR90D  = 0
            , AddOnAlVcto = 0
            , Garantia_Ejecutada = '' 
            , Consumo_Linea = 0         
            , Holgura = 0
            , Estado_Linea = 'SIN DATOS'
            , Rec_Tradicional = 0
            , Met_ConNettingConTreshold = 0
            , Met_ConNettingSinTreshold = 0
            , Tipo_Cambio = 0
            , Vehiculo = 'CCB'         

END

GO
