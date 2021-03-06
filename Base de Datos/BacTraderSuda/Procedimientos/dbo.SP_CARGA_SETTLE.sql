USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_SETTLE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGA_SETTLE] 
as
begin
set nocount on
 select
  'nombre'  = isnull(c.clnombre,'')  ,
  'productos' = case a.productos when 'BCC' then 'SPOT' when 'BTR' then 'SECURITIES' else '' end, -- s.nombre_sistema  ,
  'mtootorgado' = a.monto_asignado  ,
  'dia0'  = a.dia0_ocupado  ,
  'dia1'  = a.dia1_ocupado  ,
  'dia2'  = a.dia2_ocupado  ,
  'dia3'  = a.dia3_ocupado  ,
  'dia4'  = a.dia4_ocupado  ,
  'rut'  = a.rut    ,
  'codigo' = a.codigo   ,
  'codprod' = a.PRODUCTOs
 from 
  MD_SETTLEMENT  a,
  VIEW_CLIENTE c,
  VIEW_SISTEMA_CNT  s
 where 
  c.clrut     = a.rut
 and c.clcodigo  = a.codigo
 and  a.PRODUCTOs = s.id_sistema
 order by
  c.clnombre ,
  a.PRODUCTOs
   
      
end   /* fin procedimiento */


GO
