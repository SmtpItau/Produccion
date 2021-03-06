USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VIEW_CARTERA_PROPIA]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_VIEW_CARTERA_PROPIA]
AS
select cprutcart,cptipcart,cpnumdocu,cpcorrela,cpnumdocuo,cpcorrelao,cprutcli,cpcodcli,cpinstser,
       cpmascara,cpnominal,cpfeccomp,cpvalcomp,cpvalcomu,cpvcum100,cptircomp,cptasest,cppvpcomp,cpvpcomp,
       cpnumucup,cpfecemi,cpfecven,cpseriado,cpcodigo,cpvptirc,cpcapitalc,cpinteresc,cpreajustc,cpcontador,
       cpfecucup,cpfecpcup,cpvcompori,cpdcv,cpdurat,cpdurmod,cpconvex,cpintermes,cpreajumes,fecha_compra_original,
       valor_compra_original,valor_compra_um_original,tir_compra_original,valor_par_compra_original,
       porcentaje_valor_par_compra_original,codigo_carterasuper,Tipo_Cartera_Financiera,Mercado,Sucursal,Id_Sistema,
       Fecha_PagoMañana,Laminas,Tipo_Inversion,Estado_Operacion_Linea,cpvalvenc
from VIEW_CARTERA_PROPIA
GO
