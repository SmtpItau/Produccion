USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSOLIDACONTABILIDAD]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONSOLIDACONTABILIDAD]    
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

--   select * from swapgeneral
SELECT  @dFechaPro= fechaproc,
	@cBanco=nombre,
	@nRut=rut,
	@cDig=Cldv
FROM 	SwapGeneral ,
     	view_cliente 
Where	clrut = rut
and	clcodigo= codigobanco 
 
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
        'Nombre_Cliente' = SPACE(60),            --16
        'Direccion_Cliente' = SPACE(60),         --17
        'Rut_Cliente'     = 0,                   --18
        'Digito_Cliente'  =Space(1),             --19
        'Fecha_Proceso'   = Convert(char(10),@dFechaPro,103), --20
        'Glosa_Cuenta'    = Space(60),                        --21
        'Codigo_producto' = 0 ,                               --22 
        'Tipo_Mov'        = SPACE(4),                         --23
        'Fecha_Inicio'    = Convert(char(10),@dFechaPro,103), --24
        'Fecha_Vcto'      = Convert(char(10),@dFechaPro,103), --25
        'OP'              = SPACE(2),                         --26
        'T'               = Space(1),                          --27
        'MonSuper'        = Space(6)          -- REQ. 7619                --28                                                
INTO     #tmpdetallevoucher
FROM     bac_cnt_detalle_voucher a, bac_cnt_voucher b ,view_plan_de_cuenta c,view_perfil_cnt d
WHERE    a.numero_voucher = b.numero_voucher AND  a.cuenta=c.cuenta AND  
    left(b.tipo_operacion,1)='D' And Fecha_Ingreso=@dFechaPro  AND    
         b.folio_perfil=d.folio_perfil                      
GROUP BY d.folio_perfil,a.cuenta  ,a.Tipo_Monto   --, a.moneda


update #tmpdetallevoucher  set Glosa=glosa_perfil ,Moneda_perfil=codigo_instrumento,Tipo_Mov = tipo_operacion   from view_perfil_cnt where  #tmpdetallevoucher.folio_perfil=view_perfil_cnt.folio_perfil


insert into #tmpdetallevoucher 
Select distinct a.numero_voucher,
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
	(Select clnombre from view_cliente where (clrut = c.rut_cliente and clcodigo = c.codigo_cliente)),
	(Select cldirecc from view_cliente where (clrut = c.rut_cliente and clcodigo = c.codigo_cliente)),
        c.rut_cliente,
	(Select cldv from view_cliente where (clrut = c.rut_cliente and clcodigo = c.codigo_cliente)),
	Convert(char(10),@dFechaPro,103),
	Space(60),
	0 ,  
	b.tipo_operacion,
	Convert(char(10),@dFechaPro,103), 
	Convert(char(10),@dFechaPro,103),
  case when a.cuenta= '7777777' then 'OP' else Space(2)end,    
  case when left(b.tipo_operacion,1)<>'V' then 'I'  else 'V' end,    
	0                                
From  	bac_cnt_detalle_voucher a, 
	bac_cnt_voucher b ,
	cartera c 
Where   a.numero_voucher 	= b.numero_voucher and 
	convert (numeric(7),c.numero_operacion)	= convert (numeric(7),LEFT(b.operacion,LEN(b.operacion)-3)) and 
  left(b.Tipo_Operacion,1)<>'D' and    
	b.Fecha_Ingreso		= @dFechaPro  


--  select  convert (numeric(9),LEFT(b.operacion,LEN(b.operacion)-3)) from bac_cnt_voucher b
-- select distinct numero_operacion, rut_cliente, codigo_cliente from dbo.sp_help cartera
        -- select * from view_plan_de_cuenta a where  a.cuenta='2127630189' OR a.Cuenta='4127630084' OR a.Cuenta='2127631282' OR Cuenta='4127631285' oR a.Cuenta= '4127631080' OR  a.Cuenta='2127631088'    
-- select * from view_plan_de_cuenta a where  a.cuenta='1111111' OR a.Cuenta='2222222' OR a.Cuenta='3333333' OR Cuenta='4444444' oR a.Cuenta= '5555555' OR  a.Cuenta='6666666' OR  a.Cuenta='7777777'    

update #tmpdetallevoucher  set Glosa_cuenta = SUBSTRING(descripcion,1,60)
from      view_plan_de_cuenta  
where #tmpdetallevoucher.cuenta =view_plan_de_cuenta.cuenta

update #tmpdetallevoucher  set 	Codigo_producto = ca.Tipo_Swap, 
				Fecha_inicio= Convert(char(10),ca.fecha_inicio,103) ,
				Fecha_Vcto=Convert(char(10),ca.fecha_termino,103) 
from  cartera  ca
where #tmpdetallevoucher.operacion =ca.numero_operacion and 
    left(#tmpdetallevoucher.tipo_mov,1)<>'D'    

--  select  mncodfox from view_moneda where  mncodmon= 998
update #tmpdetallevoucher  set Numero_Voucher = 0
update #tmpdetallevoucher  set MonSuper = mncodfox from view_moneda where moneda=  mncodmon -- Código del Banco
-- select *   from view_moneda where mncodmon=998
-- update view_moneda set MNCODFOX = 0 where mncodmon=998
-- Actualiza el Folio
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
            WHERE numero_voucher = 0 		AND
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
--  select * from Centraliza_Voucher 

Delete  Centraliza_Voucher where FechaContable=@dFechaPro
insert into  Centraliza_Voucher  
Select  
        Numero_Voucher   ,	
        Correlativo      ,	
        Cuenta     	 ,
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
        convert (numeric(3),MonSuper), -- REQ. 7619
        @dFechaPro         
       
From    #tmpdetallevoucher a



SET NOCOUNT OFF

END
GO
