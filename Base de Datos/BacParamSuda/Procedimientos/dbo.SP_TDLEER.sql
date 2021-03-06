USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TDLEER]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TDLEER    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_TDLEER    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
CREATE PROCEDURE [dbo].[SP_TDLEER](@tdmascara1 CHAR(10))
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
