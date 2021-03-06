USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSOLIDAR_VOUCHER]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONSOLIDAR_VOUCHER]
AS
BEGIN

   SET NOCOUNT ON

DECLARE @nVoucher  NUMERIC(10)
DECLARE @nCorrela  NUMERIC(10)
DECLARE @nMonPer   NUMERIC(03)
DECLARE @cTipoMov  CHAR(04)
DECLARE @nNumOpe   NUMERIC(10)
DECLARE @dFechaPro DATETIME
DECLARE @cBanco    CHAR (60)
DECLARE @nRut      NUMERIC(9)
DECLARE @nObsDia   NUMERIC(10,2)
DECLARE @nUFDia    NUMERIC(12,4)
DECLARE @cDig      CHAR(1)

SELECT  @dFechaPro= acfecproc,@cBanco=acnomprop,@nRut=acrutprop,@cDig=acdigprop FROM MFAC     
SELECT  @nObsDia  = isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmcodigo=994 and vmfecha = @dFechaPro),0)
SELECT  @nUFDia   = isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmcodigo=998 and vmfecha = @dFechaPro),0)  

SELECT  'Numero_Voucher' = 0,                         --1
        'Correlativo'    = 0,                         --2
        'Cuenta'         = a.Cuenta ,                 --3
        'Glosa      '   = Space(80),                  --4  
        'Moneda_perfil'  = 0,                         --5
        'Folio_Perfil'   = d.folio_perfil,            --6
        'Tipo_Monto'     = a.Tipo_Monto ,             --7 
        'Monto'          = ABS( SUM( ISNULL(a.Monto,0.0 ) ) ),--8
        'Moneda'         = 999,                  --9
        'Operacion'      = 0,                    --10
        'Nombre'         = @cBanco,              --11
        'Rut'            = @nRut,                --12
        'Digito'         = @cDig,                --13 
        'ObsDia'         = @nObsDia,             --14 
        'UFDia'          = @nUFDia ,             --15
        'Nombre_Cliente'    = SPACE(60),            --16
        'Direccion_Cliente' = SPACE(60),         --17
        'Rut_Cliente'       = 0,                   --18
        'Digito_Cliente'  =Space(1),             --19
        'Fecha_Proceso'   = Convert(char(10),@dFechaPro,103), --20
        'Glosa_Cuenta'    = Space(60),                        --21
        'Codigo_producto' = 0 ,                               --22 
        'Tipo_Mov'        = SPACE(4),                         --23
        'Fecha_Inicio'    = Convert(char(10),@dFechaPro,103), --24
        'Fecha_Vcto'      = Convert(char(10),@dFechaPro,103), --25
        'OP'              = SPACE(2),                         --26
        'T'               = Space(1),                          --27
        'MonSuper'        = SPACE(20)                          --28                                                
INTO     #tmpdetallevoucher
FROM     detalle_voucher_cnt a, voucher_cnt b ,view_plan_de_cuenta c,view_perfil_cnt d
WHERE    a.numero_voucher = b.numero_voucher AND  a.cuenta=c.cuenta AND  
         left(b.tipo_operacion,1)='D' And Fecha_Ingreso=@dFechaPro  AND
         b.folio_perfil=d.folio_perfil                      
GROUP BY d.folio_perfil,a.cuenta  ,a.Tipo_Monto   --, a.moneda

update #tmpdetallevoucher  set Glosa=glosa_perfil ,Moneda_perfil=codigo_instrumento,Tipo_Mov = tipo_operacion   from view_perfil_cnt where  #tmpdetallevoucher.folio_perfil=view_perfil_cnt.folio_perfil

insert into #tmpdetallevoucher 
Select a.numero_voucher,
 a.correlativo,
 a.cuenta,
 b.glosa,
 0,
 b.folio_perfil,
 a.tipo_monto,
 a.monto ,
 a.moneda,
 b.operacion,
 @cBanco,
 @nRut,
 @cDig,
 @nObsDia,
 @nUFDia,
 (Select substring(clnombre,1,60) from view_cliente where (c.cacodigo=clrut and c.cacodcli=clcodigo)),
 (Select cldirecc from view_cliente where (c.cacodigo=clrut and c.cacodcli=clcodigo)),
        c.cacodigo,
 (Select cldv from view_cliente where (c.cacodigo=clrut and c.cacodcli=clcodigo)),
 Convert(char(10),@dFechaPro,103),
 Space(60),
 0 ,  
 b.tipo_operacion,
 Convert(char(10),@dFechaPro,103), 
 Convert(char(10),@dFechaPro,103),
 case when a.cuenta='2127630189' OR a.Cuenta='4127630084' OR a.Cuenta='2127631282' OR Cuenta='4127631285' oR a.Cuenta= '4127631080' OR  a.Cuenta='2127631088'  then 'OP' else Space(2)end,
 case when left(b.tipo_operacion,1)<>'V' then 'I'  else 'V' end,
 0                          
