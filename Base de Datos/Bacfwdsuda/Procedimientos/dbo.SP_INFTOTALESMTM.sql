USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFTOTALESMTM]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFTOTALESMTM]
AS
BEGIN
Declare  @dFecPro      Datetime
Declare  @dFecProx     Datetime
Declare  @nVarTotMtm   NUMERIC (21,4)
Declare  @nEfeCmbUs    NUMERIC (21,4)
Declare  @nEfeCmbCn    NUMERIC (21,4)
Declare  @nCmbTasUs    NUMERIC (21,4) 
Declare  @nCmbTasUf    NUMERIC (21,4) 
Declare  @nCmbTasCl    NUMERIC (21,4) 
Declare  @nDevengUs    NUMERIC (21,4) 
declare  @nDevengCn    NUMERIC (21,4) 
Declare  @nMtmDia      NUMERIC (21,4) 
Declare  @nEfeLiq      NUMERIC (21,4) 
Declare  @nVenEst      NUMERIC (21,4) 
Declare  @nResiduo     NUMERIC (21,4) 
Declare  @mtmayerhoy   NUMERIC (21,4)  
Declare  @nVarTotMtmT   NUMERIC (21,4)
Declare  @nEfeCmbUST   NUMERIC (21,4)
Declare  @nEfeCmbCnT   NUMERIC (21,4) 
Declare  @nCmbTasUsT   NUMERIC (21,4) 
Declare  @nCmbTasUfT   NUMERIC (21,4) 
Declare  @nCmbTasClT   NUMERIC (21,4) 
Declare  @nDevengUsT   NUMERIC (21,4) 
Declare  @nDevengCnT   NUMERIC (21,4) 
Declare  @nMtmDiaT     NUMERIC (21,4)
Declare  @nEfeLiqT     NUMERIC (21,4)
Declare  @nVenEstT     NUMERIC (21,4) 
Declare  @nResiduoT    NUMERIC (21,4) 
Declare  @nVarTotMtmI   NUMERIC (21,4)
Declare  @nEfeCmbUSI   NUMERIC (21,4)
Declare  @nEfeCmbCnI   NUMERIC (21,4) 
Declare  @nCmbTasUsI   NUMERIC (21,4) 
Declare  @nCmbTasUfI   NUMERIC (21,4) 
Declare  @nCmbTasClI   NUMERIC (21,4) 
Declare  @nDevengUsI   NUMERIC (21,4) 
Declare  @nDevengCnI   NUMERIC (21,4) 
Declare  @nMtmDiaI     NUMERIC (21,4)
Declare  @nEfeLiqI     NUMERIC (21,4)
Declare  @nVenEstI     NUMERIC (21,4) 
Declare  @nResiduoI    NUMERIC (21,4)
Declare  @nTotMtm      NUMERIC (21,4) 
Declare  @nTotMtmT     NUMERIC (21,4) 
Declare  @nTotMtmI     NUMERIC (21,4) 
Declare  @nObsEstimado NUMERIC (12,2) 
Declare  @nInter       NUMERIC (12,2)
Select @dFecPro      =(Select acfecproc from mfac )
Select @dFecProx    =(Select acfecprox from mfac )
Select @nObsEstimado = ISNULL( ( SELECT tasa_compra from view_tasa_fwd where fecha =@dFecPro and codigo=2 ),1)
Select @nInter       = ISNULL( ( SELECT vmvalor FROM view_valor_moneda where vmfecha =@dFecPro and vmcodigo=988 ) , 1 )
Select @nVarTotMtm =(Select Sum((mtm_hoy_moneda1 + mtm_hoy_moneda2 )-(mtm_ayer_moneda1+mtm_ayer_moneda2)+ camtocomp) from mfca where cacodpos1<>2 and cacodpos1<>3 and cafecvcto > @dFecpro)
Select @nVarTotMtm = @nVarTotMtm + ISNULL( (Select sum(-(mtm_ayer_moneda1+mtm_ayer_moneda2)+ camtocomp) from mfca where  cacodpos1<>2 and cacodpos1<>3 and cafecvcto <= @dFecpro) , 0 )
Select @nEfeCmbUs  = (Select Sum( efecto_cambio_moneda1) from mfca where cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro)
Select @nEfeCmbCn  = (Select Sum( efecto_cambio_moneda2) from mfca where cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro)
Select @nCmbTasUs  = (Select Sum( cambio_tasa_moneda1)   from mfca where cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro) 
Select @nCmbTasUf  = (Select Sum( cambio_tasa_moneda2)   from mfca where (cacodpos1<>2 and cacodpos1<>3 )and cacodmon2=998 and cafecvcto > @dFecpro ) 
Select @nCmbTasCl  = (Select Sum( cambio_tasa_moneda2)   from mfca where (cacodpos1<>2 and cacodpos1<>3 )and cacodmon2=999 and cafecvcto > @dFecpro ) 
Select @nDevengUs  = (Select Sum( devengo_tasa_moneda1 ) from mfca where cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro) 
Select @nDevengCn  = (Select Sum( devengo_tasa_moneda2 ) from mfca where cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro) 
Select @nMtmDia    = ISNULL( (Select Sum( mtm_hoy_moneda1 + mtm_hoy_moneda2 ) from mfca where cacodpos1<>2 And cacodpos1<>3 and cafecha = @dFecpro) , 0 )
Select @nEfeLiq    = ISNULL( (Select Sum( camtocomp-(mtm_ayer_moneda1+mtm_ayer_moneda2)) from mfca where cacodpos1<>2 And cacodpos1<>3 and cafecvcto = @dFecpro) , 0 )
Select @nVenEst    = ISNULL( (Select sum((camtomon1*(case when  catipoper='C' then 1 else -1 end))*(@nObsEstimado-@nInter )) from mfca where cacodpos1<>2 And cacodpos1<>3 and cafecvcto=@dFecprox) , 0 )
Select @mtmayerhoy = ISNULL( (Select Sum( ( mtm_hoy_moneda1 + mtm_hoy_moneda2 ) - ( mtm_ayer_moneda1 + mtm_ayer_moneda2 ) ) from mfca where cacodpos1<>2 And cacodpos1<>3 and cafecha <> @dFecpro and cafecvcto > @dFecpro ) , 0 )
Select @nResiduo = @nVarTotMtm - @nEfeCmbUs  -  @nEfeCmbCn  - @nCmbTasUs  - @nCmbTasUf -
                   @nCmbTasCl  - @nDevengUs  - @nDevengCn  -  @nMtmDia    - @nEfeLiq   
