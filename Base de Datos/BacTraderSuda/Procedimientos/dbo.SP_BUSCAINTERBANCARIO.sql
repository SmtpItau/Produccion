USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAINTERBANCARIO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCAINTERBANCARIO]
     (@numoper numeric (10,0) )
as
begin
 declare @sforpai char (25) ,
  @sforpav char (25) ,
  @stipcar char (25) ,
  @nvalmon float
 if exists(select monumoper from MDMO where motipoper='IB' and monumoper=@numoper and mostatreg='A')
  SELECT 'NO',' OPERACION YA FUE ANULADA'
 else
  if not exists(select monumoper from MDMO where motipoper='IB' and monumoper=@numoper and mostatreg <>'A')
   SELECT 'NO',' OPERACION NO ES INTERBANCARIO O NO SE ENCUENTRA REGISTRADA'
 else
 begin        
  select @sforpai = glosa
  from MDMO , VIEW_FORMA_DE_PAGO 
  where motipoper='IB' and monumoper=@numoper and mostatreg<>'A' and codigo=moFORPAGi
  select @sforpav = glosa
  from VIEW_FORMA_DE_PAGO, MDMO 
  where motipoper='IB' and monumoper=@numoper and mostatreg<>'A' and codigo=moFORPAGv
/*
  SELECT @STIPCAR = TBGLOSA
  FROM VIEW_TABLA_GENERAL_DETALLE, MDMO
  WHERE MOTIPOPER='IB' AND MONUMOPER=@NUMOPER AND MOSTATREG<>'A' AND TBCATEG=204 AND CONVERT(NUMERIC(6),TBCODIGO1)=MOTIPCART
*/
  SELECT Distinct  @STIPCAR =  IsNull(rcnombre,'') 
  FROM   BacParamSuda..TIPO_CARTERA , MDMO
  WHERE  rcsistema = 'BTR' And rcrut =  MOTIPCART
   and   MOTIPOPER='IB'AND MONUMOPER=@NUMOPER AND MOSTATREG<>'A'

  select @nvalmon = 1.0
  select @nvalmon = isnull(vmvalor,0)
  from VIEW_VALOR_MONEDA, MDMO
  where motipoper='IB' and monumoper=@numoper and mostatreg<>'A' and
   (vmcodigo=momonpact and vmfecha=mofecinip) and momonpact<>999
  select 'tipoper'   = moinstser      ,
   'f.emision'   = convert(char(10),mofecemi,103)   ,
   'dias'    = convert(char(10),datediff(dd,mofecemi,mofecven)) ,
   'f.vencimiento'   = convert(char(10),mofecven,103)   ,
   'moneda'   = mnnemo      ,
   'base'    = convert(char(3),mobaspact)    ,
   'valor moneda'   = convert(char(30),@nvalmon,0)    ,
   'montoinicial'   = convert(char(20),movalinip)    ,
   'tasa'    = convert(char(20),motaspact)    ,
   'monto final'   = convert(char(20),movalvenp)    ,
   'rut cartera'   = convert(char(9),morutcart)    ,
   'digito_veri'   = rcdv       ,
   'cartera'   = rcnombre      ,
   'tipo cartera'   = @stipcar      ,
   'forma pago inicio'  = moFORPAGi,     --@sforpai
   'forma pago vencimiento' = @sforpav      ,
   'tipo retiro'   = motipret      ,
   'tipo pago'   = mopagohoy      ,
   'rut_cli'   = convert(char(9),morutcli)    ,
   'dig_cli'   = clcodigo       ,
   'nombre cliente'  = clnombre
  from MDMO, VIEW_MONEDA , VIEW_ENTIDAD, VIEW_CLIENTE
  where motipoper='IB' and monumoper=@numoper and mostatreg<>'A' and
   mncodmon=momonpact and rcrut=morutcart and clrut=morutcli
 end
      select 'OK'
end



GO
