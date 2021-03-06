USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_DETALLE_PERFILES]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCAR_DETALLE_PERFILES] --38
               ( @numero numeric(10) )
as 
begin  
   
select a.*,
       c.descripcion_campo ,
       isnull(d.descripcion,'NO EXISTE') 
  from -- VIEW_PERFIL_DETALLE_CNT a,  --  REQ. 7619
       VIEW_PERFIL_CNT b,
       VIEW_CAMPO_CNT c,
       --  REQ. 7619
       VIEW_PLAN_DE_CUENTA d  RIGHT OUTER JOIN VIEW_PERFIL_DETALLE_CNT a ON d.cuenta = a.codigo_cuenta
 where a.folio_perfil    = @numero
--   AND c.id_sistema      = b.id_sistema
   and b.folio_perfil    = @numero
   and c.tipo_operacion  = b.tipo_operacion
   and c.codigo_campo    = a.codigo_campo
 --  REQ. 7619
 --   and d.cuenta          =* a.codigo_cuenta
 order by a.correlativo_perfil
end   /* fin procedimiento */
/*
 sp_buscar_perfiles 1002
 sp_buscar_detalle_perfiles 1002 
 sp_buscar_perfiles 3
 select * from bac_cnt_campos
 select * from CON_PLAN_CUENTAS
select * from bac_cnt_perfil_detalle where folio_perfil=1
*/
--select * from BAC_CNT_PASO

-- select * from view_perfil_cnt




GO