--1 TRading
Select @nVarTotMtmT = ISNULL( (Select Sum((mtm_hoy_moneda1 + mtm_hoy_moneda2 )-(mtm_ayer_moneda1+mtm_ayer_moneda2)+ camtocomp) from mfca where cacodcart=1 and cacodpos1<>2 and cacodpos1<>3 and cafecvcto > @dFecpro) , 0 )
Select @nVarTotMtmT = @nVarTotMtmT + ISNULL( (Select sum(-(mtm_ayer_moneda1+mtm_ayer_moneda2)+ camtocomp) from mfca where  cacodcart=1 and cacodpos1<>2 and cacodpos1<>3 and cafecvcto <= @dFecpro) , 0 )
Select @nEfeCmbUST  = ISNULL( (Select Sum( efecto_cambio_moneda1) from mfca where cacodcart=1 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro) , 0 )
Select @nEfeCmbCnT  = ISNULL( (Select Sum( efecto_cambio_moneda2) from mfca where cacodcart=1 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro) , 0 )
Select @nCmbTasUsT  = ISNULL( (Select Sum( cambio_tasa_moneda1)   from mfca where cacodcart=1 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro) , 0 )
Select @nCmbTasUfT  = ISNULL( (Select Sum( cambio_tasa_moneda2)   from mfca where cacodcart=1 and (cacodpos1<>2 And cacodpos1<>3 ) and cacodmon2=998 and cafecvcto > @dFecpro) , 0 )
Select @nCmbTasClT  = ISNULL( (Select Sum( cambio_tasa_moneda2)   from mfca where cacodcart=1 and (cacodpos1<>2 and cacodpos1<>3)and cacodmon2=999 and cafecvcto > @dFecpro) , 0 )
Select @nDevengUsT  = ISNULL( (Select Sum( devengo_tasa_moneda1 ) from mfca where cacodcart=1 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro) , 0 )
Select @nDevengCnT  = ISNULL( (Select Sum( devengo_tasa_moneda2 ) from mfca where cacodcart=1 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro) , 0 )
Select @nMtmDiaT    = ISNULL( (Select Sum( mtm_hoy_moneda1 + mtm_hoy_moneda2 )from mfca where cacodcart=1 and cacodpos1<>2 And cacodpos1<>3 and cafecha = @dFecpro) , 0 )
Select @nEfeLiqT    = ISNULL( (Select Sum( camtocomp-(mtm_ayer_moneda1+mtm_ayer_moneda2)) from mfca where cacodcart=1 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto = @dFecpro) , 0 )
Select @nVenEstT    = ISNULL( (Select sum((camtomon1*(case when  catipoper='C' then 1 else -1 end))*(@nObsEstimado-@nInter )) from mfca where cacodcart=1 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto=@dFecprox) , 0 )
Select @nResiduoT = @nVarTotMtmT - @nEfeCmbUsT  -  @nEfeCmbCnT  - @nCmbTasUsT  - @nCmbTasUfT -
                    @nCmbTasClT  - @nDevengUsT  - @nDevengCnT  -  @nMtmDiaT    - @nEfeLiqT   
