USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VIEW_CARTERA_VENTA_PACTO]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_VIEW_CARTERA_VENTA_PACTO]
AS
SELECT virutcart,vinumdocu,vicorrela,vinumoper,vitipoper,virutcli,vicodcli,viinstser,vinominal,vifecinip,vifecvenp,
       vivalinip,vivalvenp,vitaspact,vibaspact,vimonpact,vivptirc,vivptirci,vivptirv,vivptirvi,vivalcomu,vivalcomp,
       vicapitalv,viinteresv,vireajustv,viintermesv,vireajumesv,vicapitalvi,viinteresvi,vireajustvi,viintermesvi,
       vireajumesvi,vivalvent,vivvum100,vivalvemu,vitirvent,vitasest,vipvpvent,vivpvent,vinumucupc,vinumucupv,
       virutemi,vimonemi,vifecemi,vifecven,vifecucup,vicodigo,vitircomp,vifeccomp,viseriado,vimascara,vivalinipci,
       vivalvenpci,vifecinipci,vifecvenpci,vitaspactci,vibaspactci,viinteresci,vicorvent,vinominalp,viforpagi,
       viforpagv,vicorrvent,vifecpcup,vivcompori,vivpcomp,vidurat,vidurmod,viconvex,viintacumcp,vireacumcp,viintacumvi,
       vireacumvi,viintacumci,vireacumci,fecha_compra_original,valor_compra_original,valor_compra_um_original,
       tir_compra_original,valor_par_compra_original,porcentaje_valor_par_compra_original,codigo_carterasuper,
       Tipo_Cartera_Financiera,Mercado,Sucursal,Id_Sistema,Fecha_PagoMañana,Laminas,Tipo_Inversion,
       Cuenta_Corriente_Inicio,Cuenta_Corriente_Final,Sucursal_Inicio,Sucursal_Final,vivalvenc
FROM VIEW_CARTERA_VENTA_PACTO
GO
