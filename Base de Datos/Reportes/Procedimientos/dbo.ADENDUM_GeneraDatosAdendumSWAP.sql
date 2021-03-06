USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[ADENDUM_GeneraDatosAdendumSWAP]    Script Date: 16-05-2022 10:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---ADENDUM_CargaAdendumSwap 2569, 'Modificada', '29-01-2013', '00:00', 9853769,9853769,4881321,4881321

    
CREATE PROCEDURE [dbo].[ADENDUM_GeneraDatosAdendumSWAP]  
(    
  @Num_Oper  int  
 , @SeModifico  varchar(25) = 'No Modificada'  
 , @dFecha   varchar(10)  
 , @cHora   char(8)   
 , @RutApoderado1 numeric(10)  
 , @RutApoderado2 numeric(10)   

 , @RUTAPODERADOCLI1 numeric(10)  
, @RUTAPODERADOCLI2  numeric(10)  
)    
AS    
BEGIN    
SET NOCOUNT ON    


DECLARE @cNom_Apoderado_Cliente_1	VARCHAR(40)
DECLARE @cRut_Apoderado_Cliente_1	VARCHAR(40)
DECLARE @cNom_Apoderado_Cliente_2	VARCHAR(40)
DECLARE @cRut_Apoderado_Cliente_2	VARCHAR(40)



SET @cNom_Apoderado_Cliente_1 = (select top 1 apnombre FROM	
									BacParamSuda.dbo.CLIENTE_APODERADO where aprutapo = @RUTAPODERADOCLI1) 

SET @cRut_Apoderado_Cliente_1 = (select top 1 LTRIM(RTRIM(aprutcli)) + '-' + LTRIM(RTRIM(apdvcli)) FROM	
									BacParamSuda.dbo.CLIENTE_APODERADO where aprutapo =  @RUTAPODERADOCLI1) 

SET @cNom_Apoderado_Cliente_2 = (select top 1 apnombre FROM	
									BacParamSuda.dbo.CLIENTE_APODERADO where aprutapo = @RUTAPODERADOCLI2) 

SET @cRut_Apoderado_Cliente_2 = (select top 1 LTRIM(RTRIM(aprutcli)) + '-' + LTRIM(RTRIM(apdvcli)) FROM	
									BacParamSuda.dbo.CLIENTE_APODERADO where aprutapo =  @RUTAPODERADOCLI2) 


    
/****** S W A P ******/    
--declare @Num_Oper int    
--set @Num_Oper =  2569 --4799 --4799--4799 --2569 --2569 --6994    
    
--declare @SeModifico                     char(50)    
--set @SeModifico                = 'No Modificada'    
    
/*** SE OBTIENE FECHA DE PROCESO ***/    
DECLARE @FechaInicio       DATETIME    
SET   @FechaInicio          = (select fechaproc from BacSwapSuda.dbo.SwapGeneral with(nolock)  )    
    
    
/*** FECHA CONTRATO ***/    
DECLARE @FechaContrato DATETIME    
SET @FechaContrato = (select min(FECHA_cierre) from BacSwapSuda.dbo.carterares where NUMERO_OPERACION = @Num_Oper)    
    
    
/* YA NO    
SELECT @SeModifico = 'Modificada'    
FROM CARTERALOG    
WHERE NUMERO_OPERACION = @Num_Oper    
    
    
IF @SeModifico = 'Modificada'    
BEGIN    
    
 /*** SELECCIONA ULTIMA FECHA MODIFICACION ***/    
 DECLARE @FechaModificacion as DATETIME    
 SET @FechaModificacion = (SELECT MAX(DISTINCT(FECHA_MODIFICA)) FROM CARTERALOG WHERE NUMERO_OPERACION = 4799)    
    
 --SELECT DISTINCT(FECHA_MODIFICA), NUMERO_OPERACION FROM CARTERALOG WHERE NUMERO_OPERACION = 2569 --> PARA OBTENER LAS FECHAS QUE SE MODIFICO    
    
    
 --/*** SE DETERMINA SI ES MODIFICADA O ANTICIPADA ***/    
 --SELECT FECHA_MODIFICA,fecha_Termino,*FROM CARTERAHIS WHERE NUMERO_OPERACION = @Num_Oper AND FECHA_MODIFICA = @FechaModificacion    
 --and         fecha_Termino        <= @dFechaproceso    
    
 /*** SE DETERMINA SI ES MODIFICADA O ANTICIPADA ***/    
 SELECT @SeModifico = 'Anticipada'    
 FROM CARTERAHIS     
 WHERE NUMERO_OPERACION = @Num_Oper     
 AND  FECHA_MODIFICA  = @FechaModificacion    
 AND     fecha_Termino       <= @FechaInicio    
     
     
END    
*/    
    

 
IF @SeModifico = 'Modificada'    
BEGIN    
 --print @SeModifico    
 
 declare @FechaVencContrato as datetime
 
 set @FechaVencContrato = convert(char(10),(select max(fecha_vence_flujo) from BacSwapSuda.dbo.carteraRes     
          where numero_operacion = @Num_Oper and tipo_flujo = 1),23)  
   
DELETE FROM dbo.ADENDUM_InformacionSWAP  
   
 INSERT INTO dbo.ADENDUM_InformacionSWAP  

  
 select top 1    
 'ID'      = 0     
, 'Folio'      = @Num_Oper  
,  'Tipo_Contrato'    = tbglosa    
,  'Fecha_Modif_Contrato'  --= BacParamSuda.dbo.FxFechaLarga( ca.fecha_modifica, 1)    
							 = (select  convert(char(2), ca.fecha_modifica, 103) + ' de '  
						   +     case  when datepart( month, ca.fecha_modifica) = 1  then 'Enero'  
							when datepart( month, ca.fecha_modifica) = 2  then 'Febrero'  
							when datepart( month, ca.fecha_modifica) = 3  then 'Marzo'  
							when datepart( month, ca.fecha_modifica) = 4  then 'Abril'  
							when datepart( month, ca.fecha_modifica) = 5  then 'Mayo'  
							when datepart( month, ca.fecha_modifica) = 6  then 'Junio'  
							when datepart( month, ca.fecha_modifica) = 7  then 'Julio'  
							when datepart( month, ca.fecha_modifica) = 8  then 'Agosto'  
							when datepart( month, ca.fecha_modifica) = 9  then 'Septiembre'  
							when datepart( month, ca.fecha_modifica) = 10 then 'Octubre'  
							when datepart( month, ca.fecha_modifica) = 11 then 'Noviembre'  
							when datepart( month, ca.fecha_modifica) = 12 then 'Diciembre'  
							   end + ' de '   
							+     ltrim(rtrim( datepart(year, ca.fecha_modifica) )))   

    
,  'Fecha_Inicio_Contrato'  --= BacParamSuda.dbo.FxFechaLarga( @FechaContrato, 1)   
							 = (select  convert(char(2), @FechaContrato, 103) + ' de '  
						   +     case  when datepart( month, @FechaContrato) = 1  then 'Enero'  
							when datepart( month, @FechaContrato) = 2  then 'Febrero'  
							when datepart( month, @FechaContrato) = 3  then 'Marzo'  
							when datepart( month, @FechaContrato) = 4  then 'Abril'  
							when datepart( month, @FechaContrato) = 5  then 'Mayo'  
							when datepart( month, @FechaContrato) = 6  then 'Junio'  
							when datepart( month, @FechaContrato) = 7  then 'Julio'  
							when datepart( month, @FechaContrato) = 8  then 'Agosto'  
							when datepart( month, @FechaContrato) = 9  then 'Septiembre'  
							when datepart( month, @FechaContrato) = 10 then 'Octubre'  
							when datepart( month, @FechaContrato) = 11 then 'Noviembre'  
							when datepart( month, @FechaContrato) = 12 then 'Diciembre'  
							   end + ' de '   
							+     ltrim(rtrim( datepart(year, @FechaContrato) )))   
 
              
,  'Fecha_Venc_Contrato'  --= --convert(char(10),(select max(fecha_vence_flujo) from BacSwapSuda.dbo.carteraRes     
          --where numero_operacion = @Num_Oper and tipo_flujo = 1),23)  
          
           = (select  convert(char(2), @FechaVencContrato, 103) + ' de '  
						   +     case  when datepart( month, @FechaVencContrato) = 1  then 'Enero'  
							when datepart( month, @FechaVencContrato) = 2  then 'Febrero'  
							when datepart( month, @FechaVencContrato) = 3  then 'Marzo'  
							when datepart( month, @FechaVencContrato) = 4  then 'Abril'  
							when datepart( month, @FechaVencContrato) = 5  then 'Mayo'  
							when datepart( month, @FechaVencContrato) = 6  then 'Junio'  
							when datepart( month, @FechaVencContrato) = 7  then 'Julio'  
							when datepart( month, @FechaVencContrato) = 8  then 'Agosto'  
							when datepart( month, @FechaVencContrato) = 9  then 'Septiembre'  
							when datepart( month, @FechaVencContrato) = 10 then 'Octubre'  
							when datepart( month, @FechaVencContrato) = 11 then 'Noviembre'  
							when datepart( month, @FechaVencContrato) = 12 then 'Diciembre'  
							   end + ' de '   
							+     ltrim(rtrim( datepart(year, @FechaVencContrato) )))  
          
          
        
            
