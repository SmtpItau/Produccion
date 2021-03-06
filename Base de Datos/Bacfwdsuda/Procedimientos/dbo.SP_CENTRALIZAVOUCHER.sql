USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CENTRALIZAVOUCHER]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CENTRALIZAVOUCHER]
AS
BEGIN
SET NOCOUNT ON
--select * from voucher_cnt
--select * from voucher_cnt where left(Tipo_Operacion,2)='D3'
--select * from detalle_voucher_cnt
--select * from view_perfil_cnt where tipo_movimiento='DEV'   and id_sistema='BFW'
--select * from view_perfil_detalle_cnt  where folio_perfil=278
DECLARE @dFechaPro DATETIME
DECLARE @cBanco    CHAR (60)
DECLARE @nRut      NUMERIC(9)
DECLARE @nObsDia   NUMERIC(10,2)
DECLARE @nUFDia    NUMERIC(12,4)
DECLARE @cDig      CHAR(1)
SELECT  @dFechaPro= acfecproc,@cBanco=acnomprop,@nRut=acrutprop,@cDig=acdigprop FROM MFAC     
SELECT  @nObsDia  = isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmcodigo=994 and vmfecha = @dFechaPro),0)
SELECT  @nUFDia   = isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmcodigo=998 and vmfecha = @dFechaPro),0)  
   SELECT     'Numero_Voucher' = 0,
              'Correlativo'    = 0,
              'Cuenta'         = a.Cuenta ,
              'Glosa      '   = Space(60),
              'Moneda_perfil'  = 0,
              'Folio_Perfil'   = d.folio_perfil,
              'Tipo_Monto'     = a.Tipo_Monto ,
              'Monto'          = ABS( SUM( ISNULL(a.Monto,0.0 ) ) ),
              'Moneda'         = 999,
              'Operacion'      = 0,
              'Nombre'         = @cBanco,
              'Rut'            = @nRut,
              'Digito'         = @cDig,
              'ObsDia'         = @nObsDia,
              'UFDia'          = @nUFDia ,
              'Nombre_Cliente' = SPACE(60),
              'Direccion_Cliente' = SPACE(60),
              'Rut_Cliente'     = 0,
              'Digito_Cliente'  ='     ',
              'Fecha_Proceso'   = Convert(char(10),@dFechaPro,103),
              'Glosa_Cuenta'    = Space(60),
              'Codigo_producto' = 0 ,
              'Tipo_Mov'        = SPACE(4),
              'Fecha_Inicio'    = Convert(char(10),@dFechaPro,103),
              'Fecha_Vcto'      = Convert(char(10),@dFechaPro,103)
              
   INTO     #tmpdetallevoucher
   FROM     detalle_voucher_cnt a, voucher_cnt b ,view_plan_de_cuenta c,view_perfil_cnt d
   WHERE    a.numero_voucher = b.numero_voucher AND  a.cuenta=c.cuenta AND  
            left(b.tipo_operacion,1)='D' And Fecha_Ingreso=@dFechaPro  AND
            b.folio_perfil=d.folio_perfil  
                     
   GROUP BY d.folio_perfil,a.cuenta  ,a.Tipo_Monto   --, a.moneda


update #tmpdetallevoucher  set Glosa=glosa_perfil ,Moneda_perfil=codigo_instrumento,Tipo_Mov =tipo_operacion   from view_perfil_cnt where  #tmpdetallevoucher.folio_perfil=view_perfil_cnt.folio_perfil
insert into #tmpdetallevoucher Select a.numero_voucher,
                                      a.correlativo,
                                      a.cuenta,
                                      b.glosa,
                                      0,
                                      b.folio_perfil,
                                      a.tipo_monto,
                                      a.monto ,
                                      isnull(a.moneda,0),
                                      b.operacion,
                                      @cBanco,
                                      @nRut,
                                      @cDig,
                                      @nObsDia,
                                      @nUFDia,
                                     (Select clnombre from view_cliente where (c.cacodigo=clrut and c.cacodcli=clcodigo)),
                                     (Select cldirecc from view_cliente where (c.cacodigo=clrut and c.cacodcli=clcodigo)),
                                     (Select clrut    from view_cliente where (c.cacodigo=clrut and c.cacodcli=clcodigo)),
                                     (Select cldv     from view_cliente where (c.cacodigo=clrut and c.cacodcli=clcodigo)),
                                     Convert(char(10),@dFechaPro,103),
                                     Space(60),
                                     0 ,  
                                     b.tipo_operacion,
                                     Convert(char(10),@dFechaPro,103), 
                                     Convert(char(10),@dFechaPro,103)
 
                               From  detalle_voucher_cnt a, voucher_cnt b ,Mfca c 
                               Where a.numero_voucher = b.numero_voucher and c.canumoper=b.operacion  
                                    
          
update #tmpdetallevoucher  set Glosa_cuenta = descripcion  from      view_plan_de_cuenta  where #tmpdetallevoucher.cuenta =view_plan_de_cuenta.cuenta
update #tmpdetallevoucher  set Codigo_producto = cacodpos1, Fecha_inicio= Convert(char(10),cafecha,103) ,Fecha_Vcto=Convert(char(10),cafecvcto,103) from  mfca  where #tmpdetallevoucher.operacion =mfca.canumoper and left(#tmpdetallevoucher.operacion,1)<>'D'
Select * from #tmpdetallevoucher  order by Folio_Perfil ,Numero_Voucher,correlativo
SET NOCOUNT OFF
END

GO
