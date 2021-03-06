USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_PERFILES4]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORME_PERFILES4](@id  char(3))
AS
BEGIN
 set nocount on
 declare @numero float
 select @numero = count(*) from view_perfil_cnt where id_sistema = @id
 select p.folio_perfil,
 p.tipo_voucher,
 p.glosa_perfil ,
 f.correlativo_perfil,
          'campo' = isnull((select distinct descripcion_campo from view_campo_cnt a where a.codigo_campo = f.codigo_campo and a.id_sistema = @id ),''),
    f.tipo_movimiento_cuenta ,
    f.perfil_fijo,
           f.codigo_cuenta     ,
    'cuenta' = isnull(b.descripcion ,''),
           'campo_variable' = isnull((select distinct descripcion_campo from view_campo_cnt a where a.codigo_campo = f.codigo_campo_variable and a.id_sistema = @id),''),
    @numero         
  from  --  REQ. 7619
        view_perfil_detalle_cnt f RIGHT OUTER JOIN view_plan_de_cuenta b ON b.cuenta = codigo_cuenta ,
        view_perfil_cnt p 
--  REQ. 7619
--      view_plan_de_cuenta b
  where p.id_sistema = @id 
  and f.folio_perfil = p.folio_perfil
--  REQ. 7619
--  and   b.cuenta =* codigo_cuenta
  order by p.folio_perfil,f.correlativo_perfil  set nocount off
end


GO