,  'Monto_Contrato_Banco'  = (select top 1 compra_capital from BacSwapSuda.dbo.carteraRES     
          where numero_operacion = @Num_Oper AND  TIPO_FLUJO = 1) --and fecha_modifica = (select Fecha_Operacion from baclineas..DETALLE_APROBACIONES     
          --where numero_operacion = @Num_Oper AND ID_SISTEMA = 'PCS'    
          --and estado = 'A'))   
          
,  'Monto_Contrato_Cliente' = (select top 1 venta_capital from BacSwapSuda.dbo.carteraRes     
          where numero_operacion = @Num_Oper AND  TIPO_FLUJO = 2) --and  fecha_modifica = (select Fecha_Operacion from baclineas..DETALLE_APROBACIONES     
          --where numero_operacion = @Num_Oper AND ID_SISTEMA = 'PCS'    
          --and estado = 'A'))    
          
,  'Nombre_Cliente'   = (select par.clnombre from bacparamsuda..cliente par    
          where par.clrut = ca.rut_cliente    
          and ca.numero_operacion = @Num_Oper --and cr,tipo_flujo = 2    
          group by par.clnombre)    
,  'Rut_Cliente'    = ca.rut_cliente    
    
 ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig'   = ''    
    ,  'fecha_inicio_flujo_venta_orig'    = ''    
    ,  'fecha_vence_flujo_venta_orig'    = ''    
    ,  'PlazoFlujo_venta_orig'      = 0    
    ,  'Monto_Contratado_Vig_venta_Orig'   = '' --venta_saldo + venta_amortiza    
    ,  'Monto_amortiza_venta_orig'     = ''    
    ,  'Monto_interes_Pactada_fija_venta_orig'  = ''    
    --,  'numero_flujo_venta_orig'   = 0     
        
    ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig' = ''    
    ,  'fecha_inicio_flujo_compra_orig' = ''     
    ,  'fecha_vence_flujo_compra_orig'  = ''    
    ,  'PlazoFlujo_compra_orig'   = 0    
    ,  'Monto_Contrato_Vig_compra_orig' = '' --compra_saldo + compra_amortiza    
    ,  'Monto_amortiza_compra_orig'  = ''    
   -- ,  'compra_interes_compra_orig'  = 0    
    --,  'Monto_Interes_Pactada_mas_Spread' = ''    
 ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig' = ''    
        
      
/*******************************  MODIFICACIONES  ***********************************/    
    -----> VENTA (Con Modificaciones)    
        --select      
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
       
         
-----> COMPRA (Con Modificaciones)    
        --select      
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'      = '' --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod' = ''    
    
   ----> Condiciones Financieras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
       
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
   ----> //* Datos Apoderado    
   ,  'Domicilio_Cliente' = cliente.cldirecc    
   ,  'Fono_Cliente'  = cliente.clfono    
   ,  'Fax_Cliente'   = cliente.clfax    
   ,  'Apoderado_Uno'  = apoderado1.apnombre  
   ,  'Rut_Apoderado_Uno' = rtrim(ltrim(convert(char(10),apoderado1.aprutapo))) + '-' + apoderado1.apdvapo  
   ,  'Apoderado_Dos'  =   apoderado2.apnombre  
   ,  'Rut_Apoderado_Dos' = rtrim(ltrim(convert(char(10),apoderado2.aprutapo))) + '-' + apoderado2.apdvapo  

        ,	'Nombre_Apoderado_Cli_uno' = @cNom_Apoderado_Cliente_1 
   ,  'Rut_Apoderado_Cli_Uno' = @cRut_Apoderado_Cliente_1
    ,	'Nombre_Apoderado_Cli_dos' = @cNom_Apoderado_Cliente_2
   ,  'Rut_Apoderado_Cli_dos' = @cRut_Apoderado_Cliente_2

     , 'Fecha_Firma_CCG'	= dbo.Fx_Retorna_Mes( Cliente.FECHA_FIRMA_NUEVO_CCG )	

              
from bacparamsuda..tabla_general_detalle gd    
--, BacSwapSuda.dbo.carterares ca --> para operac. 2569 MODIFICADA    
, BacSwapSuda.dbo.carteraLog ca --> para operac. 4799 ANTICIPADA    
inner join bacparamsuda.dbo.cliente cliente with(nolock) On cliente.clrut = ca.rut_cliente   
inner join bacparamsuda.dbo.CLIENTE_APODERADO apoderado1 with(nolock) On apoderado1.aprutapo = @RutApoderado1  
inner join bacparamsuda.dbo.CLIENTE_APODERADO apoderado2 with(nolock) On apoderado2.aprutapo = @RutApoderado2  
where gd.tbcateg   = 1050 --> Tipo de Operacion Swap    
and  gd.tbcodigo1  = ca.tipo_swap    
and  ca.numero_operacion = @Num_Oper    



  

  
    
union    
    
/*********************** ORIGINAL ********************************/    
  ----> flujos ventas contrato original    
    SELECT     
   'ID' = 1    
   , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = ''    
    ,  'Rut_Cliente' = 0   
        
       
       ----> flujos Ventas contrato original    
   ,  'fecha_fijacion_tasa_venta_orig'   = convert(char(10),Swap.fecha_fijacion_tasa,23)    
   ,  'fecha_inicio_flujo_venta_orig'    = convert(char(10),Swap.fecha_inicio_flujo,23)    
   ,  'fecha_vence_flujo_venta_orig'   = convert(char(10),Swap.fecha_vence_flujo,23) --fecha_termino    
   ,  'PlazoFlujo_venta_orig'      = Swap.PlazoFlujo    
   ,  'Monto_Contratado_Vig_venta_Orig'   = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.venta_saldo + Swap.venta_amortiza)    
   ,  'Monto_amortiza_venta_orig'     = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.venta_amortiza)    
   ,  'Monto_Interes_Pactada_Fija_venta_Orig'  = (SELECT CASE WHEN venta_spread > 0 THEN     
                        
                   ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(80),Swap.venta_spread))) + '%'    
                   WHEN   venta_spread = 0 THEN    
   
                       
                   CONVERT(CHAR(15),venta_interes)     
                 END)    
       
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'     = ''    
    ,  'fecha_inicio_flujo_compra_orig'     = ''     
    ,  'fecha_vence_flujo_compra_orig'      = ''    
    ,  'PlazoFlujo_compra_orig'       = 0    
    ,  'Monto_compra_orig'         = '' --compra_saldo + compra_amortiza    
    ,  'Monto_amortiza_compra_orig'      = ''    
   -- ,  'compra_interes_compra_orig'      = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig'  = ''    
        
    /*******************************  MODIFICACIONES  ***********************************/    
    -----> VENTA (Con Modificaciones)    
        --select      
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
    
          
-----> COMPRA (Con Modificaciones)    
        --select      
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'      = '' --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod' = ''    
        
   ----> Condiciones Financieras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
       
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
      ----> //* Datos Apoderado    
   ,  'Domicilio_Cliente'  = ''    
   ,  'Fono_Cliente'   = ''-- 0    
   ,  'Fax_Cliente'   = '' --0    
    ,  'Apoderado_Uno' = ''  
    ,  'Rut_Apoderado_Uno' = ''  
   ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

           ,	'Nombre_Apoderado_Cli_uno' = ''
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

    , 'Fecha_Firma_CCG'	= ''	
        
        
    FROM BacSwapSuda.dbo.CARTERARES swap    
    
     INNER JOIN (select tbcodigo1, tbglosa     
        from bacparamsuda..tabla_general_detalle     
        where tbcateg = 1042    
        )  Indicador On Indicador.tbcodigo1 = Swap.venta_codigo_tasa    
     INNER JOIN (SELECT mncodmon, mnnemo     
        FROM BACPARAMSUDA..MONEDA     
        )  md on md.MNCODMON = swap.venta_moneda    
    where  Swap.numero_operacion = @Num_Oper    
       and   Swap.tipo_flujo        = 2    
        and  fecha_modifica = @FechaContrato    
       AND  PLAZOFLUJO > 0    
    
