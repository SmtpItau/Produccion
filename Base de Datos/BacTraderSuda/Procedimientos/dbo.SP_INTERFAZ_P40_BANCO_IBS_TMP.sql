USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_P40_BANCO_IBS_TMP]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_P40_BANCO_IBS_TMP]  
 ( @Fecha_Interfaz  DATETIME )      
AS      
BEGIN       
  
  SET NOCOUNT ON      
  
  
   
 declare @dFechaMercado datetime -- 'Fecha mercado (T0)'  
 declare @dFechacartera datetime -- 'Fecha cartera (+1)'  
 declare @dFechaProxima datetime  
  
 declare @nValorUF  NUMERIC(19,4)  --20200615.   
  
      
 if exists( select 1 from BacTraderSuda.dbo.Fechas_Proceso where acfecproc = @Fecha_Interfaz )  
 begin  
  select @dFechaMercado   = case when month(acfecproc) <> month(acfecprox) then dateadd(day,-1,dateadd(month,1,dateadd(day,1,dateadd(day,(day(acfecproc)*-1),acfecproc))))  
            else acfecproc  
                end  
   , @dFechacartera   = case when month(acfecproc) <> month(acfecprox) then dateadd(day,-1,dateadd(month,1,dateadd(day,1,dateadd(day,(day(acfecproc)*-1),acfecproc))))  
            else acfecprox  
                end  
  from BacTraderSuda.dbo.Fechas_Proceso   
  where acfecproc = @Fecha_Interfaz  
  
 end else  
 begin  
  
  SET  @dFechaProxima = @Fecha_Interfaz  
  EXECUTE BACTRADERSUDA..SP_BUSCA_FECHA_HABIL @dFechaProxima, 1, @dFechaProxima OUTPUT  
    
  select @dFechaMercado   = case when month(@Fecha_Interfaz) <> month(@dFechaProxima) then dateadd(day,-1,dateadd(month,1,dateadd(day,1,dateadd(day,(day(@Fecha_Interfaz)*-1),@Fecha_Interfaz))))  
            else @Fecha_Interfaz  
                end  
   , @dFechacartera   = case when month(@Fecha_Interfaz) <> month(@dFechaProxima) then dateadd(day,-1,dateadd(month,1,dateadd(day,1,dateadd(day,(day(@Fecha_Interfaz)*-1),@Fecha_Interfaz))))  
            else @dFechaProxima  
                end  
 end  
   
 --rescata VM UF  
    SELECT @nValorUF         = vmvalor FROM         BacParamSuda..VALOR_MONEDA  
    WHERE  vmfecha    = @dFechacartera AND   vmcodigo = 998  
      
  
 CREATE TABLE #TABLA_P40_MX     
 (  Tipo_Registro          varchar(2)  NOT NULL ,       --1    
   Codigo_Tenedor         char(3)      NOT NULL ,       --2    
   Fecha_Proceso          char(8)    NULL ,       --3    
   Fecha_Compra           char(8)    NULL ,       --4    
   Tipo_Cartera           numeric(5)     NOT NULL ,       --5    
   Emisor                 varchar (10)   NULL ,       --6    
   Pais_Emisor            int    NOT NULL ,       --7    
   Familia_Instrumento    VARCHAR(2)  NOT NULL ,       --8    
   Nemotecnico            char (20)   NULL ,       --9    
   Tipo_Rendimiento       int    NOT NULL ,       --10    
   Periodicidad_Cupon     decimal(5, 0)  NULL ,       --11    
   Fecha_Ultimo_Cupon     char (8)    NULL ,       --12    
   Fecha_Proximo_Cupon    char (8)    NULL ,       --13    
   Fecha_Vcto_Instr       char (8)    NULL ,       --14    
   Derivado_Incrust_Opc   char(2)   NOT NULL ,       --15    
   Nominal_Inicial        numeric(19, 4)  NULL ,       --16    
   Nominal_Actual         numeric(19, 4)  NULL ,       --17    
   Moneda_Emision         numeric(3, 0) NOT NULL ,       --18    
   Moneda_Reajuste        VARCHAR(3)  NOT NULL ,       --19    
   Tipo_Tasa_Emision      char(7)    NULL ,       --20    
   Tasa_Emision           numeric(9, 4) NOT NULL ,       --21    
   Tera                   decimal(8, 4)  NULL ,       --22    
   Valor_Par              numeric(18,4)  NULL ,       --23    
   Tipo_Tasa_Compra       char(7)    NULL ,       --24    
   Tasa_Compra            numeric(9, 4) NOT NULL ,       --25    
   Costo_Adquisicion      numeric(19, 4) NOT NULL ,       --26    
   Costo_Amortizado       numeric(14, 0)  NULL ,       --27    
   Valor_Razonable        numeric(19, 4)  NULL ,       --28    
   Tipo_Tasa_Valoriza     varchar(7)   NULL ,       --29    
   Tasa_Valorizacion      numeric(19, 4)  NULL ,       --30    
   Tipo_valorizacion      int    NOT NULL ,       --31    
   Precio_Instrumento     numeric(6, 2) NOT NULL ,       --32 (19, 8)    
   Duracion_Modificada    numeric(24,8) NOT NULL ,       --33    
   Convexidad             numeric(24,8) NOT NULL ,       --34    
   Valor_Deterioro        numeric(14, 0)  NULL ,       --35    
   Condicion_Instrumento  int    NOT NULL ,       --36    
   Fecha_Inicio_Cond      char (8)    NULL ,       --37    
   Fecha_Final_Cond       char (8)    NULL ,       --38    
  
   iCantidad      INT     NULL ,       --38  
   signoTCmp      CHAR(1)   NOT NULL,   --39  
   signoTVal      CHAR(1)   NOT NULL,        --40  
  
   Cartera       numeric (5)  NOT NULL ,       --41            
   numero_Documento       numeric(10, 0) NOT NULL ,   --42  
   Correlativo            numeric(10, 0) NOT NULL ,   --43  
   Numero_Operacion       numeric(10, 0) NOT NULL ,       --44  
   Seriado                CHAR(1)   NOT NULL ,   --45  
   Serie                  VARCHAR(20)  NOT NULL ,       --46  
   Familia                NUMERIC(10)      NOT NULL ,   --47  
   IdFila                 INT    Identity(1, 1)     
 )     
  
  
