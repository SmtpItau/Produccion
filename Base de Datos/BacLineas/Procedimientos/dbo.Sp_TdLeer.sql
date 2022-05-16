USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TdLeer]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TdLeer    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_TdLeer    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
CREATE PROC [dbo].[Sp_TdLeer](@tdmascara1 CHAR(10))
AS
BEGIN
set nocount on
       SELECT   tdmascara, tdcupon, CONVERT(CHAR(10),tdfecven,103), 
                tdinteres, tdamort, tdflujo, tdsaldo 
       FROM     TABLA_DESARROLLO  
       WHERE    tdmascara = @tdmascara1  
       ORDER BY tdcupon
RETURN
set nocount off
END






GO