union    
     
 ----> flujos Compras contrato original    
 SELECT    
'ID' = 2    
      , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = ''    
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'  = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
    --,  'numero_flujo_venta_orig'   = 0    
        
        
        
        ----> flujos Compras contrato original    
   ,  'fecha_fijacion_tasa_compra_orig'     = convert(char(10),Swap.fecha_fijacion_tasa,23)    
   ,  'fecha_inicio_flujo_compra_orig'     = convert(char(10),Swap.fecha_inicio_flujo,23)    
   ,  'fecha_vence_flujo_compra_orig'      = convert(char(10),Swap.fecha_vence_flujo,23) --fecha_termino    
   ,  'PlazoFlujo_compra_orig'       = Swap.PlazoFlujo    
   ,  'Monto_compra_orig'         = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.compra_saldo + Swap.compra_amortiza)    
   ,  'Monto_amortiza_compra_orig'      = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.compra_amortiza)    
   --,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig'  = ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(30),Swap.compra_spread))) + '%' --> Para Op: 2569    
   --,     'Monto_Interes_Pactada_mas_Spread_Compra_Orig'  = ltrim(rtrim(convert(char(10),round(compra_interes, 2)))) --> Para Op: 4799    
   --,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig'  = convert(char(30),compra_interes)    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig'  = (SELECT CASE WHEN Swap.compra_spread > 0 THEN     
                        ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(30),Swap.compra_spread))) + '%'    
                       WHEN   Swap.compra_spread = 0 THEN      
                        convert(char(30),compra_interes)    
                      END)    
                     
        
        
    /*******************************  MODIFICACIONES  ***********************************/    
    -----> VENTA (Con Modificaciones)    
        --select      
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
    
          
-----> COMPRA (Con Modificaciones)    
        --select      
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = '' 
   ,  'Fecha_de_Pago_Compra_Mod'      = '' --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod' = ''    
       
   ----> Condiciones Financieras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
       
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
   ----> //* Datos Apoderado    
   ,  'Domicilio_Cliente'  =   ''    
   ,  'Fono_Cliente'   = '' --0    
   ,  'Fax_Cliente'   = '' --0    
   ,  'Apoderado_Uno' = ''  
   ,  'Rut_Apoderado_Uno' = ''  
      ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

   ,	'Nombre_Apoderado_Cli_uno' = ''
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''	
       
    FROM BacSwapSuda.dbo.CARTERARES swap    
     
     INNER JOIN (select tbcodigo1, tbglosa     
        from bacparamsuda..tabla_general_detalle     
        where tbcateg = 1042    
        )  Indicador On Indicador.tbcodigo1 = Swap.compra_codigo_tasa    
     INNER JOIN (SELECT mncodmon, mnnemo     
        FROM BACPARAMSUDA..MONEDA     
        )  md on md.MNCODMON = swap.compra_moneda    
    where  Swap.numero_operacion = @Num_Oper     
       and   Swap.tipo_flujo        = 1    
         and  fecha_modifica = @FechaContrato    
       AND  PLAZOFLUJO > 0    
    
/***************************************************************/    
UNION    
---> MODIFICACIONES    
---> VENTAS    
     
 ----> flujos Compras contrato original    
 SELECT    
   'ID' = 3    
      , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = ''    
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
   -- ,  'numero_flujo_venta_orig'   = 0    
        
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'     = ''    
    ,  'fecha_inicio_flujo_compra_orig'     = ''    
    ,  'fecha_vence_flujo_compra_orig'      = ''     
    ,  'PlazoFlujo_compra_orig'       = 0    
    ,  'Monto_compra_orig'         = ''    
    ,  'Monoto_amortiza_compra_orig'      = ''    
    --,  'compra_interes_compra_orig'      = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig'  = ''    
        
    /**************  MODIFICACIONES CARTERA HISTORICA ******************/    
    -----> VENTA (Con Modificaciones)    
        --select      
            
       
   ,  'Fecha_Fijacion_Tasa_venta_Mod'    = convert(char(10),Swap.fecha_fijacion_tasa,23)    
   ,  'Fecha_Inicio_Flujo_venta_Mod'    = convert(char(10),Swap.fecha_inicio_flujo,23)    
   ,  'Fecha_de_Pago_venta_Mod'     = convert(char(10),Swap.fecha_vence_flujo,23) --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'     = Swap.PlazoFlujo    
   ,  'Monto_Contratado_Vigente_venta_Mod'  = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.venta_saldo + Swap.venta_amortiza)    
   ,  'Monto_de_Amortizacion_venta_Mod'   = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.venta_amortiza)    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod'  = convert(char(30),venta_interes)    
            
       
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'      = '' --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod' = ''    
       
   ----> Condiciones Financieras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
       
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
   ----> //* Datos Apoderado    
   ,  'Domicilio_Cliente'  = ''    
   ,  'Fono_Cliente'   = '' --0    
   ,  'Fax_Cliente'   = '' --0    
   ,  'Apoderado_Uno' = ''  
   ,  'Rut_Apoderado_Uno' = ''  
      ,  'Apoderado_Dos'  = ''  
   ,  'Rut_Apoderado_Dos' = ''  

   ,	'Nombre_Apoderado_Cli_uno' = ''
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''	
       
  from BacSwapSuda.dbo.CarteraHis   swap    
      
     
     INNER JOIN (select tbcodigo1, tbglosa     
        from bacparamsuda..tabla_general_detalle     
        where tbcateg = 1042    
        )  Indicador On Indicador.tbcodigo1 = Swap.venta_codigo_tasa    
     INNER JOIN (SELECT mncodmon, mnnemo     
        FROM BACPARAMSUDA..MONEDA     
        )  md on md.MNCODMON = swap.venta_moneda    
    where  Swap.numero_operacion = @Num_Oper    
       and   Swap.tipo_flujo        = 2    
       AND  PLAZOFLUJO > 0    
           
    
      UNION    
             
 ----> flujos Compras contrato original    
 SELECT    
   'ID' = 3    
      , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = ''    
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
    --,  'numero_flujo_venta_orig'   = 0    
        
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'    = ''    
    ,  'fecha_inicio_flujo_compra_orig'    = ''    
    ,  'fecha_vence_flujo_compra_orig'     = ''     
    ,  'PlazoFlujo_compra_orig'      = 0    
    ,  'Monto_compra_orig'        = ''    
    ,  'Monto_amortiza_compra_orig'     = ''    
    --,  'compra_interes_compra_orig'     = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig' = ''    
        
    /******************  MODIFICACIONES CARTERA *************************/    
    -----> VENTA (Con Modificaciones)    
       
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = convert(char(10),Swap.fecha_fijacion_tasa,23)    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = convert(char(10),Swap.fecha_inicio_flujo,23)    
   ,  'Fecha_de_Pago_venta_Mod'    = convert(char(10),Swap.fecha_vence_flujo,23) --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = Swap.PlazoFlujo    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.venta_saldo + Swap.venta_amortiza)    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.venta_amortiza)    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = convert(char(40),venta_interes)    
                   
            
       
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'      = '' --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod' = ''    
       
         ----> Condiciones Financieras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
       
         -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
         ----> //* Datos Apoderado    
   ,  'Domicilio_Cliente'  = ''    
   ,  'Fono_Cliente'   = '' --0    
   ,  'Fax_Cliente'   = '' --0    
   ,  'Apoderado_Uno' = ''  
   ,  'Rut_Apoderado_Uno' = ''  
      ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

   ,	'Nombre_Apoderado_Cli_uno' = ''
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''	
       
  from BacSwapSuda.dbo.Cartera   swap    
    
      
     INNER JOIN (select tbcodigo1, tbglosa     
        from bacparamsuda..tabla_general_detalle     
        where tbcateg = 1042    
        )  Indicador On Indicador.tbcodigo1 = Swap.venta_codigo_tasa    
     INNER JOIN (SELECT mncodmon, mnnemo     
        FROM BACPARAMSUDA..MONEDA     
        )  md on md.MNCODMON = swap.venta_moneda    
    where  Swap.numero_operacion = @Num_Oper    
       and   Swap.tipo_flujo        = 2    
    
      
