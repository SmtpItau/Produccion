USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_DEVENGO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_VALIDA_DEVENGO] 
AS
BEGIN
	set nocount on
	declare @fechaProcesoLiquidacion datetime
	declare @fechaProceso datetime
	declare @HayCaja        varchar(1)
	declare @HayLiquidacion varchar(1)
	
	select @fechaProcesoLiquidacion = tbfecha from BacParamSuda.dbo.tabla_general_detalle where tbcateg = 31

    select @HayLiquidacion = 'N'
	select @HayLiquidacion = 'S', @fechaProceso = cont.fechaproc
	   from Cartera carter
	             , SwapGeneral cont
	   where carter.fechaliquidacion = cont.fechaproc

    select @HayCaja = 'N'
    select @HayCaja = 'S' 
	    from BacParamSuda.dbo.tbl_caja_derivados Caj   
		where caj.fechaLiquidacion  = @fechaProceso and caj.Modulo = 'PCS'
	
	if  @HayLiquidacion = 'S' and  @HayCaja = 'S'  
		select 'OK', ''
	else
		select 'NOK', 'Error: Falta Ejecutar Proceso de Caja' 
	-- 
END -- WHILE de Cursor



GO
