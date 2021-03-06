USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_ANTICIPO_CAPTACIONES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_ANTICIPO_CAPTACIONES]
               (@dfecpro datetime ,
  @nrutcart numeric(10,0) ,
  @dfecvcto datetime ,
  @ftasa  float  ,
  @imoneda integer  ,
  @iforpago integer  ,
  @nrutcli numeric(09,0) ,
  @ncodcli numeric(09,0) ,
  @cretiro char(01) ,
  @nnumdocu numeric (10,0) ,
  @ncorrela_oper numeric(05,00) ,
  @ftasant  float  ,  -- tasa anticipo
  @nmontoant float  ,  -- valor en um 
  @nmontodifer float  ,  -- diferencia en $$ 
  @susuari char(20) )
as
begin
set nocount on
 declare @ftotint float ,
  @ftotrea float ,
  @ftasaori float ,
  @fcapital float ,
  @fcapitalclp float ,
  @ftipocambio  float ,
  @ftipcamini float ,
  @fvpresen float ,
  @fvalfin float ,
 
  @ibase  integer ,
  @iplazomin integer ,
  @iplazo  integer ,
  @cplazo  char(05),
  
  @dfecha_hoy  datetime,
  @dfecha_ini datetime,
  @dfecha_fin datetime
 select @dfecha_hoy = acfecproc from MDAC 
 select @ibase     = mnbase from VIEW_MONEDA  where mncodmon = @imoneda  
 if @imoneda = 999 or  @imoneda = 13  
  select @ftipocambio = 1
 else 
  select @ftipocambio = vmvalor from VIEW_VALOR_MONEDA where vmcodigo = @imoneda  and vmfecha = @dfecha_hoy
     /* obtengo plazo minimo de la operaci¢n segun la moneda que tiene asociada */
 select @cplazo  =  case @imoneda  
     when  999 then 'cap$$' 
     when  998 then 'capuf' 
     else  'capdo'  end
      
 select @iplazomin = folio from GEN_FOLIOS where codigo = @cplazo 
 
     /* saco datos originales de la captaci¢n  */
 select 
  @ftotint  = isnull(interes_acumulado,0)  ,
  @ftotrea  = isnull(reajuste_acumulado,0) ,
  @ftasaori = tasa    ,
  @fcapital = monto_inicio   ,
  @fvpresen = valor_presente   ,
  @dfecha_ini = fecha_operacion  ,
  @dfecha_fin = fecha_vencimiento  ,
  @fvalfin = monto_final      
 from 
  GEN_CAPTACION
 where 
  numero_operacion  = @nnumdocu   
 and correla_operacion = @ncorrela_oper
 if @imoneda = 999 or  @imoneda = 13  
  select @ftipcamini = 1
 else 
  select @ftipcamini = vmvalor from VIEW_VALOR_MONEDA where vmcodigo = @imoneda  and vmfecha = @dfecha_ini
 select @fcapitalclp =  round(@fcapital*@ftipcamini,0) 
 insert into 
 MDMO(
  mofecpro   , -- 1
  morutcart   , -- 2
  motipcart   , -- 3
  monumdocu   , -- 4
  mocorrela   , -- 5
  motipoper   , -- 6 
  moinstser   , -- 7
  momascara   , -- 8
  mocodigo   , -- 9
  moseriado   , -- 10
  mofecemi   , -- 11
  mofecven   , -- 12
  momonemi   , -- 13
  mobasemi   , -- 14
  monominal   , -- 15
  movpresen   , -- 16
  mofecinip   , -- 18
  mofecvenp   , -- 19
  movalinip   , -- 20
  movalvenp   , -- 21
  motaspact   , -- 22
  mobaspact   , -- 23
  momonpact   ,
  moforpagi   ,
  moforpagv   ,
  mopagohoy   ,
  morutcli   ,
  mocodcli   ,
  motipret   ,
  mohora    ,
  mousuario   ,
  moterminal   ,
  movalcomp   ,
  monumdocuo   ,
  mocorrelao   ,
  monumoper   ,
  motipopero   ,
  monominalp   ,
  mostatreg    ,
  mointpac   ,
  moreapac   ,
  moutilidad   ,
  moperdida   ,
  motasant    ,
  movalant    ,
  movpressb                ,
  mointeres   
     )
 values 
     (
  @dfecpro   ,
  @nrutcart   ,
  0    ,
  @nnumdocu   ,
  @ncorrela_oper   ,
  'aic'    ,
  'cap'          ,
  'cap'    ,
  0    , 
  'n'    ,
  @dfecha_ini   ,
  @dfecha_fin   ,
  @imoneda   ,
  @ibase    ,
  @fcapital   ,
  @fvpresen   ,
  @dfecha_ini   ,
  @dfecpro   ,
  @fcapitalclp   ,
  @fvalfin   ,
  @ftasaori   ,
  @ibase    ,
  @imoneda   ,
  @iforpago   , 
  @iforpago   ,  -- pago vencimiento 
  'n'    ,
  @nrutcli   ,
  @ncodcli   ,
  @cretiro   ,
  convert(char(15),getdate(),108) ,
  @susuari   ,
  'terminal 1'   ,
  @fcapitalclp   ,
  @nnumdocu   ,
  @ncorrela_oper   ,
  @nnumdocu   ,
  'ic'    ,
  0    ,
  ' '    ,
  @ftotint   ,
  @ftotrea   ,
  case when @nmontodifer > 0 then @nmontodifer      else 0 end,
  case when @nmontodifer < 0 then abs(@nmontodifer) else 0 end,
  @ftasa    ,
  round(@nmontoant*@ftipocambio,0),
  @nmontoant   ,
  ( (round(@nmontoant*@ftipocambio,0)-@fcapitalclp) - @ftotrea )
  )
 if @@error<> 0 
 begin
  --rollback transaction  
               set nocount off
  SELECT 'NO', 0,'PROBLEMAS EN GRABACI¢N DE ANTICIPO DE CAPTACI¢N, << MOVIMIENTO >>'
  return 1
 end
 update 
 GEN_CAPTACION set
  estado = 'v'
  where numero_operacion  = @nnumdocu
  and   correla_operacion = @ncorrela_oper
 if @@error<> 0 
 begin
                set nocount off
  SELECT 'NO', 0, 'PROBLEMAS EN ACTUALIZACI¢N DE ANTICIPO DE CAPTACI¢N, << CAPTACIóN >>'
  return 1
 end
        set nocount off
 select 'SI', @nnumdocu, 'ANTICIPO DE CAPTACION, GRABADO SATISFACTORIAMENTE '
 return 0
end
/*******
select * from MDMO
execute sp_graba_anticipo_captaciones '09/28/2000',78221830,'04/04/2000',1.0550, 999,2, 97011000, 1,'v', 8,1,2500000.0000,2500000,2526375.0000,2526375.0000,2500000.0000,'administra'
*******/

GO
