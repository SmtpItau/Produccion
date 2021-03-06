USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Recalculo_Lineas_Derivados]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Recalculo_Lineas_Derivados]  
 ( @nRutCliente numeric(15) )  
AS  
BEGIN  
  
 SET NOCOUNT ON  
  
 EXECUTE CbmdbOpc.dbo.SP_RECALCULO_LINEAS_OPCIONES_OTRO 'OPT'  
  
 declare @dFecha  datetime; set @dFecha  = (select acfecproc from BacFwdSuda.dbo.mfac with(nolock) )  
 declare @dDolarHoy Float;  set @dDolarHoy = (select vmvalor   from BacParamSuda.dbo.Valor_Moneda with(nolock)   
                    where vmfecha = @dFecha and vmcodigo = 994)  
  
 select * into dbo.tmp_Linea_Chequear from BacLineas.dbo.Linea_Chequear where 1 = 2  
   
 create clustered index ix_tmp_Modulo_Rut on tmp_Linea_Chequear (Id_Sistema, Rut_Cliente, NumeroOperacion, NumeroCorrelativo)  
  
 INSERT INTO dbo.tmp_Linea_Chequear  
 ( FechaOperacion  
 , NumeroOperacion  
 , Numerodocumento  
 , NumeroCorrelativo  
 , Rut_Cliente  
 , Codigo_Cliente  
 , Id_Sistema  
 , Codigo_Producto  
 , MontoTransaccion  
 , TipoCambio  
 , FechaVencimiento  
 , Operador  
 , Rut_Emisor  
 , Moneda_Emision  
 , FechaVctoInst  
 , InCodigo  
 , Seriado  
 , MonedaOperacion  
 , Tipo_Riesgo  
 , codigo_pais  
 , Pago_Cheque  
 , Rut_Cheque  
 , FechaVctoCheque  
 , FactorVenta  
 , FormaPago  
 , Tir  
 , TasaPacto  
 , Instser  
 , Avr  
 , PrcLCR  
 , Resultado  
 , MetodoLCR  
 , Garantia  
 , Cod_Emisor  
 )  
 SELECT  
     /*01*/ FechaOperacion  = @dFecha    
 ,   /*04*/ NumeroOperacion  = car.canumoper  
 ,   /*05*/ Numerodocumento  = car.canumoper  --> Case when @nNumdocu = 0 then @nNumoper else @nNumdocu end  
 ,   /*06*/ NumeroCorrelativo = 0     --> @nCorrela  
 ,   /*07*/ Rut_Cliente   = car.cacodigo  --> @nRutcli  
 ,   /*08*/ Codigo_Cliente  = car.cacodcli  --> @nCodigo  
 ,   /*02*/ Id_Sistema   = 'BFW'    --> case when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) NOT IN(1,4) THEN grprod.id_Grupo ELSE grprod.Id_Sistema END  
 ,   /*03*/ Codigo_Producto  = car.cacodpos1  --> @cProducto  
 ,   /*09*/ MontoTransaccion  = case when car.cacodpos1 = 2 then ((car.camtomon1 * tcambio) / @dDolarHoy)  
           when car.cacodpos1 = 3 then ((car.camtomon1 * tcambio) / @dDolarHoy)  
           when car.cacodpos1 = 10 then car.caequusd2  
           else       car.camtomon1  
          end    --> @nMonto  
 ,   /*10*/ TipoCambio   = 0.0    --> @fTipcambio  
 ,   /*11*/ FechaVencimiento  = car.cafecvcto  --> @dFecvctop  
 ,   /*12*/ Operador    = ''    --> @cUsuario  
 ,   /*13*/ Rut_Emisor   = 0     --> @nRut_emisor  
 ,   /*14*/ Moneda_Emision  = case  when Contra_Moneda  = 'S' and cacodpos1  = 2 then cacodmon1   
           when Contra_Moneda  = 'S' and cacodpos1 <> 2 then cacodmon2   
           when Contra_Moneda <> 'S'      then 0  
           else 0  
           end  
