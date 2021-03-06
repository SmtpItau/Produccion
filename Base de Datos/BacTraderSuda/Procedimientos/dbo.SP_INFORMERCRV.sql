USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORMERCRV]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_INFORMERCRV] 
     (@ctipoper char(03),
     @entidad numeric(9))
as
begin
         set nocount on
 declare @rutprop numeric (10,0) ,
  @dvprop  char (01) ,
  @nomprop char (40) ,
  @fecpro  char (10) ,
  @contador numeric (10,0)
 select @rutprop = acrutprop , 
  @dvprop  = acdigprop ,
  @nomprop = acnomprop ,
  @fecpro  = convert(char(10),acfecproc,103)
 from MDAC
 select @contador = 0
 select @contador = count(*) from MDMO where motipoper=@ctipoper
 select 'fecha'=@fecpro        ,
  'cliente'=clnombre       ,
  'movalvenp'=sum(movalvenp)      ,
  'titulo'=case 
   when isnull(@ctipoper,'')='RC' then 'VENTAS CON PACTO(RECOMPRAS)'
   when isnull(@ctipoper,'')='RV' then 'COMPRAS CON PACTO(REVENTAS)'
   end        ,
  'glosa'=isnull(glosa,'')      ,
  'hora'= CONVERT(varchar(30), getdate(),108)      ,
  'cuenta'=Clctacte       ,
  'forpag'=moforpagv   ,         
  'Numoper'= monumoper ,
                'FecIniPac'=  CONVERT(varchar(10), mofecinip,103),
  'TasaPacto'=motaspact,
  'MonedaPacto'=mnnemo,
  'BANCO' = @nomprop
 into #temp1
 FROM MDMO LEFT OUTER JOIN VIEW_CLIENTE ON morutcli = clrut AND mocodcli = clcodigo
		   LEFT OUTER JOIN VIEW_ENTIDAD ON morutcart = rcrut 
, VIEW_FORMA_DE_PAGO
, VIEW_MONEDA
 WHERE motipoper = @ctipoper
 AND (isnull(moforpagv,0) = codigo and rccodcar = 1 ) 
 AND momonpact = mncodmon
 group by rcnombre,clnombre,glosa,Clctacte,moforpagv,monumoper,mofecinip,motaspact,mnnemo
 order by rcnombre,glosa,clnombre

--req.7619 cass 25-01-2011
-- from MDMO, VIEW_CLIENTE  , VIEW_ENTIDAD, VIEW_FORMA_DE_PAGO, VIEW_MONEDA
-- where morutcli*=clrut AND mocodcli*=clcodigo and morutcart*=rcrut and motipoper=@ctipoper and
--  (isnull(moforpagv,0)=codigo and rccodcar = @entidad ) AND momonpact = mncodmon
-- group by rcnombre,clnombre,glosa,Clctacte,moforpagv,monumoper,mofecinip,motaspact,mnnemo
-- order by rcnombre,glosa,clnombre


 IF (select count(*) from #temp1) = 0
 BEGIN
  insert into #temp1
  select @fecpro ,
   '' ,
   0 ,
   case  when isnull(@ctipoper,'')='RC' then 'VENTAS CON PACTO(RECOMPRAS)'
    when isnull(@ctipoper,'')='RV' then 'COMPRAS CON PACTO(REVENTAS)'
    end,
   '' ,
   CONVERT(varchar(30), getdate(),108),
   '' ,
   0 ,
   0 ,
   '',
   0,
   '',
   'BANCO' = @nomprop
 END
 UPDATE #temp1
 SET glosa=cuenta
 WHERE forpag = 6 OR forpag = 7
 SELECT * FROM #temp1 order by cliente
   set nocount off
end
--sp_informercrv 'RC',0
--sp_informercrv 'RV',0
--sp_informercrv 20
-- select moforpagi,moforpagv,* from mdmo
-- select * from view_forma_de_pago


GO
