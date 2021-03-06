USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_UI_REPORTES_ACTIVOS_RCM]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_UI_REPORTES_ACTIVOS_RCM]
(
	@accion  int = 1,
	@id_reporte int = 0
)
as
begin
	/*
	@accion:
		1 = MUESTRA TIPO DE REPORTES PARA SGRU(EN RELACION A LA TABLA TBL_MODULOS_FUSION Y TBL_REPXMOD_FUSION)
		2 = MUESTRA TIPO DE REPORTES DEL SISTEMA
		3 = MUESTRA TIPO DE MODULOS DEL SISTEMA
		4 = MUESTRA REPORTES ACTIVOS DEL SISTEMA, EN BASE A @ID_REPORTE
		5 = MUESTRA TIPO DE REPORTES ACTIVOS PARA WINDOWS SERVICE FMD
		 (EN RELACION A LA TABLA TBL_MODULOS_FUSION Y TBL_REPXMOD_FUSION)
	*/

	
	if (@accion = 1) begin
		-- MUESTRA TIPO DE REPORTES 
		select 
		id_reporte, 
		desc_reporte as value
		,(case desc_reporte 
			when 'STK' then 'STOCK'
			when 'RNT' then 'RENTABILIDAD'
			else desc_reporte
			end
			) as field
		from TBL_REPORTES_FUSION with(nolock) 
		where id_reporte in (
			select distinct id_reporte 
			from TBL_REPXMOD_FUSION with(nolock) 			
		)
	end 
	else 
	if(@accion = 2) begin
		-- MUESTRA TIPOS DE REPORTES DEL SISTEMA
		select id_reporte,desc_reporte from TBL_REPORTES_FUSION with(nolock)				
	end
	else
	if(@accion = 3) begin
		-- MUESTRA TIPOS DE MODULOS DEL SISTEMA
		select * from TBL_MODULO_FUSION with(nolock)
	end
	if(@accion = 4) begin
		-- MUESTRA REPORTES ACTIVOS DEL SISTEMA, EN BASE A @ID_REPORTE
		if(@id_reporte = 0) begin
			exec SP_MODULOS_RCM 
		end 
		else 
		begin
			exec SP_MODULOS_RCM @id_reporte = @id_reporte
		end		
	end
	if(@accion = 5) begin
		select 
		id_reporte, 
		desc_reporte,
		error_code		
		from TBL_REPORTES_FUSION with(nolock) 
		where id_reporte in (
			select distinct id_reporte 
			from TBL_REPXMOD_FUSION with(nolock) 			
			where active='true'
		)		
	end

end
GO
