USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEOPERACIONES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_leeoperaciones    fecha de la secuencia de comandos: 05/04/2001 13:13:36 ******/
CREATE PROCEDURE [dbo].[SP_LEEOPERACIONES]
 as 
 begin
 declare @total float
 declare @numoper numeric(10,0)
 declare @tipoper char(3)
 declare @x integer
 declare @correla  numeric(5,0)
 select @x=1
 select   'nooperacion' = MDMO.monumoper, 
    'rutcart'     = MDMO.morutcart,
   'cartera'     = MDRC.rcnombre,
   'cod_cartera' = MDMO.motipcart,
   'tip_cart'    = space(25),
   'cliente'     = VIEW_CLIENTE.clnombre,
   'tipoper'     = case MDMO.motipoper when 'CI' then 'COMPRAS CON PACTO' when 'CP' then 'COMPRAS DEFINITIVAS' when 'VP' then 'VENTAS DEFINITIVAS' when 'VI' then 'VENTAS CON PACTO' when 'IB' then 'INTERBANCARIOS' else '' end,
   'f_pago'      = VIEW_FORMA_DE_PAGO.glosa,
   'f_vto'       = isnull(convert(char(10),MDMO.mofecvenp,103),' '),   
   'moneda'      = isnull(VIEW_MONEDA .mnnemo,' '),
   'monto'       = case MDMO.motipoper when 'CI' then MDMO.movalinip when 'VI' then MDMO.movalinip when 'IB' then MDMO.movalinip when 'VP' then movpresen when 'CP' then movpresen else 0 end,
   'total'       = convert(float,0.0),
   'oper'       = MDMO.motipoper
 into #TEMP
 from --  REQ. 7619
      MDMO LEFT OUTER JOIN VIEW_MONEDA ON MDMO.momonpact = VIEW_MONEDA.mncodmon
    , VIEW_ENTIDAD MDRC
    , VIEW_CLIENTE
    , VIEW_FORMA_DE_PAGO
 --  REQ. 7619
 -- , VIEW_MONEDA
 where (MDMO.motipoper ='VP' or MDMO.motipoper='VI' or MDMO.motipoper='CI' or MDMO.motipoper='CP' or MDMO.motipoper='IB')
 and MDMO.mostatreg <> 'A'
 and MDMO.morutcart =MDRC.rcrut
 and MDMO.morutcli = VIEW_CLIENTE.clrut
 and MDMO.moforpagi = convert(numeric(6),VIEW_FORMA_DE_PAGO.codigo)
--  REQ. 7619
-- and MDMO.momonpact *= VIEW_MONEDA.mncodmon
 order by MDMO.monumoper
 update #TEMP
 set #TEMP.tip_cart = VIEW_TABLA_GENERAL_DETALLE.tbglosa
 from   #TEMP, VIEW_TABLA_GENERAL_DETALLE
 where  VIEW_TABLA_GENERAL_DETALLE.tbcateg=204
 and    #TEMP.cod_cartera = convert(numeric(6),VIEW_TABLA_GENERAL_DETALLE.tbcodigo1)
 select * into #TEMP1
 from #TEMP
 while @x = 1
 begin
  if exists ( select * from #TEMP1)
         begin
   set rowcount 1
 
   select @numoper = #TEMP1.nooperacion, @tipoper= isnull(#TEMP1.oper,'*')
   from #TEMP1
   set rowcount 0
   
   if @tipoper='*' break
   
   select @total = sum(#TEMP1.monto)
   from  #TEMP1
   where @numoper= #TEMP1.nooperacion
   and   @tipoper= #TEMP1.oper
   delete from #TEMP1
   where @numoper= #TEMP1.nooperacion
   and   @tipoper= #TEMP1.oper
   update #TEMP
   set #TEMP.total = @total
   from #TEMP
   where @numoper= #TEMP.nooperacion
   
   continue
  end
  else
   break
 end
 select  distinct nooperacion,
  rutcart,
  cartera, 
  tip_cart,
  cliente,
  tipoper,
  moneda,
  f_pago,
  f_vto,
  total,
  oper
 from #TEMP
end  
-- select * from #TEMP1
-- drop table #TEMP
--dump transaction tempdb with no_log
       


GO