select    
  Tipo_Registro   = convert(char(2),  Ret.Tipo_Registro   )    --1  
 , Codigo_Tenedor   = convert(char(3),  Ret.Codigo_Tenedor   )    --2  
 , Fecha_Proceso   = convert(char(8),  Ret.Fecha_Proceso   )    --3  
 , Fecha_Compra   = convert(char(8),  Ret.Fecha_Compra   )    --4  
 , Tipo_Cartera   = convert(numeric(5),  Ret.Tipo_Cartera   )    --5  
 , Emisor     = convert(varchar(10), Ret.Emisor     )    --6  
 , Pais_Emisor    = convert(numeric(3),  Ret.Pais_Emisor    )    --7  
 , Familia_Instrumento  = convert(char(2),  Ret.Familia_Instrumento  )    --8  
 , Nemotecnico    = convert(char(20),  Ret.Nemotecnico    )    --9  
 , Tipo_Rendimiento  = convert(char(1),  Ret.Tipo_Rendimiento  )    --10  
 , Periodicidad_Cupon  = convert(char(1),  Ret.Periodicidad_Cupon  )    --11  
 , Fecha_Ultimo_Cupon  = convert(char(8),  Ret.Fecha_Ultimo_Cupon  )    --12  
 , Fecha_Proximo_Cupon  = convert(char(8),  Ret.Fecha_Proximo_Cupon  )    --13  
 , Fecha_Vcto_Instr  = convert(char(8),  Ret.Fecha_Vcto_Instr  )    --14  
 , Derivado_Incrust_Opc = convert(char(2),  Ret.Derivado_Incrust_Opc )    --15  
 , Nominal_Inicial   = convert(numeric(19,4), Ret.Nominal_Inicial   )    --16   
 , Nominal_Actual   = convert(numeric(19,4), Ret.Nominal_Actual   )    --17  
 , Moneda_Emision   = convert(varchar(3),  Ret.Moneda_Emision   )    --18  
 , Moneda_Reajuste   = convert(varchar(3),  Ret.Moneda_Reajuste   )    --19  
 , Tipo_Tasa_Emision  = convert(varchar(7),  Ret.Tipo_Tasa_Emision  )    --20  
 , Tasa_Emision   = convert(numeric(9,4), Ret.Tasa_Emision   )    --21  
 , Tera     = convert(numeric(8,4), Ret.Tera     )    --22  
 , Valor_Par    = convert(numeric(18,4), Ret.Valor_Par    )    --23  
 , Tipo_Tasa_Compra  = convert(char(7),  Ret.Tipo_Tasa_Compra  )    --24  
 , Tasa_Compra    = convert(numeric(9,4), Ret.Tasa_Compra    )    --25  
 , Costo_Adquisicion  = convert(numeric(19,4), Ret.Costo_Adquisicion  )    --26  
 , Costo_Amortizado  = convert(numeric(14,0), Ret.Costo_Amortizado  )    --27  
 , Valor_Razonable   = convert(numeric(19,4), Ret.Valor_Razonable   )    --28  
 , Tipo_Tasa_Valoriza  = convert(varchar(7),  Ret.Tipo_Tasa_Valoriza  )    --29  
 , Tasa_Valorizacion  = convert(numeric(19,4), Ret.Tasa_Valorizacion  )    --30  
 , Tipo_valorizacion  = convert(int,   Ret.Tipo_valorizacion  )    --31  
 , Precio_Instrumento  = convert(float, Ret.Precio_Instrumento  )    --convert(numeric(6,2), Ret.Precio_Instrumento  )    --32  
 , Duracion_Modificada  = convert(numeric(24,8), Ret.Duracion_Modificada  )    --33  
 , Convexidad    = convert(numeric(24,8), Ret.Convexidad    )    --34  
 , Valor_Deterioro   = convert(numeric(14,0), Ret.Valor_Deterioro   )    --35  
 , Condicion_Instrumento = convert(int,   Ret.Condicion_Instrumento )    --36  
 , Fecha_Inicio_Cond  = convert(char(8),  Ret.Fecha_Inicio_Cond  )    --37  
 , Fecha_Final_Cond  = convert(char(8),  Ret.Fecha_Final_Cond  )    --38  
 , iCantidad    = BACTRADERSUDA.dbo.Fx_ReplicaId(Ret.iCantidad, ROW_NUMBER() over( order by Ret.iCantidad desc )) --39  
 , signoTCmp    = Ret.signoTCmp              --40  
 , signoTVal    = Ret.signoTVal              --41  
  
 , cartera     = ret.cartera  
 , numdocu     = ret.numdocu  
 , correla     = ret.Correlativo  
 , numoper     = ret.numoper  
 , estado     = ret.estado  
 , Seriado     = convert(char(1), Ret.Seriado)  
 , Valor_mercado   = convert(numeric(19,4),Ret.Valor_mercado)  
 , Cliente = Ret.Cliente
 , CodCliente = Ret.CodCliente
 into #tmp  