--2 Inversiones
Select @nVarTotMtmI =isnull((Select Sum((mtm_hoy_moneda1 + mtm_hoy_moneda2 )-(mtm_ayer_moneda1+mtm_ayer_moneda2)+ camtocomp) from mfca where cacodcart=2 and cacodpos1<>2 and cacodpos1<>3 and cafecvcto > @dFecpro),0)
Select @nVarTotMtmI = @nVarTotMtmI + ISNULL( (Select sum(-(mtm_ayer_moneda1+mtm_ayer_moneda2)+ camtocomp) from mfca where  cacodcart=2 and cacodpos1<>2 and cacodpos1<>3 and cafecvcto <= @dFecpro) , 0 )
Select @nEfeCmbUSI =isnull((Select Sum( efecto_cambio_moneda1) from mfca where cacodcart=2 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro),0)
Select @nEfeCmbCnI =isnull((Select Sum( efecto_cambio_moneda2) from mfca where cacodcart=2 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro),0)
Select @nCmbTasUsI =isnull((Select Sum( cambio_tasa_moneda1)   from mfca where cacodcart=2 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro) ,0)
Select @nCmbTasUfI =isnull((Select Sum( cambio_tasa_moneda2)   from mfca where cacodcart=2 and cacodpos1<>2 And cacodpos1<>3 and cacodmon2=998 and cafecvcto > @dFecpro) ,0)
Select @nCmbTasClI =isnull((Select Sum( cambio_tasa_moneda2)   from mfca where cacodcart=2 and cacodpos1<>2 And cacodpos1<>3 and cacodmon2=999 and cafecvcto > @dFecpro) ,0)
Select @nDevengUsI =isnull((Select Sum( devengo_tasa_moneda1 ) from mfca where cacodcart=2 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro),0) 
Select @nDevengCnI =isnull((Select Sum( devengo_tasa_moneda2 ) from mfca where cacodcart=2 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto > @dFecpro),0) 
Select @nMtmDiaI   =isnull((Select Sum( mtm_hoy_moneda1 + mtm_hoy_moneda2 )from mfca where cacodcart=2 and cacodpos1<>2 And cacodpos1<>3 and cafecha = @dFecpro),0) 
Select @nEfeLiqI   =isnull((Select Sum( camtocomp-(mtm_ayer_moneda1+mtm_ayer_moneda2)) from mfca where cacodcart=2 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto = @dFecpro),0) 
Select @nVenEstI =isnull((Select sum((camtomon1*(case when  catipoper='C' then 1 else -1 end))*(@nObsEstimado-@nInter )) from mfca where cacodcart=2 and cacodpos1<>2 And cacodpos1<>3 and cafecvcto=@dFecprox),0) 
Select @nResiduoI = @nVarTotMtmI - @nEfeCmbUsI  -  @nEfeCmbCnI  - @nCmbTasUsT  - @nCmbTasUfT -
                    @nCmbTasClT  - @nDevengUsT  - @nDevengCnT  -  @nMtmDiaT    - @nEfeLiqT   
--select  Sum( mtm_hoy_moneda1 + mtm_hoy_moneda2 ) from mfca where cacodcart=2 and  cacodpos1<>2 And cacodpos1<>3 
Select @nTotMtm   = @nEfeCmbUS + @nEfeCmbCn + @nCmbTasUs + @nCmbTasUf + @nCmbTasCl + @nDevengUs + 
                    @nDevengCn + @nMtmDia   + @nEfeLiq   + @nResiduo
Select @nTotMtmT  = @nEfeCmbUST + @nEfeCmbCnT + @nCmbTasUsT + @nCmbTasUfT + @nCmbTasClT + @nDevengUsT + 
                    @nDevengCnT + @nMtmDiaT   +  @nEfeLiqT  + @nResiduoT
Select @nTotMtmI  = @nEfeCmbUSI + @nEfeCmbCnI + @nCmbTasUsI + @nCmbTasUfI + @nCmbTasClI + @nDevengUsI + 
                    @nDevengCnI + @nMtmDiaI   + @nEfeLiqI   + @nResiduoI
