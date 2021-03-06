USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VIEW_CARTERA_FORWARD_HISTORICA]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_VIEW_CARTERA_FORWARD_HISTORICA]
AS
SELECT canumoper,cacodpos1,cacodmon1,cacodsuc1,cacodpos2,cacodmon2,cacodcart,cacodigo,cacodcli,catipoper,catipmoda,
       cafecha,catipcam,camdausd,camtomon1,caequusd1,caequmon1,camtomon2,caequusd2,caequmon2,caparmon1,capremon1,
       caparmon2,capremon2,caestado,caretiro,cacontraparte,caobserv,captacom,captavta,caspread,cacolmon1,cacapmon1,
       catasadolar,catasaufclp,caprecal,caplazo,cafecvcto,capreant,cavalpre,caoperador,catasfwdcmp,catasfwdvta,
       cacalcmpdol,cacalcmpspr,cacalvtadol,cacalvtaspr,catasausd,catasacon,cadiferen,cafpagomn,cafpagomx,cadiftipcam,
       cadifuf,caclpinicial,caclpfinal,camtodiferir,camtodevengar,cadevacum,catipcamval,camtoliq,camtocalzado,calock,
       camarktomarket,capreciomtm,capreciofwd,camtomon1ini,camtomon1fin,camtomon2ini,camtomon2fin,caplazoope,caplazovto,
       caplazocal,cadiasdev,cadelusd,cadeluf,carevusd,carevuf,carevtot,cavalordia,cactacambio_a,cactacambio_c,
       cautildiferir,caperddiferir,cautildevenga,caperddevenga,cautilacum,caperdacum,cautilsaldo,caperdsaldo,
       caclpmoneda1,caclpmoneda2,camtocomp,caantici,cafecvenor,cabroker,cavalorayer,camontopfe,camontocce,codigo_area,
       Precio_Transferencia,Tipo_Sintetico,Precio_Spot,Pais_Origen,Moneda_Compensacion,Riesgo_Sintetico,
       Precio_Reversa_Sintetico,Calzada,Marca,NumeroInterfaz,Contrato_Entrega_Via,Contrato_Emitido_Por,
       Contrato_Ubicado_En,Fechaemision,FechaRecepcion,FechaIngresoCustodia,FechaFirmaContrato,FechaRetiroCustodia,
       NumeroContratoCliente,Contabiliza,Fecha_Proceso,Codigo_Subproducto,Numero_Operacion
FROM VIEW_CARTERA_FORWARD_HISTORICA
GO
