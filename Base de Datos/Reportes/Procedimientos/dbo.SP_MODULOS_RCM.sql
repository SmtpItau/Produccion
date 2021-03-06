USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_MODULOS_RCM]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_MODULOS_RCM](
	@id_reporte int = null,
	@modulo varchar(50) = null 
)
as
begin

if (isnull(@id_reporte,-1) = -1 and isnull(@modulo,'-1') = '-1')begin
   print 'todos'
   SELECT 
   TMF.id_modulo,
   TRF.id_reporte,
   TMF.modulo,
   TMF.modulo_h,
   TMF.modulo_desc as desc_modulo,
   TMF.export_engine,
   TR.starting,
   TR.finish,
   TR.[priority],
   TR.process,
   TR.require,
   TR.active,
   TR.special_mode,
   TR.require_ny,
   TR.db_connection
   FROM dbo.TBL_REPORTES_FUSION TRF 
   INNER JOIN dbo.TBL_REPXMOD_FUSION TR ON TRF.id_reporte = TR.id_reporte 
   INNER JOIN dbo.TBL_MODULO_FUSION TMF ON TMF.id_modulo = TR.id_modulo    
   order by trf.id_reporte,tr.[priority] asc
		
	RETURN
end 

if(isnull(@id_reporte,-1) = -1 and isnull(@modulo,'-1') <> '-1') begin
	print 'por nombre de modulo'
	SELECT 
   TMF.id_modulo,
   TRF.id_reporte,
   TMF.modulo,
   TMF.modulo_h,
   TMF.modulo_desc as desc_modulo,
   TMF.export_engine,
   TR.starting,
   TR.finish,
   TR.[priority],
   TR.process,
   TR.require,
   TR.active,
   TR.special_mode,
   TR.require_ny,   
   TR.db_connection
   FROM dbo.TBL_REPORTES_FUSION TRF 
   INNER JOIN dbo.TBL_REPXMOD_FUSION TR ON TRF.id_reporte = TR.id_reporte 
   INNER JOIN dbo.TBL_MODULO_FUSION TMF ON TMF.id_modulo = TR.id_modulo 
   where TMF.modulo = @modulo
   order by trf.id_reporte,tr.[priority] asc
   return
end

if(isnull(@id_reporte,-1) <> -1 and isnull(@modulo,'-1') = '-1') begin
	print 'por id reporte'
 SELECT 
   TMF.id_modulo,
   TRF.id_reporte,
   TMF.modulo,
   TMF.modulo_h,
   TMF.modulo_desc as desc_modulo,
   TMF.export_engine,
   TR.starting,
   TR.finish,
   TR.[priority],
   TR.process,
   TR.require,
   TR.active,
   TR.special_mode,
   TR.require_ny,
   TR.db_connection
   FROM dbo.TBL_REPORTES_FUSION TRF 
   INNER JOIN dbo.TBL_REPXMOD_FUSION TR ON TRF.id_reporte = TR.id_reporte 
   INNER JOIN dbo.TBL_MODULO_FUSION TMF ON TMF.id_modulo = TR.id_modulo 
   where TRF.id_reporte = @id_reporte
   order by trf.id_reporte,tr.[priority] asc
   return
END

END
GO
