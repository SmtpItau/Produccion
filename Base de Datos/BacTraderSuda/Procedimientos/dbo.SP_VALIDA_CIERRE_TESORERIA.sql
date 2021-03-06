USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_CIERRE_TESORERIA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_CIERRE_TESORERIA]
            ( @Fecha_Hoy  DATETIME )
AS
BEGIN
set nocount on
DECLARE @tipo_operacion CHAR(5)
SELECT @tipo_operacion   = tipo_operacion
  FROM GEN_OPERACIONES 
 WHERE fecha_pago = @Fecha_Hoy 
   AND Cerrada    = 'N'
IF @@ROWCOUNT = 0
   SELECT 'SI'
ELSE
   SELECT 'NO'
set nocount off
END   /* FIN PROCEDIMIENTO */


GO