--           0     --> @nMonedaEmision  --> Contra Moneda  
  
 ,   /*15*/ FechaVctoInst  = @dFecha   --> @dFecvctoInst  
 ,   /*16*/ InCodigo    = 0     --> @nInCodigo  
 ,   /*17*/ Seriado    = 'N'    --> @cSeriado    
 ,   /*18*/ MonedaOperacion  = car.cacodmon1  --> @nMonedaOp  
 ,   /*19*/ Tipo_Riesgo   = 'C'    --> @cTipo_Riesgo  
 ,   /*20*/ codigo_pais   = 0     --> @nCodigo_pais  
 ,   /*21*/ Pago_Cheque   = car.catipoper     --> 'N'    --> @cPagoCheque  
 ,   /*22*/ Rut_Cheque   = 0     --> @nRutCheque  
 ,   /*23*/ FechaVctoCheque  = @dFecha   --> @dFecvctoCehque  
 ,   /*24*/ FactorVenta   = 0     --> @nFactorVenta  
 ,   /*25*/ FormaPago   = 0     --> @formapago  
 ,   /*26*/ Tir     = 0     --> @nTir  
 ,   /*27*/ TasaPacto   = DATEDIFF(DAY, @dFecha, cafecvcto)     --> @nTasaPact  
 ,   /*28*/ Instser    = 0     --> @cInstser  
 ,   /*29*/ Avr     = case when round(car.fres_obtenido, 0.0) > 0 then round(car.fres_obtenido, 0.0) else 0.0 end --> @Avr  
 ,   /*30*/ PrcLCR    = car.camtomon1  --> @PrcLCR  
 ,   /*31*/ Resultado   = 0     --> @Resultado  
 ,   /*32*/ MetodoLCR   = BacLineas.dbo.FN_RIEFIN_METODO_LCR     ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo )  
 ,   /*33*/ Garantia    = case when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) = 4 then  
            BacLineas.dbo.FN_RIEFIN_GARANTIA   ( Clie.clrut, Clie.clcodigo, 4, 'BFW', car.canumoper )  
             when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) = 5 then  
            BacLineas.dbo.FN_RIEFIN_GARANTIA   ( Clie.clrut, Clie.clcodigo, 4, 'BFW', car.canumoper )  
             else 0  
           end    --> @Garantia  
 , /*34*/ Cod_Emisor   = case when car.cacodpos1 = 2 then car.cacodmon2 else car.cacodmon1 end  
 from BacFwdSuda.dbo.Mfca car  
   inner join (select clrut, clcodigo, clnombre, clpais   
       from BacParamSuda.dbo.cliente with(nolock)   
        ) Clie On Clie.clrut = car.cacodigo and Clie.clcodigo = car.cacodcli  
  
   left  join (select codigo = mncodmon, tcambio = case when mncodmon = 13 then @dDolarHoy else isnull(vmvalor, 1.0) end , tipo = mnrrda  
        from BacParamSuda.dbo.Moneda  
          left join BacParamSuda.dbo.Valor_Moneda on vmfecha = @dFecha and vmcodigo = mncodmon  
        ) vmon On vmon.codigo = car.cacodmon1  
   left  join BacLineas.dbo.tbl_agrprod  grprod on grprod.Id_Sistema = 'BFW'  
  
   left join ( select clrut_padre, clcodigo_padre, clnom_Padre = clnombre, clrut_hijo, clcodigo_hijo   
        from BacLineas.dbo.cliente_relacionado  
        inner join BacParamSuda.dbo.cliente on clrut = clrut_Padre and clcodigo = clcodigo_Padre  
       ) clrel on clrel.clrut_hijo = Clie.clrut and clrel.clcodigo_hijo = Clie.clcodigo  
   left join BacParamSuda.dbo.Producto prod on prod.id_sistema = 'BFW' and prod.Codigo_producto = car.cacodpos1  
  
 where car.cafecvcto  > @dFecha  
 and ( car.cacodigo  = @nRutCliente or @nRutCliente = 0 )  
 and  car.cacodpos1  IN(1,2,3,7,10,12,11,14)  
  
 INSERT INTO dbo.tmp_Linea_Chequear  
 ( FechaOperacion  
 , NumeroOperacion  
 , Numerodocumento  
 , NumeroCorrelativo  
 , Rut_Cliente  
 , Codigo_Cliente  
 , Id_Sistema  
 , Codigo_Producto  
 , MontoTransaccion  
 , TipoCambio  
 , FechaVencimiento  
 , Operador  
 , Rut_Emisor  
 , Moneda_Emision  
 , FechaVctoInst  
 , InCodigo  
 , Seriado  
 , MonedaOperacion  
 , Tipo_Riesgo  
 , codigo_pais  
 , Pago_Cheque  
 , Rut_Cheque  
 , FechaVctoCheque  
 , FactorVenta  
 , FormaPago  
 , Tir  
 , TasaPacto  
 , Instser  
 , Avr  
 , PrcLCR  
 , Resultado  
 , MetodoLCR  
 , Garantia  
 , Cod_Emisor  
 )  
 SELECT  
     /*01*/ FechaOperacion  = @dFecha    
 ,   /*04*/ NumeroOperacion  = car.numero_operacion  
 ,   /*05*/ Numerodocumento  = car.numero_operacion  
 ,   /*06*/ NumeroCorrelativo = 0      --> @nCorrela  
 ,   /*07*/ Rut_Cliente   = car.rut_cliente  --> @nRutcli  
 ,   /*08*/ Codigo_Cliente  = car.codigo_cliente --> @nCodigo  
 ,   /*02*/ Id_Sistema   = 'PCS'  
 ,   /*03*/ Codigo_Producto  = car.tipo_swap   --> @cProducto  
 ,   /*09*/ MontoTransaccion  = car.compra_capital --> @nMonto  
 ,   /*10*/ TipoCambio   = 0.0     --> @fTipcambio  
 ,   /*11*/ FechaVencimiento  = car.Fecha_Termino  --> @dFecvctop  
 ,   /*12*/ Operador    = ''     --> @cUsuario  
 ,   /*13*/ Rut_Emisor   = 0      --> @nRut_emisor  
 ,   /*14*/ Moneda_Emision  = 0      --> @nMonedaEmision  
 ,   /*15*/ FechaVctoInst  = @dFecha    --> @dFecvctoInst  
 ,   /*16*/ InCodigo    = 0      --> @nInCodigo  
 ,   /*17*/ Seriado    = 'N'     --> @cSeriado    
 ,   /*18*/ MonedaOperacion  = car.compra_moneda  --> @nMonedaOp  
 ,   /*19*/ Tipo_Riesgo   = 'C'     --> @cTipo_Riesgo  
 ,   /*20*/ codigo_pais   = 0      --> @nCodigo_pais  
 ,   /*21*/ Pago_Cheque   = 'N'     --> @cPagoCheque  
 ,   /*22*/ Rut_Cheque   = 0      --> @nRutCheque  
 ,   /*23*/ FechaVctoCheque  = @dFecha    --> @dFecvctoCehque  
 ,   /*24*/ FactorVenta   = 0      --> @nFactorVenta  
 ,   /*25*/ FormaPago   = 0      --> @formapago  
 ,   /*26*/ Tir     = 0      --> @nTir  
 ,   /*27*/ TasaPacto   = 0      --> @nTasaPact  
 ,   /*28*/ Instser    = 0      --> @cInstser  
 ,   /*29*/ Avr     = case when round(car.Valor_RazonableCLP, 0.0) > 0 then round(car.Valor_RazonableCLP, 0.0) else 0.0 end --> @Avr  
 ,   /*30*/ PrcLCR    = 0      --> @PrcLCR  
 ,   /*31*/ Resultado   = 0      --> @Resultado  
 ,   /*32*/ MetodoLCR   = BacLineas.dbo.FN_RIEFIN_METODO_LCR   ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo )  
 ,   /*33*/ Garantia    = case when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) = 4 then  
            BacLineas.dbo.FN_RIEFIN_GARANTIA ( Clie.clrut, Clie.clcodigo, 4, 'PCS', car.numero_operacion )  
             when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) = 5 then  
            BacLineas.dbo.FN_RIEFIN_GARANTIA ( Clie.clrut, Clie.clcodigo, 4, 'PCS', car.numero_operacion )  
             else 0  
           end    --> @Garantia  
 , /*34*/ Cod_Emisor   = 0 --> case when car.cacodpos1 = 2 then car.cacodmon2 else car.cacodmon1 end  
 from BacSwapSuda.dbo.Cartera car  
  
   inner join ( select nContrato = numero_operacion, nflujo = min(numero_flujo)  
         from BacSwapSuda.dbo.Cartera where tipo_flujo = 1 and estado <> 'C' group by numero_operacion  
        ) Agrupa On Agrupa.nContrato = car.numero_operacion and Agrupa.nflujo = car.numero_flujo  
  
   inner join (select clrut, clcodigo, clnombre, clpais   
       from BacParamSuda.dbo.cliente with(nolock)   
        ) Clie On Clie.clrut = car.rut_cliente and Clie.clcodigo = car.codigo_cliente  
  
 where car.Estado      <> 'C'  
 and  car.tipo_flujo   = 1  
 and  car.Compra_Capital  > 0   
 and  car.Compra_Moneda  > 0  
 and ( car.Rut_Cliente   = @nRutCliente or @nRutCliente = 0 )  
  
  
 INSERT INTO dbo.tmp_Linea_Chequear  
 ( FechaOperacion  
 , NumeroOperacion  
 , Numerodocumento  
 , NumeroCorrelativo  
 , Rut_Cliente  
 , Codigo_Cliente  
 , Id_Sistema  
 , Codigo_Producto  
 , MontoTransaccion  
 , TipoCambio  
 , FechaVencimiento  
 , Operador  
 , Rut_Emisor  
 , Moneda_Emision  
 , FechaVctoInst  
 , InCodigo  
 , Seriado  
 , MonedaOperacion  
 , Tipo_Riesgo  
 , codigo_pais  
 , Pago_Cheque  
 , Rut_Cheque  
 , FechaVctoCheque  
 , FactorVenta  
 , FormaPago  
 , Tir  
 , TasaPacto  
 , Instser  
 , Avr  
 , PrcLCR  
 , Resultado  
 , MetodoLCR  
 , Garantia  
 , Cod_Emisor  
 )  
 SELECT  
     /*01*/ FechaOperacion  = @dFecha    
 ,   /*04*/ NumeroOperacion  = Spot.monumope  
 ,   /*05*/ Numerodocumento  = Spot.monumope  
 ,   /*06*/ NumeroCorrelativo = 0  
 ,   /*07*/ Rut_Cliente   = Spot.morutcli  
 ,   /*08*/ Codigo_Cliente  = Spot.mocodcli  
 ,   /*02*/ Id_Sistema   = 'BCC'  
 ,   /*03*/ Codigo_Producto  = Spot.motipmer  
 ,   /*09*/ MontoTransaccion  = Spot.moussme  
 ,   /*10*/ TipoCambio   = 0.0  
 ,   /*11*/ FechaVencimiento  = Spot.movaluta2  
 ,   /*12*/ Operador    = Spot.mooper  
 ,   /*13*/ Rut_Emisor   = 0  
 ,   /*14*/ Moneda_Emision  = 0  
 ,   /*15*/ FechaVctoInst  = @dFecha  
 ,   /*16*/ InCodigo    = 0  
 ,   /*17*/ Seriado    = 'N'  
 ,   /*18*/ MonedaOperacion  = 0  
 ,   /*19*/ Tipo_Riesgo   = 'C'  
 ,   /*20*/ codigo_pais   = 0  
 ,   /*21*/ Pago_Cheque   = Spot.MercadoLc  
 ,   /*22*/ Rut_Cheque   = 0  
 ,   /*23*/ FechaVctoCheque  = @dFecha  
 ,   /*24*/ FactorVenta   = 0  
 ,   /*25*/ FormaPago   = 0  
 ,   /*26*/ Tir     = 0  
 ,   /*27*/ TasaPacto   = 0  
 ,   /*28*/ Instser    = ''  
 ,   /*29*/ Avr     = 0.0  
 ,   /*30*/ PrcLCR    = 0.0  
 ,   /*31*/ Resultado   = 0.0  
 ,   /*32*/ MetodoLCR   = 1 --> 0.0  
 ,   /*33*/ Garantia    = 0.0  
 , /*34*/ Cod_Emisor   = 0  
 from ( select motipmer = motipmer  
     ,   monumope = monumope    
     ,   morutcli = morutcli    
     ,   mocodcli = mocodcli    
     ,   moussme  = moussme  
     ,   movaluta2 = movaluta2  
     ,   MercadoLc = CASE WHEN clpais = 6 THEN 'S' ELSE 'N' END    
     ,   Moneda  = 0  
     ,   mooper  = mooper  
    from BacCamSuda.dbo.Memo  
      inner join BacParamSuda.dbo.cliente on clrut = morutcli and clcodigo = mocodcli  
    where  moestatus  <> 'A'  
    and   motipope = 'C'  
    and not ( motipmer = 'ccbb' and morutcli = 97023000 )  
    and  ( morutcli = @nRutCliente or @nRutCliente = 0 )  
  
    union  
  
    select motipmer = motipmer  
     ,   monumope = monumope    
     ,   morutcli = morutcli    
     ,   mocodcli = mocodcli    
     ,   moussme  = moussme  
     ,   movaluta2 = movaluta2  
     ,   MercadoLc = CASE WHEN clpais = 6 THEN 'S' ELSE 'N' END    
     ,   Moneda  = 0  
     ,   mooper  = mooper  
    from BacCamSuda.dbo.Memo  
      inner join BacParamSuda.dbo.cliente on clrut = morutcli and clcodigo = mocodcli  
    where  moestatus  <> 'A'  
    and   motipope = 'V'  
    and not ( motipmer = 'ccbb' and morutcli = 97023000  )  
    and  ( movaluta2 <> movaluta1 and movaluta2 > movaluta1 )  
   ) Spot  
  
 /*  
 INSERT INTO dbo.tmp_Linea_Chequear  
 ( FechaOperacion  
 , NumeroOperacion  
 , Numerodocumento  
 , NumeroCorrelativo  
 , Rut_Cliente  
 , Codigo_Cliente  
 , Id_Sistema  
 , Codigo_Producto  
 , MontoTransaccion  
 , TipoCambio  
 , FechaVencimiento  
 , Operador  
 , Rut_Emisor  
 , Moneda_Emision  
 , FechaVctoInst  
 , InCodigo  
 , Seriado  
 , MonedaOperacion  
 , Tipo_Riesgo  
 , codigo_pais  
 , Pago_Cheque  
 , Rut_Cheque  
 , FechaVctoCheque  
 , FactorVenta  
 , FormaPago  
 , Tir  
 , TasaPacto  
 , Instser  
 , Avr  
 , PrcLCR  
 , Resultado  
 , MetodoLCR  
 , Garantia  
 , Cod_Emisor  
 )  
 SELECT  
     /*01*/ FechaOperacion  = @dFecha    
 ,   /*04*/ NumeroOperacion  = Opciones.canumcontrato  
 ,   /*05*/ Numerodocumento  = Opciones.canumcontrato  
 ,   /*06*/ NumeroCorrelativo = 0  
 ,   /*07*/ Rut_Cliente   = Opciones.carutcliente  
 ,   /*08*/ Codigo_Cliente  = Opciones.cacodigo  
 ,   /*02*/ Id_Sistema   = 'BCC'  
 ,   /*03*/ Codigo_Producto  = Opciones.codigo_producto  
 ,   /*09*/ MontoTransaccion  = 0.0 -->   
 ,   /*10*/ TipoCambio   = 0.0  
 ,   /*11*/ FechaVencimiento  = Opciones.cafechapagoejer  
 ,   /*12*/ Operador    = ''  
 ,   /*13*/ Rut_Emisor   = 0  
 ,   /*14*/ Moneda_Emision  = 0  
 ,   /*15*/ FechaVctoInst  = @dFecha  
 ,   /*16*/ InCodigo    = 0  
 ,   /*17*/ Seriado    = 'N'  
 ,   /*18*/ MonedaOperacion  = 0  
 ,   /*19*/ Tipo_Riesgo   = 'C'  
 ,   /*20*/ codigo_pais   = 0  
 ,   /*21*/ Pago_Cheque   = Opciones.MercadoLc  
 ,   /*22*/ Rut_Cheque   = 0  
 ,   /*23*/ FechaVctoCheque  = @dFecha  
 ,   /*24*/ FactorVenta   = 0  
 ,   /*25*/ FormaPago   = 0  
 ,   /*26*/ Tir     = 0  
 ,   /*27*/ TasaPacto   = 0  
 ,   /*28*/ Instser    = ''  
 ,   /*29*/ Avr     = 0.0  
 ,   /*30*/ PrcLCR    = 0.0  
 ,   /*31*/ Resultado   = 0.0  
 ,   /*32*/ MetodoLCR   = 1 --> 0.0  
 ,   /*33*/ Garantia    = 0.0  
 , /*34*/ Cod_Emisor   = 0  
 from ( select codigo_producto  = 'OPT'  
    ,  canumcontrato  = Enc.canumcontrato  
    ,  carutcliente  = cli.clrut  
    ,  cacodigo   = cli.clcodigo  
    ,  cafechapagoejer  = Det.cafechapagoejer  
    ,  mercadolc   = case when cli.clpais = 6 then 's' else 'n' end    
    ,  moneda    = 999  
    ,  nmonedaopera  = 999  
    ,  ncontramoneda  = 999  
    ,  ntipooperacion  = 1  
    ,  nplazoresidual  = DATEDIFF(DAY, @dFecha, Det.cafechapagoejer )  
    from LnkOpc.CbMdbOpc.dbo.CaEncContrato Enc  with(nolock)   
      inner join ( select  CaNumContrato = CaNumContrato  
          ,   CaFechaPagoEjer = MAX( CaFechaPagoEjer )   
          from  LnkOpc.CbMdbOpc.dbo.CaDetContrato with(nolock)  
          group by CaNumContrato  
         )    Det On Det.CaNumContrato = Enc.canumcontrato  
      inner join lnkBac.BacParamSuda.dbo.Cliente cli with(nolock) On cli.clrut = Enc.CaRutCliente AND cli.clcodigo = Enc.CaCodigo   
   ) Opciones  
  
 EXEC SP_Calculo_LCR_Interno_Opciones @Numoper, 'N', @MtoMda1 OUTPUT, @AvrCLP OUTPUT, @MontoAddOn OUTPUT, @PorcAddOn OUTPUT    
 */  
  
 UPDATE BacLineas.dbo.LINEA_SISTEMA  
 SET  TotalOcupado    = 0  
 ,  TotalExceso     = 0  
 ,  TotalDisponible = TotalAsignado  
 WHERE id_sistema      IN('PCS', 'BFW', 'BCC')  
  
 UPDATE BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO  
 SET  TotalOcupado    = 0  
 ,  TotalExceso     = 0  
 ,  TotalDisponible = TotalAsignado  
 WHERE id_sistema      IN('PCS', 'BFW', 'BCC')  
  
 DECLARE  @Id     INT  
 DECLARE  @dFecPro   DATETIME  
 DECLARE  @nRutcli   NUMERIC(09,0)  
 DECLARE  @nCodigo   NUMERIC(09,0)  
 DECLARE  @dFecvctop   DATETIME  
 DECLARE  @nMonto    NUMERIC(19,4)  
 DECLARE  @cTipo_Riesgo  CHAR(1)  
 DECLARE  @nInCodigo   NUMERIC(05)  
 DECLARE  @nMonedaOp   NUMERIC(05,0)  
 DECLARE  @FormaPago   NUMERIC(03,0)  
 DECLARE  @MetodoLCR   NUMERIC(5)  
 DECLARE  @Id_Sistema   CHAR(3)  
 DECLARE  @Codigo_Producto CHAR(5)  
  
 DECLARE  @nNumoper   NUMERIC(10)  
 DECLARE  @NumeroCorrelativo NUMERIC(10,0)  
 DECLARE  @fTipcambio         NUMERIC(19,4)  
 DECLARE  @cUsuario           CHAR(15)  
 DECLARE  @nContraMoneda  NUMERIC(03)  
 DECLARE  @nMonedaOpera  NUMERIC(03)  
 DECLARE  @SW     INT;  SET @SW = 0  
 DECLARE  @Resultado          FLOAT  
 DECLARE  @Garantia           FLOAT  
 DECLARE  @Avr    NUMERIC(21,4)  
 DECLARE  @nPlazoResidual  NUMERIC(21,4)  
 DECLARE  @nMontoOriginal  NUMERIC(19,4)  
 DECLARE  @cCatipoper   CHAR(1)  
 DECLARE  @iRutPaso   NUMERIC(09,0); set @iRutPaso = 0  
  
 DECLARE  LineasChequear  CURSOR FOR   
  
 SELECT  FechaOperacion  = FechaOperacion  
  ,  Rut_Cliente   = Rut_Cliente  
  ,  Codigo_Cliente  = Codigo_Cliente  
  ,  FechaVencimiento = FechaVencimiento  
  ,  MontoTransaccion = SUM(MontoTransaccion)  
  ,  Tipo_Riesgo   = Tipo_Riesgo  
  ,  InCodigo   = InCodigo     --> = 0  
  ,  MonedaOperacion  = MonedaOperacion  
  ,  FormaPago   = FormaPago     --> = 0  
  ,  MetodoLCR   = MetodoLCR  
  ,  Id_Sistema   = Id_Sistema  
  ,  Codigo_Producto  = Codigo_Producto  
  ,  Avr     = SUM( Avr )  
  -------------------------------------------  
  ,  NumeroOperacion  = ( NumeroOperacion   )  
  ,  NumeroCorrelativo = ( NumeroCorrelativo )  
  ,  TipoCambio   = TipoCambio  
  ,  Operador   = Operador     --> = ''  
  ,  ContraMoneda  = Moneda_Emision  
  ,  MonedaOpera   = Cod_Emisor  
  -------------------------------------------  
  ,  Resultado   = Resultado  
        ,  Garantia   = Garantia  
  ,  TasaPacto   = TasaPacto  
  ,  PrcLCR    = PrcLCR  
  ,  Pago_Cheque   = Pago_Cheque  
 FROM  dbo.tmp_Linea_Chequear  
 GROUP BY FechaOperacion  
  ,  Id_Sistema  
  ,  Rut_Cliente  
  ,  Codigo_Cliente  
  ,  FechaVencimiento  
  ,  Tipo_Riesgo  
  ,  InCodigo  
  ,  MonedaOperacion  
  ,  FormaPago  
  ,  MetodoLCR  
  ,  Codigo_Producto  
  -------------------------------------------  
  ,  NumeroOperacion  
  ,  NumeroCorrelativo  
  ,  TipoCambio  
  ,  Operador  
  ,  Moneda_Emision  
  ,  Cod_Emisor  
  -------------------------------------------  
  ,  Resultado  
        ,  Garantia  
  ,  TasaPacto  
  ,  PrcLCR  
  ,  Pago_Cheque  
  
 OPEN LineasChequear   
  
 FETCH NEXT FROM LineasChequear  
 INTO @dFecPro  
  , @nRutcli  
  , @nCodigo  
  , @dFecvctop  
  , @nMonto  
  , @cTipo_Riesgo  
  , @nInCodigo  
  , @nMonedaOp  
  , @FormaPago  
  , @MetodoLCR  
  , @Id_Sistema  
  , @Codigo_Producto  
  , @Avr  
  -------------------------------------------  
  , @nNumoper  
  , @NumeroCorrelativo  
  , @fTipcambio  
  , @cUsuario  
  , @nContraMoneda  
  , @nMonedaOpera  
  -------------------------------------------  
  , @Resultado  
  , @Garantia  
  , @nPlazoResidual  
  , @nMontoOriginal  
  , @cCatipoper  
  
 if @Id_Sistema = 'BCC'  
 begin  
  set @iRutPaso = @nRutcli  
 end  
  
 WHILE @@FETCH_STATUS = 0  
 BEGIN  
  
  Execute BacLineas.dbo.SVC_IMPUTACION_LINEAS   
             @dFecPro   --> OK      
            , @Id_Sistema   --> OK  
            , @Codigo_Producto --> OK  
            , @nRutcli   --> OK  
            , @nCodigo   --> OK  
            , @nNumoper   --> OK  
            , @nNumoper   --> OK @nNumPantalla  
            , @NumeroCorrelativo --> OK  
            , @dFecPro   --> OK  
            , @nMonto    --> OK  
            , @fTipcambio   --> OK  
            , @dFecvctop   --> OK  
            , @cUsuario   --> OK  
            , @nMonedaOp   --> OK  
            , @cTipo_Riesgo  --> OK  
            , @nInCodigo   --> OK  
            , @FormaPago   --> OK  
            , @nContraMoneda  --> OK  
            , @nMonedaOpera  --> OK  
              --,  @SwithEjecucion  
            , @SW     --> OK  
            , @Resultado   --> OK  
            , @MetodoLCR   --> OK  
            , @Garantia   --> OK  
            , @Avr    -->   
  
  if @Id_Sistema <> 'BCC'  
  begin  
   Execute BacLineas.dbo.SP_LIMITES_GRABAR   
             @dFecPro   --> OK  
            , @Id_Sistema   --> OK  
            , @Codigo_Producto --> OK  
            , 0     --> OK  
            , @nNumoper   --> OK  
            , @nMonto    --> OK  
            , @dFecvctop   --> OK  
            , @cUsuario   --> OK  
            , 'S'     --> OK ( @cCheckLimOPER )  
            , 'N'     --> OK   
  
   Execute BacLineas.dbo.SP_LIMITES_GRABAR  
             @dFecPro   --> OK  
            , @Id_Sistema   --> OK  
            , @Codigo_Producto --> OK  
            , @nInCodigo   --> OK  
            , @nNumoper   --> OK  
            , @nMonto    --> OK  
            , @dFecvctop   --> OK  
            , @cUsuario   --> OK  
            , 'S'     --> OK  
            , 'S'     --> OK (@cCheckLimInst)  
  end  
    
  IF @Id_Sistema = 'BFW'  
  BEGIN  
   Execute BacLineas.dbo.SP_LIMITES_CHEQUEAR   
             @Id_Sistema   --> OK  
            , @nNumoper   --> OK  
  
   Execute BacLineas.dbo.SP_LIMITES_RECHEQUEAR    
             @Id_Sistema   --> OK  
            , @nNumoper   --> OK  
            , @cUsuario   --> OK  
            , 'I'     --> OK  
  
   Execute BacFwdSuda.dbo.SP_Graba_Registro_Utilidad_Banco   
             @nNumoper   --> OK  
            , @Codigo_Producto --> OK  
            , @nRutcli   --> OK  
            , @nCodigo   --> OK  
            , @nMonedaOpera  --> OK  
            , @Avr    --> OK  
            , @nContraMoneda  
            , @nPlazoResidual  
            , @nMontoOriginal  
            , @nMonto  
            , @cCatipoper  
  END  
  
  IF @iRutPaso <> @nRutcli and @Id_Sistema = 'BCC'  
  BEGIN  
   EXECUTE BacLineas.dbo.SP_RETIENE_LINEAS_SPOT @iRutPaso  
    SET @iRutPaso = @nRutcli  
  END  
  
  FETCH NEXT FROM LineasChequear  
  INTO @dFecPro  
   , @nRutcli  
   , @nCodigo  
   , @dFecvctop  
   , @nMonto  
   , @cTipo_Riesgo  
   , @nInCodigo  
   , @nMonedaOp  
   , @FormaPago  
   , @MetodoLCR  
   , @Id_Sistema  
   , @Codigo_Producto  
   , @Avr  
   -------------------------------------------  
   , @nNumoper  
   , @NumeroCorrelativo  
   , @fTipcambio  
   , @cUsuario  
   , @nContraMoneda  
   , @nMonedaOpera  
   -------------------------------------------  
   , @Resultado  
   , @Garantia  
   , @nPlazoResidual  
   , @nMontoOriginal  
   , @cCatipoper  
 END  
  
 CLOSE LineasChequear  
 DEALLOCATE LineasChequear  
  
 DROP TABLE dbo.tmp_Linea_Chequear  
  
 EXECUTE BacTraderSuda.dbo.SP_LINEAS_ACTUALIZARMONTOS_otro @dFecha, 'BTR'  
 EXECUTE BacLineas.dbo.SP_CARGA_LINEAS_RETENIDAS_otro   @dFecha  
 EXECUTE BacLineas.dbo.SP_RECALCULA_GENERAL  
 EXECUTE BacLineas.dbo.SP_LINEAS_ACTUALIZA  
  
 UPDATE  BacLineas.dbo.MATRIZ_ATRIBUCION_INSTRUMENTO   
 SET  Acumulado_Diario = 0  
 WHERE   Id_Sistema   IN('PCS', 'BFW', 'OPT')  
 AND  Acumulado_Diario > 0  
  
END
GO
