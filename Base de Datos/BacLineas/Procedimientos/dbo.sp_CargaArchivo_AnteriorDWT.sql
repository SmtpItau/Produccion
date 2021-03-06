USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[sp_CargaArchivo_AnteriorDWT]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CargaArchivo_AnteriorDWT]
AS
BEGIN

declare @ultimaFechaCargada as datetime
	,	@FechaProceso		as datetime
	set @ultimaFechaCargada  = (select TOP 1 fechaIngreso from IngresoDWT_BacLineas order by fechaIngreso desc )
	set @FechaProceso		 = (select acfecproc from BacTraderSuda..MDAC)
	/*Cargar en tabla*/
	
	if(@ultimaFechaCargada < @FechaProceso)
	begin
			insert into IngresoDWT_BacLineas 
			(fechaIngreso, 
			 seq,
			 registro,
			 nombreArchivo)	 
			 select @FechaProceso
					, seq
					, registro
					, nombreArchivo
			   from IngresoDWT_BacLineas
			   where fechaIngreso = @ultimaFechaCargada
	
	
			if @@ERROR <> 0
			begin
				select '-1 Error en insert a Tabla IngresoDWT_BacLineas' as Resultado 
			end
			else 
			begin
				select '1 Ingreso Exitoso' as Resultado 
			end
	end 
	else 
	begin 
			select '2 El archivo ya fue cargado' as Resultado 
	end 
END

GO
