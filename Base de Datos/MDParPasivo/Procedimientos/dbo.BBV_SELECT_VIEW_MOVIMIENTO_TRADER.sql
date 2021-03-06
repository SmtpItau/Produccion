USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VIEW_MOVIMIENTO_TRADER]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_VIEW_MOVIMIENTO_TRADER]
AS
SELECT mofecpro,morutcart,motipcart,monumdocu,mocorrela,monumdocuo,mocorrelao,monumoper,motipoper,motipopero,moinstser,
       momascara,mocodigo,moseriado,mofecemi,mofecven,momonemi,motasemi,mobasemi,morutemi,monominal,movpresen,momtps,
       momtum,momtum100,monumucup,motir,mopvp,movpar,motasest,mofecinip,mofecvenp,movalinip,movalvenp,motaspact,
       mobaspact,momonpact,moforpagi,moforpagv,motipobono,mocondpacto,mopagohoy,morutcli,mocodcli,motipret,mohora,
       mousuario,moterminal,mocapitali,mointeresi,moreajusti,movpreseni,mocapitalp,mointeresp,moreajustp,movpresenp,
       motasant,mobasant,movalant,mostatreg,movpressb,modifsb,monominalp,movalcomp,movalcomu,mointeres,moreajuste,
       mointpac,moreapac,moutilidad,moperdida,movalven,mocontador,monsollin,moobserv,moobserv2,movvista,movviscom, 
       momtocomi,mocorvent,modcv,moclave_dcv,mocodexceso,momtoPFE,momtoCCE,mointermesc,moreajumesc,mointermesvi,
       moreajumesvi,fecha_compra_original,valor_compra_original,valor_compra_um_original,tir_compra_original,
       valor_par_compra_original,porcentaje_valor_par_compra_original,codigo_carterasuper,Tipo_Cartera_Financiera,
       Mercado,Sucursal,Id_Sistema,Fecha_PagoMañana,Laminas,Tipo_Inversion,Cuenta_Corriente_Inicio,
       Cuenta_Corriente_Final,Sucursal_Inicio,Sucursal_Final,Estado_Control,moimpreso
FROM VIEW_MOVIMIENTO_TRADER
GO
