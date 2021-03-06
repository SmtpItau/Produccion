USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_RENTABILIDAD]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INF_RENTABILIDAD]( @Dolar_Observado_Hoy  FLOAT  ,
     @Dolar_Observado_Ayer  FLOAT  ,
     @Dolar_Observado_Prox  FLOAT  ,
     @Tasa_USD_Hoy   FLOAT  ,
     @Tasa_USD_Ayer   FLOAT  ,
     @Tasa_USD_Prox   FLOAT  , 
     @Tasa_Inter_Prom_Hoy  FLOAT  ,
     @Tasa_Inter_Prom_Ayer  FLOAT  ,
     @Tasa_Inter_Prom_Prox  FLOAT  ,
     @USUARIO   CHAR(40) )
AS
BEGIN
  DECLARE  @acfecproc   char(10),
           @acfecprox   char(10),
           @uf_hoy      float,
           @uf_man      float,
           @ivp_hoy     float,
           @ivp_man     float,
           @do_hoy      float,
           @do_man      float,
           @da_hoy      float,
           @da_man      float,
           @acnomprop   char(40),
           @rut_empresa char(12),
           @hora        char(8),
    @oma  char(3)
   execute Sp_Base_Del_Informe
           @acfecproc   OUTPUT,
           @acfecprox   OUTPUT,
           @uf_hoy      OUTPUT,
           @uf_man      OUTPUT,
           @ivp_hoy     OUTPUT,
           @ivp_man     OUTPUT,
           @do_hoy      OUTPUT,
           @do_man      OUTPUT,
           @da_hoy      OUTPUT,
           @da_man      OUTPUT,
           @acnomprop   OUTPUT,
           @rut_empresa OUTPUT,
           @hora        OUTPUT,
           @oma         OUTPUT
 DECLARE @Fecha_Hoy   DATETIME ,
  @Hora_Hoy   CHAR(08) ,
  @Fecha_Proceso_Hoy  DATETIME ,
  @Fecha_Proceso_Ayer  DATETIME ,
  @Fecha_Proceso_Prox  DATETIME ,
  @Precio_Cierre_Hoy  FLOAT  ,
  @Precio_Cierre_Ayer  FLOAT  ,
  @Precio_Cierre_Prox  FLOAT  ,
  @Precio_Prom_Compra_Hoy  FLOAT  ,
  @Precio_Prom_Compra_Ayer FLOAT  ,
  @Precio_Prom_Compra_Prox FLOAT  ,
  @Precio_Prom_Venta_Hoy  FLOAT  ,
  @Precio_Prom_Venta_Ayer  FLOAT  ,
  @Precio_Prom_Venta_Prox  FLOAT
 DECLARE @Posicion_Cmb_Ideal_Hoy  FLOAT  ,
  @Posicion_Cmb_Ideal_Ayer  FLOAT  ,
  @Posicion_Cmb_Ideal_Prox  FLOAT  ,
  @Posicion_Cmb_Real_Hoy   FLOAT  ,
  @Posicion_Cmb_Real_Ayer  FLOAT  ,
  @Posicion_Cmb_Real_Prox  FLOAT  ,
  @Brecha_Neta_Hoy  FLOAT  ,
  @Brecha_Neta_Ayer  FLOAT  ,
  @Brecha_Neta_Prox  FLOAT  ,
  @Monto_Comprado_Hoy  FLOAT  ,
  @Monto_Comprado_Ayer  FLOAT  ,
  @Monto_Comprado_Prox  FLOAT  ,
  @Monto_Vendido_Hoy  FLOAT  ,
  @Monto_Vendido_Ayer  FLOAT  ,
  @Monto_Vendido_Prox  FLOAT
 DECLARE @Pos_Hedge_Ayer   FLOAT  ,
  @Pos_Hedge_PAyer  FLOAT  ,
  @Tot_Min_Cor   FLOAT  ,
  @Tot_Tra_PHoy   FLOAT  ,
  @Pre_Med_Max   FLOAT  ,
  @Tot_Hed_PHoy   FLOAT  ,
  @Res_Com_PHoy   FLOAT  ,
  @Res_Arb_PHoy   FLOAT  ,
  @Res_Pos_PHoy   FLOAT
 DECLARE @Res_Hdg_Clp   FLOAT  ,
  @Prm_Int_Post   FLOAT  ,
  @Dia_Clp_Hoy   FLOAT  ,
  @Res_Clp_Hoy   FLOAT  ,
  @Res_Hdg_Usd   FLOAT  ,
  @Tas_Usd_PoH   FLOAT  ,
  @Dia_Usd_Hoy   FLOAT  ,
  @Res_Hdg_Usd1   FLOAT  ,
  @Res_Usd_Hoy   FLOAT  ,
  @Res_Usd_Hoy1   FLOAT  ,
  @Total    FLOAT  ,
  @Res_Hdg_PHoy   FLOAT
 DECLARE @Res_Tot_PHoy   FLOAT  ,
  @Tot_Acu_PAyer   FLOAT  ,
  @Tot_Acu_PHoy   FLOAT
  
 DECLARE @Tot_Com_F   FLOAT  ,
  @Tot_Ven_F   FLOAT
 
 SELECT  @Fecha_Proceso_Hoy  = ACFECPRO  ,
  @Fecha_Proceso_Ayer = ACFECANT  ,
  @Fecha_Proceso_Prox = ACFECPRX
  FROM meac
