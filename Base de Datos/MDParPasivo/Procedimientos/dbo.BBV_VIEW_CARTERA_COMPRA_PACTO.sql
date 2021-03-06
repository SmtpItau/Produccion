USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_VIEW_CARTERA_COMPRA_PACTO]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_VIEW_CARTERA_COMPRA_PACTO]
as
SELECT cirutcart,citipcart,cinumdocu,cicorrela,cinumdocuo,cicorrelao,cirutcli,cicodcli,ciinstser,cimascara,cinominal,
       cifeccomp,civalcomp,civalcomu,civcum100,citircomp,citasest,cipvpcomp,civpcomp,cifecemi,cifecven,ciseriado,
       cicodigo,cifecinip,cifecvenp,civalinip,civalvenp,citaspact,cibaspact,cimonpact,civptirc,cicapitalc,ciinteresc,
       cireajustc,ciintermes,cireajumes,cicapitalci,ciinteresci,cireajustci,civptirci,cinumucup,cirutemi,cimonemi,
       cicontador,cifecucup,cinominalp,ciforpagi,ciforpagv,cifecpcup,cidcv,cidurat,cidurmod,ciconvex,
       fecha_compra_original,valor_compra_original,valor_compra_um_original,tir_compra_original,
       valor_par_compra_original,porcentaje_valor_par_compra_original,codigo_carterasuper,Tipo_Cartera_Financiera,
       Mercado,Sucursal,Id_Sistema,Fecha_PagoMañana,Laminas,Tipo_Inversion,Cuenta_Corriente_Inicio,
       Cuenta_Corriente_Final,Sucursal_Inicio,Sucursal_Final,Estado_Operacion_Linea,civalvenc
FROM VIEW_CARTERA_COMPRA_PACTO
GO