/***************************************************************/    
UNION    
---> MODIFICACIONES    
---> COMPRAS    
     
 ----> flujos Compras contrato original    
 SELECT    
   'ID' = 4    
      , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = ''    
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
    --,  'numero_flujo_venta_orig'   = 0    
        
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'    = ''    
    ,  'fecha_inicio_flujo_compra_orig'    = ''    
    ,  'fecha_vence_flujo_compra_orig'     = ''     
    ,  'PlazoFlujo_compra_orig'      = 0    
    ,  'Monto_compra_orig'        = ''    
    ,  'Monto_amortiza_compra_orig'     = ''    
   -- ,  'compra_interes_compra_orig'     = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig' = ''    
        
    /**************  MODIFICACIONES CARTERA HISTORICA ******************/    
    -----> COMPRAS (Con Modificaciones)    
        --select      
            
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
       
       
    ----> flujos Compras contrato Modificadas    
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = convert(char(10),Swap.fecha_fijacion_tasa,23)    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = convert(char(10),Swap.fecha_inicio_flujo,23)    
   ,  'Fecha_de_Pago_Compra_Mod'      = convert(char(10),Swap.fecha_vence_flujo,23) --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = Swap.PlazoFlujo    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.compra_saldo + Swap.compra_amortiza)    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.compra_amortiza)    
   --,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(30),Swap.compra_spread))) + '%' --> Para Op: 2569    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = ltrim(rtrim(convert(char(40),round(compra_interes, 2)))) --> Para Op: 4799    
       
      
      ----> Condiciones Financieras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
       
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
         ----> //* Datos Apoderado    
   ,  'Domicilio_Cliente'  = ''    
   ,  'Fono_Cliente'   = '' --0    
   ,  'Fax_Cliente' = '' --0    
   ,  'Apoderado_Uno' = ''  
   ,  'Rut_Apoderado_Uno' = ''  
      ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

   ,	'Nombre_Apoderado_Cli_uno' = '' 
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''
      
      
  from BacSwapSuda.dbo.CarteraHis   swap     
    
      
    INNER JOIN (select tbcodigo1, tbglosa     
        from bacparamsuda..tabla_general_detalle     
        where tbcateg = 1042    
        )  Indicador On Indicador.tbcodigo1 = Swap.compra_codigo_tasa    
    INNER JOIN (SELECT mncodmon, mnnemo     
        FROM BACPARAMSUDA..MONEDA     
        )  md on md.MNCODMON = swap.compra_moneda    
    where  Swap.numero_operacion = @Num_Oper     
       and   Swap.tipo_flujo        = 1    
    
      UNION    
             
 ----> flujos Compras contrato original    
 SELECT    
   'ID' = 4    
      , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = ''    
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
    --,  'numero_flujo_venta_orig'   = 0    
        
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'    = ''    
    ,  'fecha_inicio_flujo_compra_orig'    = ''    
    ,  'fecha_vence_flujo_compra_orig'     = ''     
    ,  'PlazoFlujo_compra_orig'      = 0    
    ,  'Monto_compra_orig'        = ''    
    ,  'Monto_amortiza_compra_orig'     = ''    
    --,  'compra_interes_compra_orig'     = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig' = ''    
        
    /******************  MODIFICACIONES CARTERA *************************/    
    -----> VENTA (Con Modificaciones)    
          
            
        --select      
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
         
       
   ----> flujos Compras contrato Modificadas    
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = convert(char(10),Swap.fecha_fijacion_tasa,23)    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = convert(char(10),Swap.fecha_inicio_flujo,23)    
   ,  'Fecha_de_Pago_Compra_Mod'      = convert(char(10),Swap.fecha_vence_flujo,23) --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = Swap.PlazoFlujo    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.compra_saldo + Swap.compra_amortiza)    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.compra_amortiza)    
   --,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(30),Swap.compra_spread))) + '%'     
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = ltrim(rtrim(convert(char(40),round(compra_interes, 2)))) --> Para Op: 4799    
       
   ----> Condiciones Financieras Compras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
      
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
        ----> //* Datos Apoderado    
   ,  'Domicilio_Cliente'  = ''    
   ,  'Fono_Cliente'   = '' --0    
   ,  'Fax_Cliente'   = '' --0   
   ,  'Apoderado_Uno' = ''  
   ,  'Rut_Apoderado_Uno' = ''  
      ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

   ,	'Nombre_Apoderado_Cli_uno' = ''
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''
      
  from BacSwapSuda.dbo.Cartera  swap    
    
    INNER JOIN (select tbcodigo1, tbglosa     
        from bacparamsuda..tabla_general_detalle     
        where tbcateg = 1042    
        )  Indicador On Indicador.tbcodigo1 = Swap.compra_codigo_tasa    
    INNER JOIN (SELECT mncodmon, mnnemo     
        FROM BACPARAMSUDA..MONEDA     
        )  md on md.MNCODMON = swap.compra_moneda    
    where  Swap.numero_operacion = @Num_Oper     
       and   Swap.tipo_flujo        = 1    
    
    
UNION    
    
----> Nuevas Condiciones Financieras Compras     
 SELECT    
   'ID' = 5    
      , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = cli.clnombre     
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
    --,  'numero_flujo_venta_orig'   = 0    
        
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'    = ''    
    ,  'fecha_inicio_flujo_compra_orig'    = ''    
    ,  'fecha_vence_flujo_compra_orig'     = ''     
    ,  'PlazoFlujo_compra_orig'      = 0    
    ,  'Monto_compra_orig'        = ''    
    ,  'Monto_amortiza_compra_orig'     = ''    
   -- ,  'compra_interes_compra_orig'     = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig' = ''    
        
    /**************  MODIFICACIONES CARTERA HISTORICA ******************/    
    -----> COMPRAS (Con Modificaciones)    
        --select      
            
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
       
      
    ----> flujos Compras contrato Modificadas    
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'      = ''    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'  = ''    
   --,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(30),Swap.compra_spread))) + '%' --> Para Op: 2569    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = '' --> Para Op: 4799    
    
    
    
   -----> //** Condiciones Financieras Modificadas Compras**//    
     
   ,  'Monto_Nueva_Condic_Banco'   = carvcda.compra_saldo + carvcda.compra_amortiza    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = convert(char(10),fecha_inicio,23)    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = convert(char(10),fecha_termino,23)    
       
      -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
         ----> //* Datos Apoderado    
   ,  'Domicilio_Cliente'  = ''    
   ,  'Fono_Cliente'   = '' --0    
   ,  'Fax_Cliente'   = '' --0    
   ,  'Apoderado_Uno' = ''  
   ,  'Rut_Apoderado_Uno' = ''  
      ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

    ,	'Nombre_Apoderado_Cli_uno' = ''
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''
       
   from BacSwapSuda.dbo.CARTERAHIS carvcda with(nolock)    
     inner join ( select Folio = numero_operacion    
          , Flujo = MIN( numero_flujo )    
          , Tipo = tipo_flujo    
         from BacSwapSuda.dbo.CARTERAHIS with(nolock)    
         where --fecha_modifica = '2013-01-29    
         fecha_modifica = (select max(fechamodificacion) from  baclineas.dbo.TBL_MODIFICACIAONES where FolioContrato = @Num_Oper)    
         
         
          AND numero_operacion= @Num_Oper    
         and  tipo_flujo  = 1    
         group     
         by  numero_operacion    
          , tipo_flujo    
        ) Grp  On Grp.Folio = carvcda.NUMERO_OPERACION    
           and Grp.Flujo = carvcda.NUMERO_FLUJO    
           and Grp.Tipo = carvcda.tipo_flujo    
         inner join bacparamsuda..cliente  cli on  cli.clrut = carvcda.rut_cliente    
               
UNION           
----> Nuevas Condiciones Financieras Compras     
 SELECT    
   'ID' = 6    
      , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = cli.clnombre    
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
    --,  'numero_flujo_venta_orig'   = 0    
        
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'    = ''    
    ,  'fecha_inicio_flujo_compra_orig'    = ''    
    ,  'fecha_vence_flujo_compra_orig'     = ''     
    ,  'PlazoFlujo_compra_orig'      = 0    
    ,  'Monto_compra_orig'        = ''    
    ,  'Monto_amortiza_compra_orig'     = ''    
   -- ,  'compra_interes_compra_orig'     = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig' = ''    
        
    /**************  MODIFICACIONES CARTERA HISTORICA ******************/    
    -----> COMPRAS (Con Modificaciones)    
        --select      
            
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
       
      
    ----> flujos Compras contrato Modificadas    
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'      = ''    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   --,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(30),Swap.compra_spread))) + '%' --> Para Op: 2569    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = '' --> Para Op: 4799    
        
               
   -----> //** Condiciones Financieras Modificadas Compras**//    
     
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
               
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = carvcda.venta_saldo + carvcda.venta_amortiza    
,  'Fecha_Inicio_Nueva_Cond_Cliente'  = convert(char(10),fecha_inicio,23)    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = convert(char(10),fecha_termino,23)    
       
         ----> //* Datos Apoderado    
   ,  'Domicilio_Cliente'  = ''    
   ,  'Fono_Cliente'   = '' --0    
   ,  'Fax_Cliente'   = '' --0    
   ,  'Apoderado_Uno' = ''  
   ,  'Rut_Apoderado_Uno' = ''  
      ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

   ,	'Nombre_Apoderado_Cli_uno' = ''
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''
       
   from BacSwapSuda.dbo.CARTERAHIS carvcda with(nolock)    
     inner join ( select Folio = numero_operacion    
          , Flujo = MIN( numero_flujo )    
          , Tipo = tipo_flujo    
         from BacSwapSuda.dbo.CARTERAHIS with(nolock)    
         where --fecha_modifica = '2013-01-29    
         fecha_modifica = (select max(fechamodificacion) from  baclineas.dbo.TBL_MODIFICACIAONES where FolioContrato = @Num_Oper)    
         and  numero_operacion= @Num_Oper    
         and  tipo_flujo  = 2    
         group     
         by  numero_operacion    
          , tipo_flujo    
        ) Grp  On Grp.Folio = carvcda.NUMERO_OPERACION    
           and Grp.Flujo = carvcda.NUMERO_FLUJO    
           and Grp.Tipo = carvcda.tipo_flujo    
    inner join bacparamsuda..cliente  cli on  cli.clrut = carvcda.rut_cliente  
    
     
