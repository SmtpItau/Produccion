USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MDCP]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_MDCP]
AS
 SELECT
                cprutcart
                ,cptipcart
                ,cpnumdocu
                ,cpcorrela
                ,cpnumdocuo
                ,cpcorrelao
                ,cprutcli
                ,cpcodcli
                ,cpinstser
                ,cpmascara
                ,cpnominal
                ,cpfeccomp
                ,cpvalcomp
                ,cpvalcomu
                ,cpvcum100
                ,cptircomp
                ,cptasest
                ,cppvpcomp
                ,cpvpcomp
                ,cpnumucup
                ,cpfecemi
                ,cpfecven
                ,cpseriado
                ,cpcodigo
                ,cpvptirc
                ,cpcapitalc
                ,cpinteresc
                ,cpreajustc
                ,cpcontador
                ,cpfecucup
                ,cpfecpcup
                ,cpvcompori
                ,cpdcv
                ,cpdurat
                ,cpdurmod
                ,cpconvex
                ,fecha_compra_original
                ,valor_compra_original
                ,valor_compra_um_original
                ,tir_compra_original
                ,valor_par_compra_original
                ,porcentaje_valor_par_compra_original
                ,codigo_carterasuper
                ,tipo_cartera_financiera
                ,mercado
                ,sucursal
                ,id_sistema
                ,fecha_pagomañana
                ,laminas
                ,tipo_inversion
				,Tasa_Contrato
 FROM MDCP


GO
