USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_TABLA_DESARROLLO]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_TABLA_DESARROLLO]
AS
SELECT tdmascara,tdcupon,tdfecven,tdinteres,tdamort,tdflujo,tdsaldo,spread_tasa_variable
 FROM TABLA_DESARROLLO
GO