from (  
 select Tipo_Registro    = TmpP40.Tipo_Registro  
  , Codigo_Tenedor    = TmpP40.Codigo_Tenedor  
  , Fecha_Proceso    = TmpP40.Fecha_Proceso  
  , Fecha_Compra    = TmpP40.Fecha_Compra  
  , Tipo_Cartera    = TmpP40.Tipo_Cartera  
  , Emisor      = TmpP40.Emisor  
  , Pais_Emisor     = TmpP40.Pais_Emisor  
  , Familia_Instrumento   = TmpP40.Familia_Instrumento  
  , Nemotecnico     = TmpP40.Nemotecnico  
  , Tipo_Rendimiento   = TmpP40.Tipo_Rendimiento  
  
  , Periodicidad_Cupon   = case when TmpP40.Tipo_Rendimiento = 1 then 0  
            else TmpP40.xPeriodicidad  
           end  
  
  , Fecha_Ultimo_Cupon   = case when TmpP40.Tipo_Rendimiento = 1 then '00000000'  
            else TmpP40.Fecha_Ultimo_Cupon  
           end  
  , Fecha_Proximo_Cupon   = case when TmpP40.Tipo_Rendimiento = 1 then '00000000'   
            else TmpP40.Fecha_Proximo_Cupon  
           end  
  
  , Fecha_Vcto_Instr   = TmpP40.Fecha_Vcto_Instr  
  , Derivado_Incrust_Opc  = TmpP40.Derivado_Incrust_Opc  
  , Nominal_Inicial    = TmpP40.Nominal_Inicial  
  , Nominal_Actual    = TmpP40.Nominal_Actual  
  , Moneda_Emision    = TmpP40.Moneda_Emision  
  , Moneda_Reajuste    = TmpP40.Moneda_Reajuste  
  , Tipo_Tasa_Emision   = TmpP40.Tipo_Tasa_Emision  
  , Tasa_Emision    = abs( TmpP40.Tasa_Emision )  
  , Tera      = abs( TmpP40.Tera )  
  , Valor_Par     = TmpP40.Valor_Par  
  , Tipo_Tasa_Compra   = TmpP40.Tipo_Tasa_Compra  
  , Tasa_Compra     = abs( TmpP40.Tasa_Compra )  
  , Costo_Adquisicion   = TmpP40.Costo_Adquisicion  
  , Costo_Amortizado   = TmpP40.Costo_Amortizado  
  , Valor_Razonable    = TmpP40.Valor_Razonable  
  , Tipo_Tasa_Valoriza   = TmpP40.Tipo_Tasa_Valoriza  
  , Tasa_Valorizacion   = case when abs(TmpP40.Tasa_Valorizacion) > 100 then abs(TmpP40.Tasa_Valorizacion) - abs((100 - abs(TmpP40.Tasa_Valorizacion))-1)  
            else abs(TmpP40.Tasa_Valorizacion)  
            end  
  , Tipo_valorizacion   = TmpP40.Tipo_valorizacion  
  , Precio_Instrumento   = abs( TmpP40.Precio_Instrumento )  
  , Duracion_Modificada   = TmpP40.Duracion_Modificada  
  , Convexidad     = TmpP40.Convexidad  
  , Valor_Deterioro    = TmpP40.Valor_Deterioro  
  , Condicion_Instrumento  = TmpP40.Condicion_Instrumento  
  , Fecha_Inicio_Cond   = TmpP40.Fecha_Inicio_Cond  
  , Fecha_Final_Cond   = TmpP40.Fecha_Final_Cond  
  , Filler      = TmpP40.Filler  
  , numero_Documento   = TmpP40.numero_Documento  
  , Correlativo     = TmpP40.Correlativo  
  , Numero_Operacion   = TmpP40.Numero_Operacion  
  , Seriado      = TmpP40.Seriado  
  , Codigo      = TmpP40.Codigo  
  , Serie      = TmpP40.Serie  
  , FecCupVen     = TmpP40.FecCupVen  
  , FechaEmision    = TmpP40.FechaEmision  
  , NomOriginal     = TmpP40.NomOriginal  
  , rutcart      = TmpP40.rutcart  
  ,   signoTCmp     = CASE WHEN TmpP40.Tasa_Compra       >= 0 THEN '+' ELSE '-' END                                                        -- 35. Signo Tasa Compra      
        ,   signoTVal     = CASE WHEN TmpP40.Tasa_Valorizacion >= 0 THEN '+' ELSE '-' END                     -- 36. Signo Tasa Valorizacion      
  , iCantidad     = TmpP40.iCantidad  
    
  , estado      = TmpP40.viestado  
  , cartera      = TmpP40.cartera  
  , numdocu      = TmpP40.numdocu  
  , numoper      = TmpP40.numoper  
  , Valor_mercado    = TmpP40.Valor_mercado  
  ,  Cliente	=TmpP40.Cliente
  ,	 CodCliente=TmpP40.CodCliente
 from (  
  
  SELECT 'Tipo_Registro'    = '01'  
  ,  'Codigo_Tenedor'   = '039' --20200514.RCHS AJUSTES P40 '027'  
  ,  'Fecha_Proceso'    = CONVERT(CHAR(8), @Fecha_Interfaz, 112)  
  ,  'Fecha_Compra'    = CONVERT(CHAR(10), MDRS.rsfeccomp,  112)  
  ,  'Tipo_Cartera'    = CASE WHEN MDRS.codigo_carterasuper = 'A' THEN 3  
             WHEN MDRS.codigo_carterasuper = 'P' THEN 2  
             WHEN MDRS.codigo_carterasuper = 'T' THEN 1  
             WHEN MDRS.codigo_carterasuper = 'R' THEN 1  
             ELSE                                     2  
             END  
  ,  'Emisor'     = CONVERT(VARCHAR(11), REPLICATE('0',(9 -LEN(LTRIM(RTRIM(STR( ltrim(rtrim( MDRS.rsrutemis )) ))))))   
                + LTRIM(RTRIM(STR( ltrim(rtrim( MDRS.rsrutemis )) )))   
                + ltrim(rtrim( Emisor.emdv )) )  
  ,  'Pais_Emisor'    = 160  
  ,  'Familia_Instrumento'  = CASE WHEN Emisor.emrut = 97029000     THEN '01'  
             WHEN Emisor.emrut = 60805000     THEN '01'  
             WHEN Emisor.emrut = 61533000     THEN '03'  
             WHEN MDRS.rscodigo = 20      THEN '04'  
             WHEN MDRS.rscodigo IN (9,11)     THEN '10'  
             WHEN MDRS.rscodigo = 15 AND Emisor.emtipo = 1 THEN '06'  
             WHEN MDRS.rscodigo = 15 AND Emisor.emtipo = 2 THEN '08'  
             WHEN MDRS.rscodigo = 15 AND Emisor.emtipo = 4 THEN '52'  
             ELSE             '00'  
            END  
  ,  'Nemotecnico'    =  (CASE WHEN  INST.inmdse = 'S' THEN rsinstser  
              WHEN  INST.inmdse = 'N' AND rscodigo = 9  THEN 'FN' + SUBSTRING((SELECT TOP 1 bolsa FROM BACPARAMSUDA..SINACOFI WHERE clrut=rsrutemis),1,3) + '-' + SUBSTRING(rsinstser,5,6)      
              WHEN  INST.inmdse = 'N' AND rscodigo = 11 THEN 'FU' + SUBSTRING((SELECT TOP 1 bolsa FROM BACPARAMSUDA..SINACOFI WHERE clrut=rsrutemis),1,3) + '-' + SUBSTRING(rsinstser,5,6)  
              WHEN  INST.inmdse = 'N' AND rscodigo = 13 THEN 'F*' + SUBSTRING((SELECT TOP 1 bolsa FROM BACPARAMSUDA..SINACOFI WHERE clrut=rsrutemis),1,3) + '-' + SUBSTRING(rsinstser,5,6)  
              WHEN  INST.inmdse = 'N' AND rscodigo = 6  THEN 'BNPDBC' + SUBSTRING(rsinstser,5,6)  
              WHEN  INST.inmdse = 'N' AND rscodigo = 16 THEN 'SN' + SUBSTRING((SELECT TOP 1 bolsa FROM BACPARAMSUDA..SINACOFI WHERE clrut=rsrutemis),1,4) +  SUBSTRING(rsinstser,5,6)      
              WHEN  INST.inmdse = 'N' AND rscodigo = 17 THEN 'SU' + SUBSTRING((SELECT TOP 1 bolsa FROM BACPARAMSUDA..SINACOFI WHERE clrut=rsrutemis),1,4) +  SUBSTRING(rsinstser,5,6)      
              ELSE  Convert(Char(20), rsinstser ) END)   
  ,  'Tipo_Rendimiento'   = CASE WHEN INST.inmdse  = 'N' THEN 1  
             WHEN SERIE.secupones <= 1    THEN 1  
             WHEN SERIE.senumamort = 1  THEN 2  
             WHEN INST.incodigo  = 20 THEN 3  
             ELSE         9      
            END  
  
  ,  'Periodicidad_Cupon'  = CASE WHEN INST.inmdse = 'N' THEN 0       
             ELSE SERIE.SePeriodicidad  
            END  
  ,  'Fecha_Ultimo_Cupon'  = CASE WHEN INST.inmdse = 'N' THEN '19000101' ELSE CONVERT(CHAR(08), BACTRADERSUDA.dbo.Fx_P40_Fecha( MDRS.rscodigo, MDRS.rsinstser, MDRS.rsfecha, MDRS.rsnominal, MDRS.rsfecemis), 112) end  
  ,  'Fecha_Proximo_Cupon'  = CASE WHEN INST.inmdse = 'N' THEN '19000101' ELSE CONVERT(CHAR(08), MDRS.rsfecpcup, 112) END  
  ,  'Fecha_Vcto_Instr'   = CONVERT(CHAR(08), MDRS.rsfecvcto, 112)  
  ,  'Derivado_Incrust_Opc'  = CASE WHEN MDRS.rscodigo = 20 THEN '02' ELSE '01' END  
  
  ,  'Nominal_Inicial'   = CONVERT(NUMERIC(19,4), MDRS.rsnominal)  
  ,  'Nominal_Actual'   = case when INST.inmdse = 'S' then BACTRADERSUDA.dbo.Fx_P40_Nominal ( rscodigo, rsinstser, rsfecucup, rsnominal, rsfecemis )  
             else convert(numeric(19,4), MDRS.rsnominal )  
            end  
  
  ,  'Moneda_Emision'   = case when INST.inmdse = 'N' then NOSERIE.nsmonemi  
             else case when MDRS.rscodigo = 20 then 998 else MDRS.rsmonemi end-- INST.inmonemi end  
            end  
  
  ,  'Moneda_Reajuste'   = CASE WHEN MDRS.rscodigo = 20  THEN 998 ELSE  MDRS.rsmonemi end--INST.inmonemi END  
  
  ,  'Tipo_Tasa_Emision'   = case when INST.inmdse = 'N' then '1' + NOSERIE.SeIndN  
                     + '9' + NOSERIE.NsIndC + '000'  
             else case when Datediff(Day, SERIE.sefecemi, SERIE.sefecven) > 365 then '12'  
                else               '11'   
               end + SERIE.SeIndPc + '000'  
            end  
  
  ,  'Tasa_Emision'    = CASE WHEN MDRS.rscodigo = 888         THEN 4.0 --> BR  
             WHEN MDRS.rscodigo = 37          THEN 0.0 --> XERO  
             WHEN MDRS.rscodigo = 300         THEN 0.0 --> CERO  
             WHEN MDRS.rscodigo = 301         THEN 0.0 --> ZERO  
             WHEN MDRS.rscodigo IN(3,9,11,12,13,14, 18,19, 50,51,52, 54) THEN 0.0 --> DP%  
             WHEN INST.inmdse = 'S' and SERIE.setasemi = 0   THEN MDRS.rstir   
             WHEN INST.inmdse = 'S' and SERIE.setasemi <> 0   THEN SERIE.setasemi  
  
             WHEN INST.inmdse = 'N' and NOSERIE.nstasemi = 0   THEN MDRS.rstir  
             WHEN INST.inmdse = 'N' and NOSERIE.nstasemi <> 0   THEN NOSERIE.nstasemi  
             ELSE MDRS.rstasemi  
            END  
  
  ,  'Tera'      = case when INST.inmdse = 'S' and SERIE.setera  = 0 then MDRS.rstir  
             when INST.inmdse = 'S' and SERIE.setera  <> 0 then SERIE.setera  
               
             when INST.inmdse = 'N' and NOSERIE.nstasemi = 0 then MDRS.rstir  
             when INST.inmdse = 'N' and NOSERIE.nstasemi <> 0 then NOSERIE.nstasemi  
            END  
  
  
  
  ,  'Valor_Par'     =   ( case when INST.inmdse = 'S'   
              then (valor_par * rsnominal) / 100.0--then (rsvpcomp * rsnominal) / 100.0  
                else rsnominal  
                end)   
 /* ,  'Valor_Par'     =  valor_par*/   
  ,  'Tipo_Tasa_Compra'   = case when INST.inmdse = 'N' then '1' + NOSERIE.SeIndN + '9' + NOSERIE.NsIndC + '000'  
             else case when Datediff(Day, SERIE.sefecemi, SERIE.sefecven) > 365 then '12'  
                else '11' end + SERIE.SeIndPc + '000'  
            end  
  
  ,  'Tasa_Compra'    = MDRS.rstir  
  ,  'Costo_Adquisicion'   = CASE WHEN INST.inmonemi in (999,998,994,997) THEN MDRS.rsvalcomp ELSE 0 END --MDRS.rsvalcomp  
               
  ,  'Costo_Amortizado'   = CASE WHEN MDRS.codigo_carterasuper = 'A' THEN MDRS.rsvalcomp ELSE 0 END  
  ,  'Valor_Razonable'   =  ISNULL(VMERC.valor_mercado, 0.0)  
  
  ,  'Tipo_Tasa_Valoriza'  = case when INST.inmdse = 'N' then '1' + NOSERIE.SeIndN + '9' + NOSERIE.NsIndC + '000'  
             else case when Datediff(Day, SERIE.sefecemi, SERIE.sefecven) > 365 then '12'  
                else '11'   
               end + SERIE.SeIndPc + '000'  
            end  
  
  ,  'Tasa_Valorizacion'   = ISNULL( VMERC.tasa_mercado, 0.0)  
  ,  'Tipo_valorizacion'   = CASE WHEN VMERC.OrigenCurva = 'MC' THEN 3 ELSE 2 END  
  
  ,  'Precio_Instrumento'  = CASE WHEN MDRS.rscodigo = 888 THEN ROUND(MDRS.rsvpcomp, 2)  --precio  
             WHEN MDRS.rscartera = 111 THEN ROUND(MDRS.rsvpcomp, 2)   
             WHEN MDRS.valor_par = 0  THEN ROUND(MDRS.rstir, 2)  
             ELSE           ROUND(MDRS.valor_par, 2)  
            END  
   
  ,  'Duracion_Modificada'  = CASE WHEN CONVERT(NUMERIC(24,2),ISNULL(VMERC.Duration_Mod, 0)) = 0 THEN 0.01  
             ELSE CONVERT(NUMERIC(24,2),ISNULL(VMERC.Duration_Mod, 0))   
            END  
  
  ,  'Convexidad'    = convert(numeric(24,8), CASE WHEN isnull(VMERC.Convexidad, 0.0) = 0.0 THEN 0.01  
                   ELSE isnull(VMERC.Convexidad, 0.0)  
                  END )  
  
  ,  'Valor_Deterioro'   = CONVERT(NUMERIC(14),0)  
  ,  'Condicion_Instrumento'  = CASE WHEN MDRS.rscartera = '111' THEN 1   
             WHEN MDRS.rscartera = '114' THEN 2   
             WHEN MDRS.rscartera = '159' THEN 3   
             else 0 END --20200430.RCHS. AJUSTES P40 CASE WHEN MDRS.rscartera = '111' THEN 1 ELSE 2 END  
  
  ,  'Fecha_Inicio_Cond'   = case when MDRS.rscartera = '111' then '00000000' --20200616.RCHS. AJUSTES P40 convert(char(08), MDVI.vifecinip, 112)  
             when MDRS.rscartera = '159' then convert(char(08), MDRS.rsfecinip, 112)  
             else case when MDRS.rscartera = '114' then convert(char(08), MDRS.rsfecinip, 112)  
                else '00000000'  
               end  
            end  
  ,  'Fecha_Final_Cond'   = case when MDRS.rscartera = '111' then '00000000'--20200616.RCHS. AJUSTES P40 convert(char(08), MDVI.vifecvenp, 112)  
             when MDRS.rscartera = '159' then convert(char(08), MDRS.rsfecvtop, 112)    
             else case when MDRS.rscartera = '114' then convert(char(08), MDRS.rsfecvtop, 112)  
                else '00000000'  
               end  
            end  
  
  ,  'Filler'     = ' '  
  ,  'Numero_Documento'   = MDRS.rsnumdocu      
  ,  'Correlativo'    = MDRS.rscorrela      
  ,  'Numero_Operacion'   = CASE WHEN MDRS.rscartera ='111' THEN MDRS.rsnumdocu ELSE MDRS.rsnumoper END  
  -->>>> Agregado para su uso mas adelante <<<<--      
  ,  'Seriado'     = INST.inmdse  
  ,  'Codigo'     = INST.incodigo  
  ,  'Serie'      = MDRS.rsinstser  
  ,  'FecCupVen'     = MDRS.rsfecucup  
  ,  'FechaEmision'    = MDRS.rsfecemis  
  ,  'NomOriginal'    = MDRS.rsnominal  
  ,  'Rutcart'     = MDRS.rsrutcart  
  -->>>> Agregado para su uso mas adelante <<<<--      
  ,  'xPeriodicidad'    = case when INST.inmdse = 'S' then SERIE.SePeriodo else NOSERIE.NsPeriodo end  
  ,  'iCantidad'     = ROW_NUMBER() over( order by MDRS.rsnumoper, MDRS.rsnumdocu, MDRS.rscorrela)  
  ,  'viestado'     = mdvi.viEstado  
  ,  'cartera'     = mdrs.rscartera  
  ,  'numdocu'     = mdrs.rsnumdocu  
  ,  'numoper'     = mdrs.rsnumoper  
  ,  'Valor_mercado'    = VMERC.valor_mercado  
  ,  'Cliente'	=CLIEN.Clrut
  ,	 'CodCliente'=CLIEN.Clcodigo  
  
    FROM  ( select rsfecha, rstipoper, rscartera, rsnominal, rstir,  rsvppresen  
      , rsnumoper, rsnumdocu, rscorrela, rsfecucup, rsfecpcup, rstasemi  
      , rsfecinip, rsfecvtop, rsfecemis, rscodigo,  rsrutemis, rsrutcart  
      , rsvalcomp, rsinstser, rsrutcli,  rscodcli,  rsfeccomp, rsfecvcto  
      , codigo_carterasuper, valor_tasa_emision, valor_par, rsvpcomp  , rsmonemi
     from BacTraderSuda.dbo.Mdrs with(nolock)  
     where rsfecha     = @dFechacartera  
               
     and  MDRS.rsfecvcto     >= MDRS.rsfecha  
     and  MDRS.rstipoper   = 'DEV'  
     and  MDRS.rscartera   IN(111, 114, 159)--20200430.RCHS.AJUSTES P40 (INCLUSIÓN GTIAS.) IN(111, 114)  
     and  MDRS.rsnominal   > 0  
     and  MDRS.rscodigo     <> 98  
     AND not(MDRS.rscodigo   = 20   
      AND MDRS.rsrutemis   = (select acrutprop from BacTraderSuda.dbo.Mdac with(nolock) )  
       )  
       
    ) MDRS  
  
    --20200514.RCHS.AJUSTES P40 (MAY 4 DV) left Join ( select emrut, emdv, emtipo, emrutdv = ltrim(rtrim( emrut )) + ltrim(rtrim( emdv ))  
    left Join ( select emrut, UPPER(emdv) emdv, emtipo, emrutdv = ltrim(rtrim( emrut )) + ltrim(rtrim( emdv ))  
          
       from BacParamSuda.dbo.Emisor with(nolock)   
       ) Emisor   On Emisor.emrut = MDRS.rsrutemis  
  
    left Join ( Select incodigo, inmdse, inmonemi  
       from BacParamSuda.dbo.Instrumento with(nolock)  
       )  INST  On INST.incodigo = rscodigo  
  
    Left Join ( Select secodigo, seserie, secupones, senumamort, sepervcup, sefecemi, sefecven, setera, setasemi  
        , SeIndPc   = case when sepervcup = 1  then '1'  
               when sepervcup = 3  then '2'  
               when sepervcup = 4  then '3'  
               when sepervcup = 6  then '4'  
               when sepervcup = 12 then '5' else '9' end  
              --> Base del Instrumento (Nueva Definicion Carlos)   
             + case when sebasemi = 360 then '1'  
               when sebasemi = 365 then '2'  
               when sebasemi = 30 then '3' else '9' end  
--             + case when sebasemi = 360 then '4' else '9' end  
  
        , SePeriodicidad = case when sepervcup = 1  then 1  
               when sepervcup = 3  then 2  
               when sepervcup = 4  then 3  
               when sepervcup = 6  then 4  
               when sepervcup = 12 then 5 else 6 end  
  
        , SePeriodo  = case when sepervcup = 1  then '1'  
               when sepervcup = 3  then '2'  
               when sepervcup = 4  then '3'  
               when sepervcup = 6  then '4'  
               when sepervcup = 12 then '5' else '9' end  
       from BacParamSuda.dbo.Serie with(nolock)  
       )  SERIE  On SERIE.secodigo = MDRS.rscodigo  
            AND SERIE.seserie = CASE WHEN MDRS.rscodigo = 20 THEN SUBSTRING(MDRS.rsinstser,1,6) ELSE MDRS.rsinstser END  
  
    Left Join ( Select nsnumdocu, nscorrela, nsrutcart, nstasemi, nsmonemi  
        , NsIndC  = case when nsbasemi = 360 then '4' else '9' end  
  
        , SeIndN  = case when DateDiff( Day, nsfecemi, nsfecven ) > 365 then '2'  
               else '1' end  
        , NsPeriodo = '9'  
       from BacparamSuda.dbo.NoSerie with(nolock)  
       )  NOSERIE  On NOSERIE.nsnumdocu = MDRS.rsnumdocu  
            AND NOSERIE.nscorrela = MDRS.rscorrela  
            AND NOSERIE.nsrutcart = MDRS.rsrutcart  
  
    Left Join ( Select  clrut, clcodigo  
       from BacParamSuda.dbo.Cliente with(nolock)  
       )  CLIEN  On CLIEN.clrut  = MDRS.rsrutcli  
            AND CLIEN.clcodigo = MDRS.rscodcli  
  
    inner Join (Select fecha_valorizacion, rmnumoper, tipo_operacion, id_sistema, rmnumdocu, rmcorrela  
        , valor_mercado, tasa_mercado, OrigenCurva, Duration_Mod  
        , Convexidad  
       From BacTraderSuda.dbo.Valorizacion_Mercado with(nolock)  
       )  VMERC  On VMERC.fecha_valorizacion = @dFechaMercado  
             
            AND VMERC.id_sistema   = 'BTR'      
            AND VMERC.rmnumdocu   = MDRS.rsnumdocu   
            AND VMERC.rmcorrela   = MDRS.rscorrela   
            AND VMERC.rmnumoper   = MDRS.rsnumoper  
            AND VMERC.tipo_operacion = CASE WHEN MDRS.rscartera = '111' THEN 'CP' WHEN MDRS.rscartera = '114' THEN 'VI' ELSE 'CG' END    --20200514.RCHS.AJUSTES P40 (INCLUSIÓN OPERACIONES CG) AND VMERC.tipo_operacion = CASE WHEN MDRS.rscartera = '111' THEN 'CP' ELSE  THEN 'VI' END      
  
    left Join ( Select nscodigo, nsnumdocu, nscorrela, nsrutemi  
        , nsnemo = case when nscodigo = 9 and nsmonemi  = 999 then 'PAGARE NR'  
             when nscodigo = 9 and nsmonemi <> 999 then 'PAGARE R'  
             when nscodigo = 11 and nsmonemi  = 999 then 'PAGARE NR'  
             when nscodigo = 11 and nsmonemi <> 999 then 'PAGARE R'  
             else nsserie  
            end  
       from BacParamSuda.dbo.NOSERIE with(nolock)  
         LEFT JOIN BacParamSuda.dbo.SINACOFI with(nolock) On clrut = nsrutemi  
       )  NEMOTECNICO On NEMOTECNICO.nsnumdocu = MDRS.rsnumdocu  
            AND NEMOTECNICO.nscorrela = MDRS.rscorrela  
  
    Left Join ( Select vinumoper, vifecinip, vifecvenp, vinumdocu, vicorrela, viEstado = 1  
       from BacTraderSuda.dbo.MDVI with(nolock)  
  
       )  MDVI  On MDVI.vinumoper = CASE WHEN MDRS.rscartera = '111' THEN  MDRS.rsnumdocu ELSE MDRS.rsnumoper END  
            AND MDVI.vinumdocu = MDRS.rsnumdocu  
            AND MDVI.vicorrela = MDRS.rscorrela  
            
    left Join ( Select vmcodigo, vmvalor  
       from BacTraderSuda.dbo.MDAC with(nolock)  
         inner join BacParamSuda.dbo.VALOR_MONEDA with(nolock) On vmfecha = acfecproc  
        union  
       Select 999, 1.0   
        union  
       select  13,  vmvalor  
       from BacTraderSuda.dbo.MDAC with(nolock)  
         inner join BacParamSuda.dbo.VALOR_MONEDA with(nolock) On vmfecha = acfecproc  
       where vmcodigo = 994  
       )  VMONEDA  On VMONEDA.vmcodigo = case when INST.inmdse = 'N' then NOSERIE.nsmonemi  
                    else case when MDRS.rscodigo = 20 then 998 else INST.inmonemi end  
                   end  
  ) TmpP40  
 ) Ret  
 order   
 by  Ret.Nemotecnico  
  , Ret.numero_Documento  
  , Ret.Correlativo  
  , Ret.Numero_Operacion  
  
 
--Actualiza Precio_Instrumento   
UPDATE #TMP  
Set Precio_Instrumento = CASE WHEN Seriado = 'S' THEN  
        CASE WHEN ISNULL(Valor_Par, 0) = 0 OR ISNULL(Nominal_Inicial, 0) = 0 THEN  
         0   
        ELSE  
          ROUND(((99*(valor_mercado/ROUND(valor_par, 0))) + (1.01*(valor_mercado/Nominal_Inicial))),5)  
        END  
       ELSE   
        CASE WHEN Moneda_Emision=998 THEN  
         ROUND(((valor_razonable/@nValorUF)/Nominal_Inicial)*100,2)  
        ELSE  
         ROUND((valor_razonable/Nominal_Inicial)*100,2)  
        END  
       END   
where Precio_Instrumento<1 and valor_razonable>0  
  
  
ALTER TABLE #TMP ADD Precio_Instrum   FLOAT NULL --DEFAULT 0  
ALTER TABLE #TMP ADD Limite_Inferior  FLOAT NULL --DEFAULT 0  
ALTER TABLE #TMP ADD Limite_Superior  FLOAT NULL --DEFAULT 0  
ALTER TABLE #TMP ADD Valida_Registro  FLOAT NULL --DEFAULT 0  
  
  
UPDATE #TMP  
    SET Precio_Instrum  = ROUND((valor_razonable / valor_par) * 100.0,2)  
    ,   Limite_Inferior = (0.99 * valor_razonable / valor_par) * 100.0  
    ,   Limite_Superior = (1.01 * valor_razonable / nominal_actual) * 100.0  
WHERE  tipo_registro = '01' AND Seriado = 'S' AND Moneda_Emision = 999  
  
UPDATE #TMP  
    SET precio_instrumento = ROUND(Precio_Instrum,2)  
WHERE  tipo_registro = '01' AND Seriado = 'S' AND Moneda_Emision = 999  
AND (precio_instrumento < Limite_Inferior OR precio_instrumento > Limite_Superior)  
  
  
ALTER TABLE #TMP DROP COLUMN Precio_Instrum  
ALTER TABLE #TMP DROP COLUMN Limite_Inferior  
ALTER TABLE #TMP DROP COLUMN Limite_Superior  
ALTER TABLE #TMP DROP COLUMN Valida_Registro  
  
--select 8327824851.0000/28681.3 @nValorUF  
--select (290357.30078483192/290000.0000)*100  
--select (21005000000.0000/21005000000.0000)*100  
--select 287166116.0000/28681.3  
--select ( (287166116.0000/28681.3) / 9999.9910)*100  
  
/*  
  
CORRECCIÓN BLAPO-H               
-------------------  
Se solicita llevar a pesos el nominal actual que está en UF  
  
2020 08 13  
  
blapo llevar a CLP  
  
*/  
UPDATE #TMP  
SET  Costo_Adquisicion = @nValorUF * Nominal_Actual  
WHERE Nemotecnico='BLAPO-H' AND upper(Emisor)='096874030K' and Costo_Adquisicion=0  
  
--Actualiza Moneda Emisión y Reajuste + Valor Razonable  
UPDATE #TMP  
SET  Moneda_Emision = '999',Moneda_Reajuste = '999',Valor_Razonable=1  
WHERE upper(Emisor)='096874030K' and Valor_Razonable=0  
  
  
--PARA LOS PAPELES DONDE LA FECHA ULTIMO CORTE ES IGUAL A LA FECHA PRÓXIMO CUPON (CASO BSTDP80315)  
UPDATE #TMP  
SET FECHA_PROXIMO_CUPON=convert(char(08),'00000000', 112)   
WHERE  FECHA_ULTIMO_CUPON=FECHA_PROXIMO_CUPON and FECHA_ULTIMO_CUPON!='00000000'  
  
  
  
--REMOVER PAPELES QUE NO ESTAN EN GARANTÍA A LA FECHA DE EMISIÓN DE LA INTERFAZ  
--NO SIRVE ESTE CRITERIO PARA ELIMINAR LOS PAPELES EN GARANTIA   
--PORQUE NO EXISTE UN CONTROL X FECHA EN SISTEMA DE GARANTIAS.  
  
--DELETE FROM #TMP WHERE  Cartera=159 AND FECHA_FINAL_COND<@Fecha_Interfaz  
  
--PARA LOS PAPELES EN GARANTÍA SE DEBEN INFORMAR '99999999'  
UPDATE #TMP  
SET FECHA_INICIO_COND =  convert(char(08),  '99999999', 112) ,--convert(char(08),'99999999'),   
 FECHA_FINAL_COND =  convert(char(08),  '99999999', 112)--convert(char(08),'99999999')  
WHERE CARTERA=159 AND Condicion_Instrumento='3'   
  
--PARA AQUELLOS REGISTROS QUE EL COSTO ADQUISICIÓN VENGA EN 0  
update #tmp   
set costo_adquisicion=rsvalcomp  
from BacTraderSuda.DBO.mdrs   
where rsfecha=@dFechacartera and numdocu=rsnumdocu and correla=rscorrela and costo_adquisicion=0  
  
INSERT INTO #TABLA_P40_MX  
EXEC bacbonosextsuda..SP_INTERFAZ_P40_BANCO_MX_TMP @Fecha_Interfaz  
  
--select  *-- cartera,Precio_Instrumento,Valor_Par,Nominal_Inicial,Nominal_Actual,valor_mercado,valor_razonable,nemotecnico  
---- --((0.99*isnull(valor_razonable,1))/isnull(valor_par,1))*10000 /100,  
---- --round(Costo_Adquisicion * (Nominal_Inicial / Nominal_Actual),0),  
------((1.01*valor_razonable)/Nominal_Actual)*10000 /100,  
------valor_par,valor_razonable,Valor_mercado  
--from  #tmp   
  
  
/*  
rango1=((0,99*VR)/VPar)*10000  
rango2=((1,01*VR)/N)*10000  
precio=precio_instrumento/100  
*/  
  
--ACTUALIZO CANTIDAD DE REGISTROS A INFORMAR  
declare @qRFN int  
declare @qRFE int  
  
set @qRFN = (select count(*) from #tmp)  
set @qRFE = (select count(*) from #TABLA_P40_MX)  
  
update #tmp set iCantidad=(@qRFN + @qRFE)  
   
update #TABLA_P40_MX set iCantidad= (@qRFN+@qRFE)  
   
  
UPDATE #TABLA_P40_MX  
SET  nemotecnico = '                   '  
WHERE Nemotecnico=''   
  
--select Duracion_Modificada, convexidad ,  
-- SUBSTRING('0000000',DATALENGTH(LTRIM(RTRIM(STR(convexidad*10000,8)))),7) + LTRIM(RTRIM(STR(convexidad*10000,8))) convexidad_p40,  
-- SUBSTRING('0000000',DATALENGTH(LTRIM(RTRIM(STR(abs(convexidad)*10000,8)))),7) + LTRIM(RTRIM(STR(abs(convexidad)*10000,8))) convexidad_p40_abs,  
--* from  #tmp where Nemotecnico   like '%BSTDP80315%' order by 1  
------union  
----select count(*) from #TABLA_P40_MX  
 --return  
DECLARE @sTipoSalida bit
set @sTipoSalida = 1

if    @sTipoSalida !=0
begin

SELECT  tipo_registro   
  + codigo_tenedor   
  + Fecha_Proceso   
  + Fecha_Compra  
  + LTRIM(RTRIM(STR(ISNULL(tipo_cartera,'0'))))   
  + emisor  
  + REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(pais_emisor))))) + LTRIM(RTRIM(STR(pais_emisor)))    
  + REPLICATE('0', 2 - DATALENGTH(LTRIM(RTRIM(STR(familia_instrumento))))) + LTRIM(RTRIM(STR(familia_instrumento)))    
  + nemotecnico   
  + LTRIM(RTRIM(STR(tipo_rendimiento)))   
  + LTRIM(RTRIM(STR(periodicidad_cupon)))    
  + fecha_ultimo_cupon   
  + fecha_proximo_cupon   
  + Fecha_Vcto_Instr   
  + Derivado_Incrust_Opc   
  + SUBSTRING('000000000000000',DATALENGTH(LTRIM(RTRIM(STR(nominal_inicial * 100,16)))),15) + LTRIM(RTRIM(STR(nominal_inicial * 100,16)))   
  + SUBSTRING('000000000000000',DATALENGTH(LTRIM(RTRIM(STR(nominal_actual * 100,16)))),15) + LTRIM(RTRIM(STR(nominal_actual * 100,16)))    
  + REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(Moneda_Emision))))) + LTRIM(RTRIM(STR(Moneda_Emision)))    
  + REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(moneda_reajuste))))) + LTRIM(RTRIM(STR(moneda_reajuste)))   
  + tipo_tasa_emision    
  + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(tasa_emision*100,4)))),3) + LTRIM(RTRIM(STR(tasa_emision*100,4)))   
  + SUBSTRING('00000',DATALENGTH(LTRIM(RTRIM(STR(tera*10000,6)))),5) + LTRIM(RTRIM(STR(tera*10000,6)))    
  + SUBSTRING('000000000000000',DATALENGTH(LTRIM(RTRIM(STR(valor_par*100,16)))),15) + LTRIM(RTRIM(STR(valor_par*100,16)))    
  + tipo_tasa_compra    
  + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(ABS(tasa_compra)*100,4)))),3) + LTRIM(RTRIM(STR(ABS(tasa_compra)*100,4)))    
  + CASE WHEN tasa_compra >= 0 THEN '+' ELSE '-' END    
  + SUBSTRING('0000000000000',DATALENGTH(LTRIM(RTRIM(STR(costo_adquisicion,14)))),13) + LTRIM(RTRIM(STR(costo_adquisicion,14)))   
  + SUBSTRING('0000000000000',DATALENGTH(LTRIM(RTRIM(STR(costo_amortizado,14)))),13) + LTRIM(RTRIM(STR(costo_amortizado,14)))    
  + SUBSTRING('0000000000000',DATALENGTH(LTRIM(RTRIM(STR(valor_razonable,14)))),13) + LTRIM(RTRIM(STR(valor_razonable,14)))   
  + ltrim(rtrim(str(Tipo_Tasa_Valoriza)))   
  + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(ABS(tasa_valorizacion)*100,4)))),3) + LTRIM(RTRIM(STR(ABS(tasa_valorizacion)*100,4)))    
  + CASE WHEN tasa_valorizacion >= 0 THEN '+' ELSE '-' END    
  + rtrim(ltrim(STR(tipo_valorizacion)))    
  + SUBSTRING('0000000',DATALENGTH(LTRIM(RTRIM(STR(precio_instrumento*100,8)))),7) + LTRIM(RTRIM(STR(precio_instrumento*100,8)))   
  + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(duracion_modificada*100,4)))),3) + LTRIM(RTRIM(STR(duracion_modificada*100,4)))   
  + SUBSTRING('0000000',DATALENGTH(LTRIM(RTRIM(STR(abs(convexidad)*10000,8)))),7) + LTRIM(RTRIM(STR(abs(convexidad)*10000,8)))   
  + SUBSTRING('0000000000000',DATALENGTH(LTRIM(RTRIM(STR(valor_deterioro,14)))),13) + LTRIM(RTRIM(STR(valor_deterioro,14)))   
  + rtrim(ltrim(STR(condicion_instrumento)))    
  + Fecha_Inicio_Cond    
  + rtrim(ltrim(Fecha_Final_Cond)) as col   
  into #salida  
  from #tmp   
  where  tipo_registro   
  + codigo_tenedor   
  + Fecha_Proceso   
  + Fecha_Compra  
  + LTRIM(RTRIM(STR(ISNULL(tipo_cartera,'0'))))   
  + emisor  
  + REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(pais_emisor))))) + LTRIM(RTRIM(STR(pais_emisor)))    
  + REPLICATE('0', 2 - DATALENGTH(LTRIM(RTRIM(STR(familia_instrumento))))) + LTRIM(RTRIM(STR(familia_instrumento)))    
  + nemotecnico   
  + LTRIM(RTRIM(STR(tipo_rendimiento)))   
  + LTRIM(RTRIM(STR(periodicidad_cupon)))    
  + fecha_ultimo_cupon   
  + fecha_proximo_cupon   
  + Fecha_Vcto_Instr   
  + Derivado_Incrust_Opc   
  + SUBSTRING('000000000000000',DATALENGTH(LTRIM(RTRIM(STR(nominal_inicial * 100,16)))),15) + LTRIM(RTRIM(STR(nominal_inicial * 100,16)))   
  + SUBSTRING('000000000000000',DATALENGTH(LTRIM(RTRIM(STR(nominal_actual * 100,16)))),15) + LTRIM(RTRIM(STR(nominal_actual * 100,16)))    
  + REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(Moneda_Emision))))) + LTRIM(RTRIM(STR(Moneda_Emision)))    
  + REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(moneda_reajuste))))) + LTRIM(RTRIM(STR(moneda_reajuste)))   
  + tipo_tasa_emision    
  + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(tasa_emision*100,4)))),3) + LTRIM(RTRIM(STR(tasa_emision*100,4)))   
  + SUBSTRING('00000',DATALENGTH(LTRIM(RTRIM(STR(tera*10000,6)))),5) + LTRIM(RTRIM(STR(tera*10000,6)))    
  + SUBSTRING('000000000000000',DATALENGTH(LTRIM(RTRIM(STR(valor_par*100,16)))),15) + LTRIM(RTRIM(STR(valor_par*100,16)))    
  + tipo_tasa_compra    
  + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(ABS(tasa_compra)*100,4)))),3) + LTRIM(RTRIM(STR(ABS(tasa_compra)*100,4)))    
  + CASE WHEN tasa_compra >= 0 THEN '+' ELSE '-' END    
  + SUBSTRING('0000000000000',DATALENGTH(LTRIM(RTRIM(STR(costo_adquisicion,14)))),13) + LTRIM(RTRIM(STR(costo_adquisicion,14)))   
  + SUBSTRING('0000000000000',DATALENGTH(LTRIM(RTRIM(STR(costo_amortizado,14)))),13) + LTRIM(RTRIM(STR(costo_amortizado,14)))    
  + SUBSTRING('0000000000000',DATALENGTH(LTRIM(RTRIM(STR(valor_razonable,14)))),13) + LTRIM(RTRIM(STR(valor_razonable,14)))   
  + ltrim(rtrim(str(Tipo_Tasa_Valoriza)))   
  + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(ABS(tasa_valorizacion)*100,4)))),3) + LTRIM(RTRIM(STR(ABS(tasa_valorizacion)*100,4)))    
  + CASE WHEN tasa_valorizacion >= 0 THEN '+' ELSE '-' END    
  + rtrim(ltrim(STR(tipo_valorizacion)))    
  + SUBSTRING('0000000',DATALENGTH(LTRIM(RTRIM(STR(precio_instrumento*100,8)))),7) + LTRIM(RTRIM(STR(precio_instrumento*100,8)))   
  + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(duracion_modificada*100,4)))),3) + LTRIM(RTRIM(STR(duracion_modificada*100,4)))   
  + SUBSTRING('0000000',DATALENGTH(LTRIM(RTRIM(STR(abs(convexidad)*10000,8)))),7) + LTRIM(RTRIM(STR(abs(convexidad)*10000,8)))   
  + SUBSTRING('0000000000000',DATALENGTH(LTRIM(RTRIM(STR(valor_deterioro,14)))),13) + LTRIM(RTRIM(STR(valor_deterioro,14)))   
  + rtrim(ltrim(STR(condicion_instrumento)))    
  + Fecha_Inicio_Cond    
  + rtrim(ltrim(Fecha_Final_Cond)) is not null  
