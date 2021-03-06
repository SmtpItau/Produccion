USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ULT_UF]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_ULT_UF]
 AS
 BEGIN
 DECLARE @fecha DATETIME
        SELECT   @fecha = MAX(vmfecha)
 FROM   VIEW_VALOR_MONEDA
 WHERE  vmcodigo = 998
 AND      vmvalor > 0
        SELECT   ISNULL(vmvalor,1)  ,
   CONVERT(CHAR(10),vmfecha,103) 
 FROM   VIEW_VALOR_MONEDA
 WHERE  vmcodigo = 998
 AND  vmfecha  = @fecha
 
 END

GO
