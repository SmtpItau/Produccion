USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TdLeer]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[Sp_TdLeer](@tdmascara1 CHAR(10))
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

       SELECT   tdmascara, tdcupon, CONVERT(CHAR(10),tdfecven,103), 
                tdinteres, tdamort, tdflujo, tdsaldo, spread_tasa_variable
       FROM     TABLA_DESARROLLO  
       WHERE    tdmascara = @tdmascara1  
       ORDER BY tdcupon


END


GO