From   detalle_voucher_cnt a, 
 voucher_cnt b ,
 Mfca c 
Where   a.numero_voucher = b.numero_voucher and 
 c.canumoper=b.operacion and 
 left(b.Tipo_Operacion,1)<>'D' and
 b.Fecha_Ingreso=@dFechaPro  
          
 

          
update #tmpdetallevoucher  set Glosa_cuenta = substring(ltrim(rtrim(descripcion)),1,60)  
from      view_plan_de_cuenta  
where #tmpdetallevoucher.cuenta =view_plan_de_cuenta.cuenta


update #tmpdetallevoucher  set  Codigo_producto = cacodpos1, 
    Fecha_inicio= Convert(char(10),cafecha,103) ,
    Fecha_Vcto=Convert(char(10),cafecvcto,103) 
from  mfca  
where #tmpdetallevoucher.operacion =mfca.canumoper and 
      left(#tmpdetallevoucher.tipo_mov,1)<>'D'




update #tmpdetallevoucher  set Numero_Voucher = 0
----------------------------------------------------------------------------------------------------------- OK

update #tmpdetallevoucher  set MonSuper = mncodfox from view_moneda where moneda=mncodmon -- Código del Banco
--CAMPO mncodfox ES CHAR(6)
------------------------------------------------------------------------------------OK----------------------------------



SELECT @nVoucher = 0
SELECT @nNumOpe = 0
SET ROWCOUNT 1
SELECT @nMonPer  = Moneda_perfil,
       @cTipoMov = Tipo_Mov,
       @nNUmope  = operacion
       FROM #tmpdetallevoucher
       WHERE Numero_Voucher = 0
SET ROWCOUNT 0
WHILE (1=1) BEGIN
     SELECT @nVoucher = @nVoucher + 1
     UPDATE #tmpdetallevoucher SET Numero_Voucher = @nVoucher
            WHERE numero_voucher = 0   AND
    operacion = @nNumOpe          AND
                  Moneda_perfil  = @nMonPer   AND
                  Tipo_Mov       = @cTipoMov
     SELECT @nCorrela = 0
     WHILE (1=1) BEGIN
         SELECT @nCorrela = @nCorrela + 1
         SET ROWCOUNT 1
         UPDATE #tmpdetallevoucher SET Correlativo = @nCorrela
                WHERE Numero_Voucher = @nVoucher  AND
                      Correlativo    = 0          AND
                      Moneda_perfil  = @nMonPer   AND
                      Tipo_Mov       = @cTipoMov
         SET ROWCOUNT 0
         IF NOT EXISTS( SELECT correlativo FROM #tmpdetallevoucher WHERE Numero_Voucher = @nVoucher AND Correlativo = 0 AND Moneda_perfil = @nMonPer AND Tipo_Mov = @cTipoMov )
            BREAK
      END
     SELECT @nMonPer = -1
     SET ROWCOUNT 1
     SELECT @nMonPer  = Moneda_perfil,
       @cTipoMov = Tipo_Mov,
       @nNumOpe  = operacion
       FROM #tmpdetallevoucher
       WHERE Numero_Voucher = 0
     SET ROWCOUNT 0
     IF @nMonPer = -1 BREAK
END



Delete  Centraliza_Voucher where FechaContable=@dFechaPro
insert into  Centraliza_Voucher  Select  
        Numero_Voucher   , 
        Correlativo      , 
        Cuenta       ,
        Glosa            ,
        Moneda_perfil    , 
        Folio_Perfil     , 
        Tipo_Monto       ,  
        Monto             , 
        Moneda           ,
        Operacion        , 
        Nombre           ,
        Rut              ,
        Digito           , 
        ObsDia           ,
        UFDia            ,
        Nombre_Cliente   ,
        Direccion_Cliente,
        Rut_Cliente      ,
        Digito_Cliente   ,
        Fecha_Proceso    ,
        Glosa_Cuenta     ,   
        Codigo_producto  ,
        Tipo_Mov         ,
        Fecha_Inicio     ,
        Fecha_Vcto       , 
        OP               ,
        T                ,
        MonSuper         ,
        @dFechaPro         
       
From    #tmpdetallevoucher a
SET NOCOUNT OFF
END

GO