----union  
 insert into #salida  
 SELECT    tipo_registro   
  + codigo_tenedor   
  + Fecha_Proceso   
  + Fecha_Compra  
  + LTRIM(RTRIM(STR(ISNULL(tipo_cartera,'0'))))   
  + emisor  
  + REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(pais_emisor))))) + LTRIM(RTRIM(STR(pais_emisor)))    
+ REPLICATE('0', 2 - DATALENGTH(LTRIM(RTRIM(STR(familia_instrumento))))) + LTRIM(RTRIM(STR(familia_instrumento)))    
  + nemotecnico   
  + LTRIM(RTRIM(STR(tipo_rendimiento)))   
  + LTRIM(RTRIM(STR(periodicidad_cupon)))    
  + fecha_ultimo_cupon   
  + fecha_proximo_cupon   
  + Fecha_Vcto_Instr   
  + Derivado_Incrust_Opc   
  + SUBSTRING('000000000000000',DATALENGTH(LTRIM(RTRIM(STR(nominal_inicial * 100,16)))),15) + LTRIM(RTRIM(STR(nominal_inicial * 100,16)))   
  + SUBSTRING('000000000000000',DATALENGTH(LTRIM(RTRIM(STR(nominal_actual * 100,16)))),15) + LTRIM(RTRIM(STR(nominal_actual * 100,16)))    
  + REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(Moneda_Emision))))) + LTRIM(RTRIM(STR(Moneda_Emision)))    
  + REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(moneda_reajuste))))) + LTRIM(RTRIM(STR(moneda_reajuste)))   
  + tipo_tasa_emision    
  + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(tasa_emision*100,4)))),3) + LTRIM(RTRIM(STR(tasa_emision*100,4)))   
  + SUBSTRING('00000',DATALENGTH(LTRIM(RTRIM(STR(tera*10000,6)))),5) + LTRIM(RTRIM(STR(tera*10000,6)))    
  + SUBSTRING('000000000000000',DATALENGTH(LTRIM(RTRIM(STR(valor_par*100,16)))),15) + LTRIM(RTRIM(STR(valor_par*100,16)))    
  + tipo_tasa_compra    
  + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(ABS(tasa_compra)*100,4)))),3) + LTRIM(RTRIM(STR(ABS(tasa_compra)*100,4)))    
  + CASE WHEN tasa_compra >= 0 THEN '+' ELSE '-' END    
  + SUBSTRING('0000000000000',DATALENGTH(LTRIM(RTRIM(STR(costo_adquisicion,14)))),13) + LTRIM(RTRIM(STR(costo_adquisicion,14)))   
  + SUBSTRING('0000000000000',DATALENGTH(LTRIM(RTRIM(STR(costo_amortizado,14)))),13) + LTRIM(RTRIM(STR(costo_amortizado,14)))    
  + SUBSTRING('0000000000000',DATALENGTH(LTRIM(RTRIM(STR(valor_razonable,14)))),13) + LTRIM(RTRIM(STR(valor_razonable,14)))   
  +  ltrim(rtrim(Tipo_Tasa_Valoriza))   
  + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(ABS(tasa_valorizacion)*100,4)))),3) + LTRIM(RTRIM(STR(ABS(tasa_valorizacion)*100,4)))    
  + CASE WHEN tasa_valorizacion >= 0 THEN '+' ELSE '-' END    
  + rtrim(ltrim(STR(tipo_valorizacion)))    
  + SUBSTRING('0000000',DATALENGTH(LTRIM(RTRIM(STR(precio_instrumento*100,8)))),7) + LTRIM(RTRIM(STR(precio_instrumento*100,8)))   
  + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(duracion_modificada*100,4)))),3) + LTRIM(RTRIM(STR(duracion_modificada*100,4)))   
  + SUBSTRING('0000000',DATALENGTH(LTRIM(RTRIM(STR(convexidad*10000,8)))),7) + LTRIM(RTRIM(STR(convexidad*10000,8)))   
  + SUBSTRING('0000000000000',DATALENGTH(LTRIM(RTRIM(STR(valor_deterioro,14)))),13) + LTRIM(RTRIM(STR(valor_deterioro,14)))   
  + rtrim(ltrim(STR(condicion_instrumento)))    
  + Fecha_Inicio_Cond    
  + rtrim(ltrim(Fecha_Final_Cond))    as col  
