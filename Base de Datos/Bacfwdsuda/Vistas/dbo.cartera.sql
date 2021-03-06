USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[cartera]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[cartera]
AS
SELECT  canumoper,
 cacodpos1,
 cacodmon1,
 cacodsuc1 ,
 cacodpos2 ,
 cacodmon2 ,
 cacodcart , 
 cacodigo  ,
 cacodcli  ,
 catipoper ,
 catipmoda ,
 convert(char(08),cafecha,112) as cafecha,
 catipcam  ,
 camdausd  ,
 camtomon1 ,
 caequusd1 ,
 caequmon1 ,
 camtomon2 ,
 caequusd2 ,
 caequmon2 ,
 caparmon1 ,
 capremon1 ,
 caparmon2 ,
 capremon2 ,
 caestado  ,
 caretiro  ,
 cacontraparte ,
 caobserv,
 captacom,
 captavta,
 caspread,
 cacolmon1,
 cacapmon1,
 catasadolar,
 catasaufclp,
 caprecal,
 caplazo,
 convert(char(08),cafecvcto,112) as cafecvcto,
 capreant,
 cavalpre,
 caoperador,
 catasfwdcmp,
 catasfwdvta,
 cacalcmpdol,
 cacalcmpspr,
 cacalvtadol,
 cacalvtaspr,
 catasausd,
 catasacon,
 cadiferen,
 cafpagomn,
 cafpagomx,
 cadiftipcam,
        cadifuf,
 caclpinicial,
 caclpfinal,
 camtodiferir,
 camtodevengar,
 cadevacum,
 catipcamval,
 camtoliq,
 camtocalzado,
 calock,
 camarktomarket,
 capreciomtm,
 capreciofwd,
 camtomon1ini,
 camtomon1fin,
 camtomon2ini,
 camtomon2fin,
 caplazoope,
 caplazovto,
 caplazocal,
 cadiasdev,
 cadelusd,
 cadeluf,
        carevusd,
 carevuf,
 carevtot,
 cavalordia,
 cactacambio_a,
 cactacambio_c,
 cautildiferir,
 caperddiferir,
 cautildevenga,
 caperddevenga,
 cautilacum,
 caperdacum,
 cautilsaldo,
 caperdsaldo,
 caclpmoneda1,
 caclpmoneda2,
 camtocomp,
 caantici,
 convert(char(08),cafecvenor,112) as cafecvenor,
 cabroker,
 convert(char(08),cafecmod,112) as cafecmod,
 cavalorayer,
 camontopfe,
 camontocce,
 id_sistema,
 precio_transferencia,
 tipo_sintetico,
 precio_spot,
 pais_origen,
 moneda_compensacion,
 riesgo_sintetico,
 precio_reversa_sintetico,
 calzada ,
 marca,
 numerointerfaz,
 contrato_entrega_via,
 contrato_emitido_por,
 contrato_ubicado_en fechaemision,
 convert(char(08),fecharecepcion,112) as fecharecepcion ,
 convert(char(08),fechaingresocustodia,112) as fechaingresocustodia,
 convert(char(08),fechafirmacontrato,112) as fechafirmacontrato,
 convert(char(08),fecharetirocustodia,112) as fecharetirocustodia,
 numerocontratocliente,
 capremio,
 catipopc
FROM mfca

GO