/***************************************************************************************************************************
 IF EXISTS(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 1 AND vmfecha = @Fecha_Proceso_Hoy)
  UPDATE VIEW_VALOR_MONEDA SET vmvalor = @Tasa_USD_Hoy WHERE vmcodigo = 1 AND vmfecha = @Fecha_Proceso_Hoy
 ELSE
  INSERT VIEW_VALOR_MONEDA(vmcodigo, vmfecha, vmvalor) VALUES (1,@Fecha_Proceso_Hoy,@Tasa_USD_Hoy)
 IF EXISTS(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 1 AND vmfecha = @Fecha_Proceso_Ayer)
  UPDATE VIEW_VALOR_MONEDA SET vmvalor = @Tasa_USD_Ayer WHERE vmcodigo = 1 AND vmfecha = @Fecha_Proceso_Ayer
 ELSE
  INSERT VIEW_VALOR_MONEDA(vmcodigo, vmfecha, vmvalor) VALUES (1,@Fecha_Proceso_Ayer,@Tasa_USD_Ayer)
 IF EXISTS(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 1 AND vmfecha = @Fecha_Proceso_Prox)
  UPDATE VIEW_VALOR_MONEDA SET vmvalor = @Tasa_USD_Prox WHERE vmcodigo = 1 AND vmfecha = @Fecha_Proceso_Prox
 ELSE
  INSERT VIEW_VALOR_MONEDA(vmcodigo, vmfecha, vmvalor) VALUES (1,@Fecha_Proceso_Prox,@Tasa_USD_Prox)
 IF EXISTS(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 3 AND vmfecha = @Fecha_Proceso_Hoy)
  UPDATE VIEW_VALOR_MONEDA SET vmvalor = @Tasa_Inter_Prom_Hoy WHERE vmcodigo = 3 AND vmfecha = @Fecha_Proceso_Hoy
 ELSE
  INSERT VIEW_VALOR_MONEDA(vmcodigo, vmfecha, vmvalor) VALUES (3,@Fecha_Proceso_Hoy,@Tasa_Inter_Prom_Hoy)
 IF EXISTS(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 3 AND vmfecha = @Fecha_Proceso_Ayer)
  UPDATE VIEW_VALOR_MONEDA SET vmvalor = @Tasa_Inter_Prom_Ayer WHERE vmcodigo = 3 AND vmfecha = @Fecha_Proceso_Ayer
 ELSE
  INSERT VIEW_VALOR_MONEDA(vmcodigo, vmfecha, vmvalor) VALUES (3,@Fecha_Proceso_Ayer,@Tasa_Inter_Prom_Ayer)
 IF EXISTS(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 3 AND vmfecha = @Fecha_Proceso_Prox)
  UPDATE VIEW_VALOR_MONEDA SET vmvalor = @Tasa_Inter_Prom_Prox WHERE vmcodigo = 3 AND vmfecha = @Fecha_Proceso_Prox
 ELSE
  INSERT VIEW_VALOR_MONEDA(vmcodigo, vmfecha, vmvalor) VALUES (3,@Fecha_Proceso_Prox,@Tasa_Inter_Prom_Prox)
 IF EXISTS(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = @Fecha_Proceso_Hoy)
  UPDATE VIEW_VALOR_MONEDA SET vmvalor = @Dolar_Observado_Hoy WHERE vmcodigo = 994 AND vmfecha = @Fecha_Proceso_Hoy
 ELSE
  INSERT VIEW_VALOR_MONEDA(vmcodigo, vmfecha, vmvalor) VALUES (994,@Fecha_Proceso_Hoy,@Dolar_Observado_Hoy)
 IF EXISTS(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = @Fecha_Proceso_Ayer)
  UPDATE VIEW_VALOR_MONEDA SET vmvalor = @Dolar_Observado_Ayer WHERE vmcodigo = 994 AND vmfecha = @Fecha_Proceso_Ayer
 ELSE
  INSERT VIEW_VALOR_MONEDA(vmcodigo, vmfecha, vmvalor) VALUES (994,@Fecha_Proceso_Ayer,@Dolar_Observado_Ayer)
 IF EXISTS(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = @Fecha_Proceso_Prox)
  UPDATE VIEW_VALOR_MONEDA SET vmvalor = @Dolar_Observado_Prox WHERE vmcodigo = 994 AND vmfecha = @Fecha_Proceso_Prox
 ELSE
  INSERT VIEW_VALOR_MONEDA(vmcodigo, vmfecha, vmvalor) VALUES (994,@Fecha_Proceso_Prox,@Dolar_Observado_Prox)
***************************************************************************************************************************/
 SELECT @Tot_Com_F   = SUM(camtomon1) FROM BACFWDSUDA..MFCA WHERE cacodpos1 = 6 AND catipoper = 'C'
 SELECT @Tot_Ven_F   = SUM(camtomon1) FROM BACFWDSUDA..MFCA WHERE cacodpos1 = 6 AND catipoper = 'V'
 SELECT @Posicion_Cmb_Ideal_Hoy  = (@Tot_Com_F - @Tot_Ven_F)/1000
 
 SELECT  @Precio_Prom_Compra_Ayer = ACCOSCOMP              ,
  @Precio_Prom_Venta_Ayer  = ACCOSVENT    ,
  @Precio_Cierre_Ayer  = ACOBSER   ,
  @Monto_Comprado_Ayer  = cp_totco/1000               ,
  @Monto_Vendido_Ayer  = cp_totve/1000
  FROM meach
 SELECT  @Precio_Prom_Compra_Hoy  = ACCOSCOMP              ,
  @Precio_Prom_Venta_Hoy  = ACCOSVENT    ,
  @Precio_Cierre_Hoy  = ACOBSER   ,
  @Monto_Comprado_Hoy  = cp_totco/1000               ,
  @Monto_Vendido_Hoy  = cp_totve/1000   ,
  @Tot_Min_Cor   = CASE WHEN cp_totco < cp_totve THEN cp_totco/1000 ELSE cp_totve/1000 END,
  @Pre_Med_Max   = CASE WHEN cp_totco < cp_totve THEN ACCOSCOMP     ELSE ACCOSVENT     END,
  @Res_Com_PHoy   = (cp_utico + cp_utive)/1000      ,
  @Brecha_Neta_Hoy  = ACHEDGEACTUALSPOT/1000       ,
  @Posicion_Cmb_Real_Hoy  = ACPOSIC/1000
  FROM meac
 SELECT  @Tot_Tra_PHoy   = @Tot_Min_Cor * ( @Precio_Prom_Venta_Hoy - @Precio_Prom_Compra_Hoy ) ,
  @Prm_Int_Post   = @Tasa_Inter_Prom_Hoy       ,
  @Tas_Usd_PoH   = @Tasa_USD_Hoy        ,
  @Dia_Clp_Hoy   = 1         ,
  @Dia_Usd_Hoy   = 1         ,
  @Res_Hdg_Usd   = @Posicion_Cmb_Real_Hoy      ,
  @Res_Hdg_Clp   = @Brecha_Neta_Hoy
 SELECT @Tot_Hed_PHoy   = (@Monto_Comprado_Hoy - @Monto_Vendido_Hoy) * (@Dolar_Observado_Prox - @Pre_Med_Max)
 SELECT  @Res_Arb_PHoy   = (SUM(moutilpe)/1000) FROM memo WHERE motipmer = 'ARBI'
 SELECT @Res_Pos_PHoy   = (ISNULL(@Pos_Hedge_PAyer,0) + 
         ISNULL(@Tot_Tra_PHoy,0) + 
         ISNULL(@Tot_Hed_PHoy,0) + 
         ISNULL(@Res_Com_PHoy,0) + 
         ISNULL(@Res_Arb_PHoy,0))
 SELECT @Res_Hdg_Usd1   = ( @Brecha_Neta_Hoy - @Posicion_Cmb_Real_Hoy)
 SELECT  @Res_Clp_Hoy   = (-(@Res_Hdg_Clp) * (( @Prm_Int_Post / 3000) * @Dia_Clp_Hoy)) * @Precio_Cierre_Hoy
 SELECT  @Res_Usd_Hoy   = (@Res_Hdg_Usd * ((@Tas_Usd_PoH / 36000) * @Dia_Usd_Hoy)) * @Precio_Cierre_Hoy
 SELECT  @Res_Usd_Hoy1   = (@Res_Hdg_Usd1 *((@Tas_Usd_PoH / 36000) * @Dia_Usd_Hoy)) * @Precio_Cierre_Hoy
 SELECT  @Total    = (@Res_Usd_Hoy1 + @Res_Usd_Hoy)
 SELECT @Res_Hdg_PHoy   = ( @Res_Clp_Hoy + @Res_Usd_Hoy + @Res_Usd_Hoy1)
 SELECT  @Res_Tot_PHoy   = (@Res_Pos_PHoy + @Res_Hdg_PHoy)
 
 SELECT @Tot_Acu_PAyer   = 0  --no lo tengo
 SELECT @Tot_Acu_PHoy   = (@Res_Tot_PHoy + @Tot_Acu_PAyer)
 SELECT  @Fecha_Hoy = GETDATE() ,--CONVERT(CHAR(10),GETDATE(),103) ,
  @Hora_Hoy  = CONVERT(CHAR(08),GETDATE(),108)
 SELECT  'Fecha_Hoy'   =@Fecha_Hoy    ,
   'Hora_Hoy'   =@Hora_Hoy    ,
  'Fecha_Proceso_Hoy'  =ISNULL(@Fecha_Proceso_Hoy,'')  ,
  'Fecha_Proceso_Ayer'  =ISNULL(@Fecha_Proceso_Ayer,'')  ,
  'Fecha_Proceso_Prox'  =ISNULL(@Fecha_Proceso_Prox,'')  ,
  'Precio_Cierre_Hoy'  =ISNULL(@Precio_Cierre_Hoy,0)  ,
  'Precio_Cierre_Ayer'  =ISNULL(@Precio_Cierre_Ayer,0)  ,
  'Precio_Cierre_Prox'  =ISNULL(@Precio_Cierre_Prox,0)  ,
  'Dolar_Observado_Hoy'  =ISNULL(@Dolar_Observado_Hoy,0)  ,
  'Dolar_Observado_Ayer'  =ISNULL(@Dolar_Observado_Ayer,0) ,
  'Dolar_Observado_Prox'  =ISNULL(@Dolar_Observado_Prox,0) ,
  'Precio_Prom_Compra_Hoy' =ISNULL(@Precio_Prom_Compra_Hoy,0) ,
  'Precio_Prom_Compra_Ayer' =ISNULL(@Precio_Prom_Compra_Ayer,0) ,
  'Precio_Prom_Compra_Prox' =ISNULL(@Precio_Prom_Compra_Prox,0) ,
  'Precio_Prom_Venta_Hoy'  =ISNULL(@Precio_Prom_Venta_Hoy,0) ,
  'Precio_Prom_Venta_Ayer' =ISNULL(@Precio_Prom_Venta_Ayer,0) ,
  'Precio_Prom_Venta_Prox' =ISNULL(@Precio_Prom_Venta_Prox,0) ,
  'Tasa_USD_Hoy'   =ISNULL(@Tasa_USD_Hoy,0)  ,
  'Tasa_USD_Ayer'   =ISNULL(@Tasa_USD_Ayer,0)  ,
  'Tasa_USD_Prox'   =ISNULL(@Tasa_USD_Prox,0)  ,
  'Tasa_Inter_Prom_Hoy'  =ISNULL(@Tasa_Inter_Prom_Hoy,0)  ,
  'Tasa_Inter_Prom_Ayer'  =ISNULL(@Tasa_Inter_Prom_Ayer,0) ,
  'Tasa_Inter_Prom_Prox'  =ISNULL(@Tasa_Inter_Prom_Prox,0) ,
  'Posicion_Cmb_Ideal_Hoy'  =ISNULL(@Posicion_Cmb_Ideal_Hoy,0)  ,
  'Posicion_Cmb_Ideal_Ayer'  =ISNULL(@Posicion_Cmb_Ideal_Ayer,0)  ,
  'Posicion_Cmb_Ideal_Prox'  =ISNULL(@Posicion_Cmb_Ideal_Prox,0)  ,
  'Posicion_Cmb_Real_Hoy'  =ISNULL(@Posicion_Cmb_Real_Hoy,0)  ,
  'Posicion_Cmb_Real_Ayer'  =ISNULL(@Posicion_Cmb_Real_Ayer,0)  ,
  'Posicion_Cmb_Real_Prox'  =ISNULL(@Posicion_Cmb_Real_Prox,0)  ,
  'Brecha_Neta_Hoy'  =ISNULL(@Brecha_Neta_Hoy,0)  ,
  'Brecha_Neta_Ayer'  =ISNULL(@Brecha_Neta_Ayer,0)  ,
  'Brecha_Neta_Prox'  =ISNULL(@Brecha_Neta_Prox,0)  ,
  'Monto_Comprado_Hoy'  =ISNULL(@Monto_Comprado_Hoy,0)  ,
  'Monto_Comprado_Ayer'  =ISNULL(@Monto_Comprado_Ayer,0)  ,
  'Monto_Comprado_Prox'  =ISNULL(@Monto_Comprado_Prox,0)  ,
  'Monto_Vendido_Hoy'  =ISNULL(@Monto_Vendido_Hoy,0)  ,
  'Monto_Vendido_Ayer'  =ISNULL(@Monto_Vendido_Ayer,0)  ,
  'Monto_Vendido_Prox'  =ISNULL(@Monto_Vendido_Prox,0)  ,
  'Pos_Hedge_Ayer'  =ISNULL(@Pos_Hedge_Ayer,0)  ,
  'Pos_Hedge_PAyer'  =ISNULL(@Pos_Hedge_PAyer,0)  ,
  'Tot_Min_Cor'   =ISNULL(@Tot_Min_Cor,0)   ,
  'Tot_Tra_PHoy'   =ISNULL(@Tot_Tra_PHoy,0)  ,
  'Pre_Med_Max'   =ISNULL(@Pre_Med_Max,0)   ,
  'Tot_Hed_PHoy'   =ISNULL(@Tot_Hed_PHoy,0)  ,
  'Res_Com_PHoy'   =ISNULL(@Res_Com_PHoy,0)  ,
  'Res_Arb_PHoy'   =ISNULL(@Res_Arb_PHoy,0)  ,
  'Res_Pos_PHoy'   =ISNULL(@Res_Pos_PHoy,0)  ,
  'Res_Hdg_Clp'   =ISNULL(@Res_Hdg_Clp,0)   ,
  'Prm_Int_Post'   =ISNULL(@Prm_Int_Post,0)  ,
  'Dia_Clp_Hoy'   =ISNULL(@Dia_Clp_Hoy,0)   ,
  'Res_Clp_Hoy'   =ISNULL(@Res_Clp_Hoy,0) ,
  'Res_Hdg_Usd'   =ISNULL(@Res_Hdg_Usd,0)   ,
  'Tas_Usd_PoH'   =ISNULL(@Tas_Usd_PoH,0)   ,
  'Dia_Usd_Hoy'   =ISNULL(@Dia_Usd_Hoy,0)   ,
  'Res_Hdg_Usd1'   =ISNULL(@Res_Hdg_Usd1,0)  ,
  'Res_Usd_Hoy'   =ISNULL(@Res_Usd_Hoy,0)   ,
  'Res_Usd_Hoy1'   =ISNULL(@Res_Usd_Hoy1,0)  ,
  'Total'    =ISNULL(@Total,0)   ,
  'Res_Hdg_PHoy'   =ISNULL(@Res_Hdg_PHoy,0)  ,
  'Res_Tot_PHoy'   =ISNULL(@Res_Tot_PHoy,0)  ,
  'Tot_Acu_PAyer'   =ISNULL(@Tot_Acu_PAyer,0)  ,
  'Tot_Acu_PHoy'   =ISNULL(@Tot_Acu_PHoy,0)  ,
  'usuario'   = @USUARIO    ,
  'acfecproc'   =@acfecproc    ,
    'acfecprox'          =@acfecprox    ,
    'uf_hoy'         =@uf_hoy    ,
    'uf_man'         =@uf_man    ,
    'ivp_hoy'         =@ivp_hoy    ,
    'ivp_man'                =@ivp_man    ,
    'do_hoy'         =@do_hoy    ,
    'do_man'         =@do_man    ,
    'da_hoy'         =@da_hoy    ,
    'da_man'         =@da_man    ,
    'pmnomprop'         =@acnomprop    ,
    'rut_empresa'                 =@rut_empresa
  
END

GO
