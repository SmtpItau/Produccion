USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_SERIE]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_SERIE]
AS
SELECT secodigo,semascara,seserie,serutemi,sefecemi,sefecven,setasemi,setera,sebasemi,semonemi,secupones,sediavcup,
       sepervcup,setipvcup,seplazo,setipamort,senumamort,seffijos,sebascup,sedecs,secorte,setotalemitido,
       primer_vcto_variable,primer_vencimiento,tipo_letra,control_amortizacion,spread_tasa
 FROM SERIE
GO