END ELSE    
BEGIN    
 --print 'ANTICIPADA'    
 IF @SeModifico = 'Anticipada'    
  begin    
  DECLARE @FechaAnticipo DATETIME    
  DECLARE @Fecha_Termino DATETIME    
  set @FechaAnticipo = (select MAX( fechaAnticipo ) from cartera_unwind where numero_operacion = @Num_Oper)    
  set @Fecha_Termino = (select MAX( fecha_Termino ) from cartera_unwind where numero_operacion = @Num_Oper)    
     
    DELETE FROM dbo.ADENDUM_InformacionSWAP  
   
 INSERT INTO dbo.ADENDUM_InformacionSWAP  
     
  select top 1    
  'ID'      = 0     
     , 'Folio'      = @Num_Oper  
,  'Tipo_Contrato'    = tbglosa    
,  'Fecha_Modif_Contrato'  --= BacParamSuda.dbo.FxFechaLarga( @FechaAnticipo, 1)    
							 = (select  convert(char(2), @FechaAnticipo, 103) + ' de '  
						   +     case  when datepart( month, @FechaAnticipo) = 1  then 'Enero'  
							when datepart( month, @FechaAnticipo) = 2  then 'Febrero'  
							when datepart( month, @FechaAnticipo) = 3  then 'Marzo'  
							when datepart( month, @FechaAnticipo) = 4  then 'Abril'  
							when datepart( month, @FechaAnticipo) = 5  then 'Mayo'  
							when datepart( month, @FechaAnticipo) = 6  then 'Junio'  
							when datepart( month, @FechaAnticipo) = 7  then 'Julio'  
							when datepart( month, @FechaAnticipo) = 8  then 'Agosto'  
							when datepart( month, @FechaAnticipo) = 9  then 'Septiembre'  
							when datepart( month, @FechaAnticipo) = 10 then 'Octubre'  
							when datepart( month, @FechaAnticipo) = 11 then 'Noviembre'  
							when datepart( month, @FechaAnticipo) = 12 then 'Diciembre'  
							   end + ' de '   
							+     ltrim(rtrim( datepart(year, @FechaAnticipo) )))   
    
     
,  'Fecha_Inicio_Contrato'  --= BacParamSuda.dbo.FxFechaLarga( @FechaContrato, 1)   
							= (select  convert(char(2), @FechaContrato, 103) + ' de '  
						   +     case  when datepart( month, @FechaContrato) = 1  then 'Enero'  
							when datepart( month, @FechaContrato) = 2  then 'Febrero'  
							when datepart( month, @FechaContrato) = 3  then 'Marzo'  
							when datepart( month, @FechaContrato) = 4  then 'Abril'  
							when datepart( month, @FechaContrato) = 5  then 'Mayo'  
							when datepart( month, @FechaContrato) = 6  then 'Junio'  
							when datepart( month, @FechaContrato) = 7  then 'Julio'  
							when datepart( month, @FechaContrato) = 8  then 'Agosto'  
							when datepart( month, @FechaContrato) = 9  then 'Septiembre'  
							when datepart( month, @FechaContrato) = 10 then 'Octubre'  
							when datepart( month, @FechaContrato) = 11 then 'Noviembre'  
							when datepart( month, @FechaContrato) = 12 then 'Diciembre'  
							   end + ' de '   
							+     ltrim(rtrim( datepart(year, @FechaContrato) )))   
    
              
,  'Fecha_Venc_Contrato'  = (select max(fecha_vence_flujo) from BacSwapSuda.dbo.carteraRes     
          where numero_operacion = @Num_Oper and tipo_flujo = 1)    
,  'Monto_Contrato_Banco'  = (select top 1 compra_capital from BacSwapSuda.dbo.carteraRes     
          where numero_operacion = @Num_Oper AND  TIPO_FLUJO = 1) -- and fecha_modifica = (select Fecha_Operacion from baclineas..DETALLE_APROBACIONES     
          --where numero_operacion = @Num_Oper AND ID_SISTEMA = 'PCS'    
         -- and estado = 'A'))    
,  'Monto_Contrato_Cliente' = (select top 1 venta_capital from BacSwapSuda.dbo.carteraRes     
          where numero_operacion = @Num_Oper AND  TIPO_FLUJO = 2) -- and  fecha_modifica = (select Fecha_Operacion from baclineas..DETALLE_APROBACIONES     
          --where numero_operacion = @Num_Oper AND ID_SISTEMA = 'PCS'    
          --and estado = 'A'))    
,  'Nombre_Cliente'   = (select par.clnombre from bacparamsuda..cliente par    
          where par.clrut = ca.rut_cliente    
          and ca.numero_operacion = @Num_Oper --and cr,tipo_flujo = 2    
          group by par.clnombre)    
,  'Rut_Cliente'    = ca.rut_cliente    
    
 ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig'   = ''    
    ,  'fecha_inicio_flujo_venta_orig'    = ''    
    ,  'fecha_vence_flujo_venta_orig'    = ''    
    ,  'PlazoFlujo_venta_orig'      = 0    
    ,  'Monto_Contratado_Vig_venta_Orig'   = '' --venta_saldo + venta_amortiza    
    ,  'Monto_amortiza_venta_orig'     = ''    
    ,  'Monto_interes_Pactada_fija_venta_orig'  = ''    
    --,  'numero_flujo_venta_orig'   = 0     
        
    ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig' = ''    
    ,  'fecha_inicio_flujo_compra_orig' = ''     
    ,  'fecha_vence_flujo_compra_orig'  = ''    
    ,  'PlazoFlujo_compra_orig'   = 0    
    ,  'Monto_Contrato_Vig_compra_orig' = '' --compra_saldo + compra_amortiza    
    ,  'Monto_amortiza_compra_orig'  = ''    
   -- ,  'compra_interes_compra_orig'  = 0    
    --,  'Monto_Interes_Pactada_mas_Spread' = ''    
 ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig' = ''    
        
      
/*******************************  MODIFICACIONES  ***********************************/    
    -----> VENTA (Con Modificaciones)    
        --select      
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
       
         
-----> COMPRA (Con Modificaciones)    
        --select      
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'  = '' --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod' = ''    
    
   ----> Condiciones Financieras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
       
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
   ---> //* Datos Apoderado    
   ,  'Domicilio_Cliente'  = cliente.cldirecc    
   ,  'Fono_Cliente'   = cliente.clfono    
   ,  'Fax_Cliente'   = cliente.clfax    
   ,  'Apoderado_Uno'  = apoderado1.apnombre  
   ,  'Rut_Apoderado_Uno' = rtrim(ltrim(convert(char(10),apoderado1.aprutapo))) + '-' + apoderado1.apdvapo  
   ,  'Apoderado_Dos'  =   apoderado2.apnombre  
   ,  'Rut_Apoderado_Dos' = rtrim(ltrim(convert(char(10),apoderado2.aprutapo))) + '-' + apoderado2.apdvapo  

    ,	'Nombre_Apoderado_Cli_uno' = @cNom_Apoderado_Cliente_1 
   ,  'Rut_Apoderado_Cli_Uno' = @cRut_Apoderado_Cliente_1
    ,	'Nombre_Apoderado_Cli_dos' = @cNom_Apoderado_Cliente_2
   ,  'Rut_Apoderado_Cli_dos' = @cRut_Apoderado_Cliente_2

   , 'Fecha_Firma_CCG'	= ''
              
