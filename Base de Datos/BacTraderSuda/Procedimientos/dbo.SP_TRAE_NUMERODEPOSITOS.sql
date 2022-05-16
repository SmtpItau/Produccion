USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_NUMERODEPOSITOS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_NUMERODEPOSITOS]
               (@xNumeroOperacion NUMERIC(10))
          
     
AS
BEGIN
 DECLARE @Regs INTEGER
 
 SELECT  @Regs = COUNT(*) FROM GEN_CAPTACION WHERE numero_operacion = @xNumeroOperacion
 
 SELECT ISNULL(@Regs,0)
END

GO
