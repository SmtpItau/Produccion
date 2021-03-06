USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerReporte]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Reportes_ObtenerReporte]      
(      
 @id_Reporte int      
)      
as      
begin      
      
set nocount on      
      
if exists (select 1 from reportes_relacion where Id_reporte = @id_Reporte)      
begin      
 
 create table  #temp1      
   (      
		descripcion     varchar(100)      
     ,  ruta			varchar(100)      
     ,  nombre_archivo  varchar(100)      
     ,  parametro		varchar(100)      
     ,  tipo_Dato		varchar(100)      
     ,  alias			varchar(100)      
     ,  id_Conexion		int      
     ,  tipo_parametro  varchar(100)      
     ,  consulta		varchar(500)      
     ,  PermiteMail		int  
     ,  mail_asunto		nvarchar(200)  
     ,  mail_body		nvarchar (500)      
   )      
 insert into #temp1      
 select  r.descripcion      
     , 'Ruta' = (select Ruta_Archivos from reportes_grupo where id_grupo =  r.id_Grupo)        
     , r.nombre_archivo      
     , rp.parametro      
     , rp.tipo_Dato      
     , rp.alias      
     , r.id_Conexion      
     , rp.tipo_parametro      
     , 'consulta' = (select consulta from reportes_consulta rc where rp.query = rc.id_consulta)      
     , r.PermiteMail  
     , r.mail_asunto  
     , mail_body  
   
   from  reportes r      
     ,	 reportes_relacion rr      
     ,	 reportes_parametros rp      
     ,	 reportes_consulta rc      
   
   where  r.id_reporte	  = @id_Reporte      
   and    r.id_reporte	  = rr.id_reporte      
   and    rp.id_parametro = rr.id_parametro      
   
      
 select * from #temp1       
 group by descripcion, ruta, nombre_archivo, parametro, tipo_Dato, alias, id_Conexion, tipo_parametro, consulta, PermiteMail, mail_asunto, mail_body      
 end      
 else      
  begin      
    Select descripcion      
     , 'ruta' =  (select Ruta_Archivos from reportes_grupo where id_grupo =  rp.id_Grupo)      
     , nombre_archivo      
     , 'parametro' = ''      
     , 'tipo_Dato' = ''      
     , 'alias'  = ''      
     ,  id_Conexion      
     , 'tipo_parametro' = ''      
     , 'consulta' = ''      
     ,  PermiteMail   
     ,  mail_asunto  
     ,  mail_body     
    from reportes rp
    where Id_reporte = @id_Reporte      
  end       
      
 end
GO