from bacparamsuda..tabla_general_detalle gd    
--, cartera ca --> para operac. 2569 MODIFICADA    
, carteraLog ca --> para operac. 4799 ANTICIPADA    
inner join bacparamsuda.dbo.cliente cliente with(nolock) On cliente.clrut = ca.rut_cliente    
inner join bacparamsuda.dbo.CLIENTE_APODERADO apoderado1 with(nolock) On apoderado1.aprutapo = @RutApoderado1  
inner join bacparamsuda.dbo.CLIENTE_APODERADO apoderado2 with(nolock) On apoderado2.aprutapo = @RutApoderado2  
where gd.tbcateg   = 1050     
and  gd.tbcodigo1  = ca.tipo_swap    
and  ca.numero_operacion = @Num_Oper    
    
    
    
union    
    
/*********************** ORIGINAL ********************************/    
  ----> flujos ventas contrato original    
    SELECT     
   'ID' = 1    
    , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = ''    
    ,  'Rut_Cliente' = 0    
        
       
       ----> flujos Ventas contrato original    
   ,  'fecha_fijacion_tasa_venta_orig'   = convert(char(10),Swap.fecha_fijacion_tasa,23)    
   ,  'fecha_inicio_flujo_venta_orig'    = convert(char(10),Swap.fecha_inicio_flujo,23)    
   ,  'fecha_vence_flujo_venta_orig'    = convert(char(10),Swap.fecha_vence_flujo,23) --fecha_termino    
   ,  'PlazoFlujo_venta_orig'      = Swap.PlazoFlujo    
   ,  'Monto_Contratado_Vig_venta_Orig'   = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.venta_saldo + Swap.venta_amortiza)    
   ,  'Monto_amortiza_venta_orig'     = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.venta_amortiza)    
   ,  'Monto_Interes_Pactada_Fija_venta_Orig'  = (SELECT CASE WHEN venta_spread > 0 THEN     
                        
                   ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(80),Swap.venta_spread))) + '%'    
                   WHEN   venta_spread = 0 THEN    
                       
                       
                   CONVERT(CHAR(15),venta_interes)     
                 END)    
    
       
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'     = ''    
    ,  'fecha_inicio_flujo_compra_orig'     = ''     
    ,  'fecha_vence_flujo_compra_orig'      = ''    
    ,  'PlazoFlujo_compra_orig'       = 0    
    ,  'Monto_compra_orig'         = '' --compra_saldo + compra_amortiza    
    ,  'Monto_amortiza_compra_orig'      = ''    
   -- ,  'compra_interes_compra_orig'      = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig'  = ''    
        
  /*******************************  MODIFICACIONES  ***********************************/    
    -----> VENTA (Con Modificaciones)    
        --select      
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
    
          
-----> COMPRA (Con Modificaciones)    
        --select      
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'      = '' --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod' = ''    
        
   ----> Condiciones Financieras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
       
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
      ---> //* Datos Apoderado    
   ,  'Domicilio_Cliente'      = ''    
   ,  'Fono_Cliente'       = '' --0    
   ,  'Fax_Cliente'       = '' --0   
   ,  'Apoderado_Uno'  = ''  
   ,  'Rut_Apoderado_Uno' = ''  
   ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

    ,	'Nombre_Apoderado_Cli_uno' = '' 
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''
        
        
    FROM BacSwapSuda.dbo.CARTERARES swap    
    
    
     INNER JOIN (select tbcodigo1, tbglosa     
        from bacparamsuda..tabla_general_detalle     
        where tbcateg = 1042    
        )  Indicador On Indicador.tbcodigo1 = Swap.venta_codigo_tasa    
     INNER JOIN (SELECT mncodmon, mnnemo     
        FROM BACPARAMSUDA..MONEDA     
        )  md on md.MNCODMON = swap.venta_moneda    
    where  Swap.numero_operacion = @Num_Oper    
       and   Swap.tipo_flujo        = 2    
       -----and  fecha_modifica = '2011-03-07'     
        --and  fecha_modifica = @FechaInicio    
        and  fecha_modifica = @FechaContrato    
       AND  PLAZOFLUJO > 0    
    
    
union    
     
 ----> flujos Compras contrato original    
 SELECT    
   'ID' = 2    
    , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = ''    
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
    --,  'numero_flujo_venta_orig'   = 0    
        
        
        
        ----> flujos Compras contrato original    
   ,  'fecha_fijacion_tasa_compra_orig'     = convert(char(10),Swap.fecha_fijacion_tasa,23)    
   ,  'fecha_inicio_flujo_compra_orig'     = convert(char(10),Swap.fecha_inicio_flujo,23)    
   ,  'fecha_vence_flujo_compra_orig'      = convert(char(10),Swap.fecha_vence_flujo,23) --fecha_termino    
   ,  'PlazoFlujo_compra_orig'       = Swap.PlazoFlujo    
   ,  'Monto_compra_orig'         = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.compra_saldo + Swap.compra_amortiza)    
   ,  'Monto_amortiza_compra_orig'      = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.compra_amortiza)    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig'  = (SELECT CASE WHEN Swap.compra_spread > 0 THEN     
                        ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(30),Swap.compra_spread))) + '%'    
                       WHEN   Swap.compra_spread = 0 THEN      
                        convert(char(30),compra_interes)    
                      END)    
                       
        
        
    /*******************************  MODIFICACIONES  ***********************************/    
    -----> VENTA (Con Modificaciones)    
        --select      
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
    
          
-----> COMPRA (Con Modificaciones) 
        --select      
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'      = '' --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod' = ''    
       
   ----> Condiciones Financieras 
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
       
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
         ---> //* Datos Apoderado    
   ,  'Domicilio_Cliente'      = ''    
   ,  'Fono_Cliente'       = '' --0    
   ,  'Fax_Cliente'       = '' --0    
      ,  'Apoderado_Uno'  = ''  
   ,  'Rut_Apoderado_Uno' = ''  
   ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

       ,	'Nombre_Apoderado_Cli_uno' = '' 
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''
       
    FROM BacSwapSuda.dbo.CARTERARES swap    
     
     INNER JOIN (select tbcodigo1, tbglosa     
        from bacparamsuda..tabla_general_detalle     
        where tbcateg = 1042    
        )  Indicador On Indicador.tbcodigo1 = Swap.compra_codigo_tasa    
     INNER JOIN (SELECT mncodmon, mnnemo     
        FROM BACPARAMSUDA..MONEDA     
        )  md on md.MNCODMON = swap.compra_moneda    
    where  Swap.numero_operacion = @Num_Oper     
       and   Swap.tipo_flujo        = 1    
        and  fecha_modifica = @FechaContrato    
       AND  PLAZOFLUJO > 0    
    
