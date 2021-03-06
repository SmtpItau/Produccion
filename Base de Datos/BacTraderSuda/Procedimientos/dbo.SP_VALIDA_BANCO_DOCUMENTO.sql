USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_BANCO_DOCUMENTO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_BANCO_DOCUMENTO]
                                           (@Codigo_Banco   NUMERIC( 6),
         @NDocumento     NUMERIC(19),
         @Forma_pago        CHAR( 5))  
AS
BEGIN
 IF EXISTS(SELECT * FROM GEN_PAGOS_OPERACION WHERE numero_documento = @NDocumento AND Codigo_Banco = @Codigo_Banco  AND Forma_Pago = @Forma_Pago)
  SELECT 'SI' 
 ELSE
  SELECT 'NO'
 ENDIF
END

GO
