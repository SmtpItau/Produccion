USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROCESO_REPORTES]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_PROCESO_REPORTES]
(	
	@id_reporte int,
	@id_modulo int,
	@fecha_proc datetime,
	@procesado bit,		
	@opcion int,
	@proc_detalle varchar(8000) = null	
)
as
begin
	set nocount on
	/*
	opcion:
		- 0: verificacion
		- 1: insercion
		- 2: actualizacion
	*/
					
	declare @exists int
	declare @ejecucion int
	declare @inidia bit
	declare @findia bit
	declare @aux_procesado bit

	/* verificacion si existe o no el registro */
	set @exists = (select top 1 1 from TBL_PROCESO_REPORTES with (nolock) 
					where 
					id_reporte = @id_reporte 
					and id_modulo = @id_modulo
					and proc_fecha = @fecha_proc										
					)
	
	
	--> opcion:  0:verificacion 1:insercion,2:actualizacion
	if(@opcion=0) begin
		
		select top 1 
		id_reporte 
		,id_modulo   			  
		,proc_fecha              
		,procesado 		
		,fecha_reg               
		,proc_detalle			
		from TBL_PROCESO_REPORTES with(nolock)
		where
		id_modulo=@id_modulo
		and id_reporte=@id_reporte
		and proc_fecha = @fecha_proc

	end else if(@opcion=1) begin
		if(@exists=1) begin
			select top 1 
			id_reporte 
			,id_modulo   			  
			,proc_fecha              
			,procesado 			
			,fecha_reg               
			,proc_detalle			
			from TBL_PROCESO_REPORTES with(nolock)
			where
			id_modulo=@id_modulo
			and id_reporte=@id_reporte
			and proc_fecha = @fecha_proc				
		end else begin
			insert TBL_PROCESO_REPORTES values (@id_reporte,@id_modulo,@fecha_proc,@procesado,getdate(),@proc_detalle)	
			select top 1 
			id_reporte 
			,id_modulo   			  
			,proc_fecha              
			,procesado 
			,fecha_reg               
			,proc_detalle			
			from TBL_PROCESO_REPORTES with(nolock)
			where
			id_modulo=@id_modulo
			and id_reporte=@id_reporte
			and proc_fecha = @fecha_proc	
		end
	end 
	else if(@opcion=2) begin		
		if(@exists=1) begin
			update TBL_PROCESO_REPORTES
			set procesado = @procesado
				,fecha_reg = getdate()
				,proc_detalle = @proc_detalle
			where 
				id_reporte = @id_reporte
				and id_modulo = @id_modulo
				and proc_fecha = @fecha_proc
		end else BEGIN
			insert TBL_PROCESO_REPORTES values (@id_reporte,@id_modulo,@fecha_proc,@procesado,getdate(),@proc_detalle)	
		end
		
		select top 1 
			 id_reporte 
			,id_modulo   			  
			,proc_fecha              
			,procesado 			
			,fecha_reg               
			,proc_detalle			
			from TBL_PROCESO_REPORTES with(nolock)
			where
			id_modulo=@id_modulo
			and id_reporte=@id_reporte
			and proc_fecha = @fecha_proc	
	end
end

GO