/***************************************************************/    
UNION    
---> MODIFICACIONES    
---> VENTAS    
     
 ----> flujos Compras contrato original    
 SELECT    
   'ID' = 3    
    , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = ''    
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
  ,  'Monto_interes_venta_orig'   = ''    
   -- ,  'numero_flujo_venta_orig'   = 0    
        
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'     = ''    
    ,  'fecha_inicio_flujo_compra_orig'     = ''    
    ,  'fecha_vence_flujo_compra_orig'      = ''     
    ,  'PlazoFlujo_compra_orig'       = 0    
    ,  'Monto_compra_orig'         = ''    
    ,  'Monoto_amortiza_compra_orig'      = ''    
    --,  'compra_interes_compra_orig'      = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig'  = ''    
        
    /**************  MODIFICACIONES CARTERA HISTORICA ******************/    
    -----> VENTA (Con Modificaciones)    
        --select      
            
       
   ,  'Fecha_Fijacion_Tasa_venta_Mod'    = convert(char(10),Swap.fecha_fijacion_tasa,23)    
   ,  'Fecha_Inicio_Flujo_venta_Mod'    = convert(char(10),Swap.fecha_inicio_flujo,23)    
   ,  'Fecha_de_Pago_venta_Mod'     = convert(char(10),Swap.fecha_vence_flujo,23) --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'     = Swap.PlazoFlujo    
   ,  'Monto_Contratado_Vigente_venta_Mod'  = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.venta_saldo + Swap.venta_amortiza)    
   ,  'Monto_de_Amortizacion_venta_Mod'   = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.venta_amortiza)    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod'  = convert(char(30),venta_interes)    
            
       
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'      = '' --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod' = ''    
       
   ----> Condiciones Financieras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
       
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
   ---> //* Datos Apoderado    
   ,  'Domicilio_Cliente'      = ''    
   ,  'Fono_Cliente'       = '' --0  
   ,  'Fax_Cliente'       = '' --0    
      ,  'Apoderado_Uno'  = ''  
   ,  'Rut_Apoderado_Uno' = ''  
   ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

       ,	'Nombre_Apoderado_Cli_uno' = '' 
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''
       
  from BacSwapSuda.dbo.Cartera_unwind swap --> Para operacion 4799    
      
     
     INNER JOIN (select tbcodigo1, tbglosa     
        from bacparamsuda..tabla_general_detalle     
        where tbcateg = 1042    
        )  Indicador On Indicador.tbcodigo1 = Swap.venta_codigo_tasa    
     INNER JOIN (SELECT mncodmon, mnnemo     
        FROM BACPARAMSUDA..MONEDA     
        )  md on md.MNCODMON = swap.venta_moneda    
    where  Swap.numero_operacion = @Num_Oper    
   --> Para operacion 4799    
    and   FechaAnticipo = @FechaAnticipo --'20120706'    
    and   fecha_termino = @Fecha_Termino --'20120706'    
   --> ******************    
       and   Swap.tipo_flujo        = 2    
       --and  fecha_modifica = '2011-03-07'     
       AND  PLAZOFLUJO > 0    
         
    
      UNION    
             
 ----> flujos Compras contrato original    
 SELECT    
   'ID' = 3    
    , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = ''    
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
    --,  'numero_flujo_venta_orig'   = 0    
        
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'    = ''    
    ,  'fecha_inicio_flujo_compra_orig'    = ''    
    ,  'fecha_vence_flujo_compra_orig'     = ''     
    ,  'PlazoFlujo_compra_orig'      = 0    
    ,  'Monto_compra_orig'        = ''    
    ,  'Monto_amortiza_compra_orig'     = ''    
    --,  'compra_interes_compra_orig'     = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig' = ''    
        
    /******************  MODIFICACIONES CARTERA *************************/    
    -----> VENTA (Con Modificaciones)    
        --select      
    ----> flujos Ventas Modificadas    
       
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = convert(char(10),Swap.fecha_fijacion_tasa,23)    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = convert(char(10),Swap.fecha_inicio_flujo,23)    
   ,  'Fecha_de_Pago_venta_Mod'    = convert(char(10),Swap.fecha_vence_flujo,23) --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = Swap.PlazoFlujo    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.venta_saldo + Swap.venta_amortiza)    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.venta_amortiza)    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = convert(char(40),venta_interes)    
                   
            
       
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'      = '' --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod' = ''    
       
         ----> Condiciones Financieras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
       
         -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
      ---> //* Datos Apoderado    
   ,  'Domicilio_Cliente'      = ''    
   ,  'Fono_Cliente'       = '' --0    
   ,  'Fax_Cliente'       = '' --0    
      ,  'Apoderado_Uno'  = ''  
   ,  'Rut_Apoderado_Uno' = ''  
   ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

       ,	'Nombre_Apoderado_Cli_uno' = '' 
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''
       
  from BacSwapSuda.dbo.Cartera   swap    
      
    
     INNER JOIN (select tbcodigo1, tbglosa     
        from bacparamsuda..tabla_general_detalle     
        where tbcateg = 1042    
        )  Indicador On Indicador.tbcodigo1 = Swap.venta_codigo_tasa    
     INNER JOIN (SELECT mncodmon, mnnemo     
        FROM BACPARAMSUDA..MONEDA     
        )  md on md.MNCODMON = swap.venta_moneda    
    where  Swap.numero_operacion = @Num_Oper    
       and   Swap.tipo_flujo        = 2    
    
/***************************************************************/    
UNION    
---> MODIFICACIONES    
---> COMPRAS    
     
 ----> flujos Compras contrato original    
 SELECT    
   'ID' = 4    
    , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = ''    
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
    --,  'numero_flujo_venta_orig'   = 0    
        
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'    = ''    
    ,  'fecha_inicio_flujo_compra_orig'    = ''    
    ,  'fecha_vence_flujo_compra_orig'     = ''     
    ,  'PlazoFlujo_compra_orig'      = 0    
    ,  'Monto_compra_orig'        = ''    
    ,  'Monto_amortiza_compra_orig'     = ''    
   -- ,  'compra_interes_compra_orig'     = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig' = ''    
        
    /**************  MODIFICACIONES CARTERA HISTORICA ******************/    
    -----> COMPRAS (Con Modificaciones)    
        --select      
            
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
       

    ----> flujos Compras contrato Modificadas    
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = convert(char(10),Swap.fecha_fijacion_tasa,23)    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = convert(char(10),Swap.fecha_inicio_flujo,23)    
   ,  'Fecha_de_Pago_Compra_Mod'      = convert(char(10),Swap.fecha_vence_flujo,23) --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = Swap.PlazoFlujo    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.compra_saldo + Swap.compra_amortiza)    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.compra_amortiza)    
   --,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(30),Swap.compra_spread))) + '%' --> Para Op: 2569    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = ltrim(rtrim(convert(char(40),round(compra_interes, 2)))) --> Para Op: 4799    
       
      
      ----> Condiciones Financieras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
       
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
      ---> //* Datos Apoderado    
   ,  'Domicilio_Cliente'      = ''    
   ,  'Fono_Cliente'       = '' --0    
   ,  'Fax_Cliente'       = '' --0    
      ,  'Apoderado_Uno'  = ''  
   ,  'Rut_Apoderado_Uno' = ''  
   ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  


       ,	'Nombre_Apoderado_Cli_uno' = '' 
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''
      
      
  --from BacSwapSuda.dbo.CarteraHis   swap     
  from BacSwapSuda.dbo.Cartera_unwind swap    
    
    INNER JOIN (select tbcodigo1, tbglosa     
        from bacparamsuda..tabla_general_detalle     
        where tbcateg = 1042    
        )  Indicador On Indicador.tbcodigo1 = Swap.compra_codigo_tasa    
    INNER JOIN (SELECT mncodmon, mnnemo     
        FROM BACPARAMSUDA..MONEDA     
        )  md on md.MNCODMON = swap.compra_moneda    
    where  Swap.numero_operacion = @Num_Oper     
       --> Para operacion 4799    
     and   FechaAnticipo = @FechaAnticipo --'20120706'    
    and   fecha_termino = @Fecha_Termino --'20120706'    
   --> ******************    
       and   Swap.tipo_flujo        = 1    
    
      UNION    
             
 ----> flujos Compras contrato original    
 SELECT    
   'ID' = 4    
    , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = ''    
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
    --,  'numero_flujo_venta_orig'   = 0    
        
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'    = ''    
    ,  'fecha_inicio_flujo_compra_orig'    = ''    
    ,  'fecha_vence_flujo_compra_orig'     = ''     
    ,  'PlazoFlujo_compra_orig'      = 0    
    ,  'Monto_compra_orig'        = ''    
    ,  'Monto_amortiza_compra_orig' = ''    
    --,  'compra_interes_compra_orig'     = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig' = ''    
        
    /******************  MODIFICACIONES CARTERA *************************/    
    -----> VENTA (Con Modificaciones)    
          
            
        --select      
  ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
         
       
----> flujos Compras contrato Modificadas    
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = convert(char(10),Swap.fecha_fijacion_tasa,23)    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = convert(char(10),Swap.fecha_inicio_flujo,23)    
   ,  'Fecha_de_Pago_Compra_Mod'      = convert(char(10),Swap.fecha_vence_flujo,23) --fecha_termino    
   ,  'Numero_de_dias_Compra_Mod'      = Swap.PlazoFlujo    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.compra_saldo + Swap.compra_amortiza)    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ltrim(rtrim(md.mnnemo)) + ' ' + convert(char(40),Swap.compra_amortiza)    
   --,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(30),Swap.compra_spread))) + '%'     
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = ltrim(rtrim(convert(char(40),round(compra_interes, 2)))) --> Para Op: 4799    
       
   ----> Condiciones Financieras Compras    
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
      
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
      ---> //* Datos Apoderado    
   ,  'Domicilio_Cliente'      = ''    
   ,  'Fono_Cliente'       = '' --0    
   ,  'Fax_Cliente'       = '' --0   
      ,  'Apoderado_Uno'  = ''  
   ,  'Rut_Apoderado_Uno' = ''  
   ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

       ,	'Nombre_Apoderado_Cli_uno' = '' 
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''
      
      
  from BacSwapSuda.dbo.Cartera  swap    
  --where numero_operacion = 2569     
  --and         tipo_flujo        = 1    
      
      
        
    INNER JOIN (select tbcodigo1, tbglosa     
        from bacparamsuda..tabla_general_detalle     
        where tbcateg = 1042    
        )  Indicador On Indicador.tbcodigo1 = Swap.compra_codigo_tasa    
    INNER JOIN (SELECT mncodmon, mnnemo     
        FROM BACPARAMSUDA..MONEDA     
        )  md on md.MNCODMON = swap.compra_moneda    
    where  Swap.numero_operacion = @Num_Oper     
       and   Swap.tipo_flujo        = 1    
    
    