Select 'Variacion Total MTM'            = @nVarTotMtm ,
       'Observado Estimado'             = @nObsEstimado ,
       'C.Tot Resul. por TC'            = @nEfeCmbUS,
       'C.Tot Resul. por Reajuste UF'   = @nEfeCmbCn,
       'C.Tot Resul. por Tasa US'       = @nCmbTasUs,
       'C.Tot Resul. por Tasa UF'       = @nCmbTasUf,
       'C.Tot Resul. por Tasa $'        = @nCmbTasCl,       
       'C.Tot Resul. por Devengo US'    = @nDevengUs,
       'C.Tot Resul. por Devengo $'     = @nDevengCn,
       'C.Tot Resul. Trading del Dia'   = @nMtmDia,
       'C.Tot Resul. Trading c/efecto Venc' =@nMtmDia + @nVenEst ,
       'C.Tot Resul. Mtm Vs Comp.Reales'= @nEfeLiq,
       'C.Tot Otros Efectos'            = @nResiduo,
       'C.Tot Total'                    = @nTotMtm,
       'C.Tra Resul. por TC'            = @nEfeCmbUST,
       'C.Tra Resul. por Reajuste UF'   = @nEfeCmbCnT,
       'C.Tra Resul. por Tasa US'       = @nCmbTasUsT,
       'C.Tra Resul. por Tasa UF'       = @nCmbTasUfT,
       'C.Tra Resul. por Tasa $'        = @nCmbTasClT,       
       'C.Tra Resul. por Devengo US'    = @nDevengUsT,
       'C.Tra Resul. por Devengo $'     = @nDevengCnT,
       'C.Tra Resul. Trading del Dia'   = @nMtmDiaT,
       'C.Tra Resul. Trading c/efecto Venc' =@nMtmDiaT + @nVenEstT,
       'C.Tra Resul. Mtm Vs Comp.Reales'= @nEfeLiqT,
       'C.Tra Otros Efectos'            = @nResiduoT,
       'C.Tra Total'                    = @nTotMtmT,
       'C.Inv Resultado Operaciones del Dia'= @nMtmDiaI,
       'C.Inv Resul. Trading c/efecto Venc' = @nMtmDiaI + @nVenEstI,      
       'C.Inv Total'                    = @nTotMtmI,
       'Fecha Proceso'                = CONVERT(char(10),@dFecPro,103),
       'Hora'                         = CONVERT(CHAR(5),getdate(),108 ),
       'Nombre Propietario'           = (Select acnomprop from mfac )
end
/*
1               SEGURO DE CAMBIO                                   BFW
2               ARBITRAJE A FUTURO                                 BFW
3               SEGURO DE INFLACION                                BFW
4               SINTETICO                                          BFW
5               OPERACION 1446                                     BFW
6               OPERACIONES HEDGE                                  BFW
7               COMPENSACIONES PARCIALES                           BFW
8               VENTAS AL BCCH                                     BFW
9               OPCIONES                                           BFW
(Select Sum((mtm_hoy_moneda1 + mtm_hoy_moneda2 )-(mtm_ayer_moneda1+mtm_ayer_moneda2)+ camtocomp) from mfca where cacodpos1<>2 and cacodpos1<>3 and cafecvcto > '20010523')
(Select Sum((mtm_hoy_moneda1 + mtm_hoy_moneda2 )) from mfca where cacodpos1<>2 and cacodpos1<>3 and cafecvcto > '20010523')
(Select Sum((mtm_ayer_moneda1+mtm_ayer_moneda2)) from mfca where cacodpos1<>2 and cacodpos1<>3 and cafecvcto > '20010523')
Select mtm_hoy_moneda1 , mtm_hoy_moneda2 from mfca where canumoper=25481
Select mtm_ayer_moneda1 , mtm_ayer_moneda2 from mfca where canumoper=25481
Select Sum( camtocomp-(mtm_ayer_moneda1+mtm_ayer_moneda2)) from mfca where cacodpos1<>2 And cacodpos1<>3 and cafecvcto = '20011210'
Select Sum((mtm_hoy_moneda1 + mtm_hoy_moneda2 )-(mtm_ayer_moneda1+mtm_ayer_moneda2)+ camtocomp) from mfca where cacodpos1<>2 and cacodpos1<>3 and cafecvcto > '20011210'
Select sum(-(mtm_ayer_moneda1+mtm_ayer_moneda2)+ camtocomp) from mfca where  cacodpos1<>2 and cacodpos1<>3 and cafecvcto <= '20011210'
Select Sum( mtm_hoy_moneda1 + mtm_hoy_moneda2 ) from mfca where cacodpos1<>2 And cacodpos1<>3 and cafecha = '20011210'
Select Sum( cambio_tasa_moneda2) from mfca where ( cacodpos1<>2 And cacodpos1<>3 ) and cacodmon2=998 and cafecvcto > '20011210'
*/

GO