from #TABLA_P40_MX  
  
select * from #salida  
drop table #salida  
drop table #tmp  
drop table #TABLA_P40_MX 
  
End
Else
Begin  
  
  select  
   Tipo_Registro        ,       --1    
   Codigo_Tenedor       ,       --2    
   Fecha_Proceso        ,       --3    
   Fecha_Compra         ,       --4    
   Tipo_Cartera         ,       --5    
   Emisor               ,       --6    
   Pais_Emisor          ,       --7    
   Familia_Instrumento  ,       --8    
   Nemotecnico          ,       --9    
   Tipo_Rendimiento     ,       --10    
   Periodicidad_Cupon   ,       --11    
   Fecha_Ultimo_Cupon   ,       --12    
   Fecha_Proximo_Cupon  ,       --13    
   Fecha_Vcto_Instr     ,       --14    
   Derivado_Incrust_Opc ,       --15    
   Nominal_Inicial      ,       --16    
   Nominal_Actual       ,       --17    
   Moneda_Emision       ,       --18    
   Moneda_Reajuste      ,       --19    
   Tipo_Tasa_Emision    ,       --20    
   Tasa_Emision         ,       --21    
   Tera                 ,       --22    
   Valor_Par            ,       --23    
   Tipo_Tasa_Compra     ,       --24    
   Tasa_Compra          ,       --25    
   Costo_Adquisicion    ,       --26    
   Costo_Amortizado     ,       --27    
   Valor_Razonable      ,       --28    
   Tipo_Tasa_Valoriza   ,       --29    
   Tasa_Valorizacion    ,       --30    
   Tipo_valorizacion    ,       --31    
   Precio_Instrumento   ,       --32 (19, 8)    
   Duracion_Modificada  ,       --33    
   Convexidad           ,       --34    
   Valor_Deterioro      ,       --35    
   Condicion_Instrumento,       --36    
   Fecha_Inicio_Cond    ,       --37    
   Fecha_Final_Cond     ,       --38    
  
   iCantidad    ,       --38  
   signoTCmp    ,   --39  
   signoTVal     ,       --40  
  
   Cartera     ,       --41            
   numero_Documento     ,   --42  
   Correlativo             --43  
     , 0 numoper   
 ,0 Valor_mercado   
 , 0 Cliente 
 , 0 CodCliente 
   from   
   #TABLA_P40_MX  
  
   union  
  
   select    
     Tipo_Registro     
    , Codigo_Tenedor     
    , Fecha_Proceso     
    , Fecha_Compra     
    , Tipo_Cartera     
    , Emisor       
    , Pais_Emisor      
    , Familia_Instrumento    
    , Nemotecnico      
    , Tipo_Rendimiento    
    , Periodicidad_Cupon    
    , Fecha_Ultimo_Cupon    
    , Fecha_Proximo_Cupon    
    , Fecha_Vcto_Instr    
    , Derivado_Incrust_Opc   
    , Nominal_Inicial     
    , Nominal_Actual     
    , Moneda_Emision     
    , Moneda_Reajuste     
    , Tipo_Tasa_Emision    
    , Tasa_Emision     
    , Tera       
    , Valor_Par      
    , Tipo_Tasa_Compra    
    , Tasa_Compra      
    , Costo_Adquisicion    
    , Costo_Amortizado    
    , Valor_Razonable     
    , Tipo_Tasa_Valoriza    
    , Tasa_Valorizacion    
    , Tipo_valorizacion    
    , Precio_Instrumento    
    , Duracion_Modificada    
    , Convexidad      
    , Valor_Deterioro     
    , Condicion_Instrumento   
    , Fecha_Inicio_Cond    
    , Fecha_Final_Cond    
    , iCantidad      
    , signoTCmp      
    , signoTVal      
     
    , cartera       
    , numdocu       
    , correla    
	   
 , numoper   
 , Valor_mercado   
 , Cliente 
 , CodCliente 
  
    from #tmp  
  
drop table #tmp  
drop table #TABLA_P40_MX  
End

END 
GO