UNION    
    
----> Nuevas Condiciones Financieras Compras     
 SELECT    
   'ID' = 5    
    , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = cli.clnombre     
    ,  'Rut_Cliente' = 0    
     
   
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
    --,  'numero_flujo_venta_orig'   = 0    
        
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'    = ''    
    ,  'fecha_inicio_flujo_compra_orig'    = ''    
    ,  'fecha_vence_flujo_compra_orig'     = ''     
    ,  'PlazoFlujo_compra_orig'      = 0    
    ,  'Monto_compra_orig'        = ''    
    ,  'Monto_amortiza_compra_orig'     = ''    
   -- ,  'compra_interes_compra_orig'     = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig' = ''    
        
    /**************  MODIFICACIONES CARTERA HISTORICA ******************/ 
    -----> COMPRAS (Con Modificaciones)    
        --select      
            
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
     
      
    ----> flujos Compras contrato Modificadas    
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'      = ''    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   --,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(30),Swap.compra_spread))) + '%' --> Para Op: 2569    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = '' --> Para Op: 4799    
    
    
    
   -----> //** Condiciones Financieras Modificadas Compras**//    
     
   ,  'Monto_Nueva_Condic_Banco'   = carvcda.compra_saldo + carvcda.compra_amortiza    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = convert(char(10),fecha_inicio,23)    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = convert(char(10),fecha_termino,23)    
       
      -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = ''    
       
      ---> //* Datos Apoderado    
   ,  'Domicilio_Cliente'      = ''    
   ,  'Fono_Cliente'       = '' --0    
   ,  'Fax_Cliente'       = '' --0    
      ,  'Apoderado_Uno'  = ''  
   ,  'Rut_Apoderado_Uno' = ''  
   ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

       ,	'Nombre_Apoderado_Cli_uno' = '' 
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''
       
   from BacSwapSuda.dbo.CARTERAHIS carvcda with(nolock)    
     inner join ( select Folio = numero_operacion    
          , Flujo = MIN( numero_flujo )    
          , Tipo = tipo_flujo    
         from BacSwapSuda.dbo.CARTERAHIS with(nolock)    
         where --fecha_modifica = '2013-01-29    
         fecha_modifica = (select max(fechamodificacion) from  baclineas.dbo.TBL_MODIFICACIAONES where FolioContrato = @Num_Oper)    
         and  numero_operacion= @Num_Oper    
         and  tipo_flujo  = 1    
         group     
         by  numero_operacion    
          , tipo_flujo    
        ) Grp  On Grp.Folio = carvcda.NUMERO_OPERACION    
           and Grp.Flujo = carvcda.NUMERO_FLUJO    
           and Grp.Tipo = carvcda.tipo_flujo    
         inner join bacparamsuda..cliente  cli on  cli.clrut = carvcda.rut_cliente  
               
UNION           
----> Nuevas Condiciones Financieras Compras     
 SELECT    
   'ID' = 6    
    , 'Folio'      = ''  
 ,  'Tipo_Contrato' = ''    
    ,  'Fecha_Modif_Contrato' = ''    
    ,  'Fecha_Inicio_Contrato' = ''    
    ,  'Fecha_Venc_Contrato' = ''    
    ,  'Monto_Contrato_Banco' = 0    
    ,  'Monto_Contrato_Cliente' = 0    
    ,  'Nombre_Cliente' = cli.clnombre     
    ,  'Rut_Cliente' = 0    
     
     
  ----> flujos ventas contrato original    
    ,  'fecha_fijacion_tasa_venta_orig' = ''    
    ,  'fecha_inicio_flujo_venta_orig'  = ''    
    ,  'fecha_vence_flujo_venta_orig'  = ''     
    ,  'PlazoFlujo_venta_orig'    = 0    
    ,  'Monto_venta_Orig'     = ''    
    ,  'Monto_amortiza_venta_orig'   = ''    
    ,  'Monto_interes_venta_orig'   = ''    
    --,  'numero_flujo_venta_orig'   = 0    
        
        ----> flujos Compras contrato original    
    ,  'fecha_fijacion_tasa_compra_orig'    = ''    
    ,  'fecha_inicio_flujo_compra_orig'    = ''    
    ,  'fecha_vence_flujo_compra_orig'     = ''     
    ,  'PlazoFlujo_compra_orig'      = 0    
    ,  'Monto_compra_orig'   = ''    
   ,  'Monto_amortiza_compra_orig'     = ''    
   -- ,  'compra_interes_compra_orig'     = 0    
    ,  'Monto_Interes_Pactada_mas_Spread_Compra_Orig' = ''    
        
    /**************  MODIFICACIONES CARTERA HISTORICA ******************/    
    -----> COMPRAS (Con Modificaciones)    
        --select      
            
   ,  'Fecha_Fijacion_Tasa_venta_Mod'   = ''    
   ,  'Fecha_Inicio_Flujo_venta_Mod'   = ''    
   ,  'Fecha_de_Pago_venta_Mod'    = '' --fecha_termino    
   ,  'Numero_de_dias_venta_Mod'    = 0    
   ,  'Monto_Contratado_Vigente_venta_Mod' = ''    
   ,  'Monto_de_Amortizacion_venta_Mod'  = ''    
   ,  'Monto_Interes_Pactada_Fija_venta_Mod' = ''    
       
      
    ----> flujos Compras contrato Modificadas    
   ,  'Fecha_Fijacion_Tasa_Compra_Mod'    = ''    
   ,  'Fecha_Inicio_Flujo_Compra_Mod'     = ''    
   ,  'Fecha_de_Pago_Compra_Mod'      = ''    
   ,  'Numero_de_dias_Compra_Mod'      = 0    
   ,  'Monto_Contratado_Vigente_Compra_Mod'   = ''    
   ,  'Monto_de_Amortizacion_Compra_Mod'    = ''    
   --,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = ltrim(rtrim(Indicador.tbglosa)) + ' + ' + ltrim(rtrim(convert(char(30),Swap.compra_spread))) + '%' --> Para Op: 2569    
   ,  'Monto_Interes_Pactada_mas_Spread_Compra_Mod'  = '' --> Para Op: 4799    
        
               
   -----> //** Condiciones Financieras Modificadas Compras**//    
     
   ,  'Monto_Nueva_Condic_Banco'   = 0    
   ,  'Fecha_Inicio_Nueva_Cond_Banco'  = ''    
   ,  'Fecha_Termino_Nueva_Cond_Banco' = ''    
               
   -----> //** Condiciones Financieras Modificadas Ventas**//    
     
   ,  'Monto_Nueva_Condic_Cliente'   = carvcda.venta_saldo + carvcda.venta_amortiza    
   ,  'Fecha_Inicio_Nueva_Cond_Cliente'  = convert(char(10),fecha_inicio,23)    
   ,  'Fecha_Termino_Nueva_Cond_Cliente'  = convert(char(10),fecha_termino,23)    
       
      ---> //* Datos Apoderado    
   ,  'Domicilio_Cliente'      = ''    
   ,  'Fono_Cliente'       = '' --0    
   ,  'Fax_Cliente'       = '' --0    
      ,  'Apoderado_Uno'  = ''  
   ,  'Rut_Apoderado_Uno' = ''  
   ,  'Apoderado_Dos'  =   ''  
   ,  'Rut_Apoderado_Dos' = ''  

       ,	'Nombre_Apoderado_Cli_uno' = '' 
   ,  'Rut_Apoderado_Cli_Uno' = ''
    ,	'Nombre_Apoderado_Cli_dos' = ''
   ,  'Rut_Apoderado_Cli_dos' = ''

   , 'Fecha_Firma_CCG'	= ''
       
   from BacSwapSuda.dbo.CARTERAHIS carvcda with(nolock)    
     inner join ( select Folio = numero_operacion    
          , Flujo = MIN( numero_flujo )    
          , Tipo = tipo_flujo    
         from BacSwapSuda.dbo.CARTERAHIS with(nolock)    
         where --fecha_modifica = '2013-01-29    
         fecha_modifica = (select max(fechamodificacion) from  baclineas.dbo.TBL_MODIFICACIAONES where FolioContrato = @Num_Oper)    
         and  numero_operacion= @Num_Oper    
         and  tipo_flujo  = 2    
         group     
         by  numero_operacion    
          , tipo_flujo    
        ) Grp  On Grp.Folio = carvcda.NUMERO_OPERACION    
           and Grp.Flujo = carvcda.NUMERO_FLUJO    
           and Grp.Tipo = carvcda.tipo_flujo    
  inner join bacparamsuda..cliente  cli on  cli.clrut = carvcda.rut_cliente  
     
 END    
END    
END

GO
