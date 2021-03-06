USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_PAGOS_OPERACION]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_PAGOS_OPERACION]
                  ( @Tipo_Canje      CHAR(1)     ,
                    @Nro_Docto       NUMERIC(10) ,
                    @Forma_Pago      CHAR(4)     ,
                    @Monto           FLOAT       ,
                   @Codigo_Banco    NUMERIC(10) )
AS 
BEGIN
DECLARE @VCAMARA    CHAR(4) ,
        @Fecha_Hoy  DATETIME,
 @Fecha_Pago DATETIME
SET NOCOUNT ON
SELECT @VCAMARA   = CONVERT(CHAR(4),Folio) FROM GEN_FOLIOS WHERE codigo = 'CAMARA'
SELECT @Fecha_Hoy = ACFECPROC FROM MDAC
SELECT @Fecha_Pago = Fecha_Pago 
  FROM GEN_PAGOS_OPERACION 
 WHERE numero_documento = @Nro_Docto 
   AND forma_pago       = @Forma_Pago
   AND tipo_canje       = @Tipo_Canje
   AND estado           = 'A'
   AND (@Monto = 0 OR Monto_Operacion = @Monto)
IF @Fecha_Pago >= @Fecha_Hoy AND @Forma_Pago <> @VCAMARA
BEGIN
   SELECT 'FECHA'
   SET NOCOUNT OFF
   RETURN 
END
IF @Tipo_Canje = 'E' 
   SELECT *
     FROM GEN_PAGOS_OPERACION 
    WHERE numero_documento = @Nro_Docto
      AND forma_pago       = @Forma_Pago
      AND tipo_canje       = @Tipo_Canje
      AND monto_operacion  = @Monto
      AND codigo_banco     = @Codigo_Banco
      AND estado           = 'A'
      AND (Forma_Pago = @VCAMARA OR (Fecha_Pago < @Fecha_Hoy AND Forma_Pago <> @VCAMARA))
ELSE
   SELECT *
     FROM GEN_PAGOS_OPERACION 
    WHERE numero_documento = @Nro_Docto
      AND forma_pago       = @Forma_Pago
      AND tipo_canje       = @Tipo_Canje
      AND (@Monto = 0 OR monto_operacion  = @Monto)
      AND estado           = 'A'
      AND (Forma_Pago      = @VCAMARA OR (Fecha_Pago < @Fecha_Hoy AND Forma_Pago <> @VCAMARA))
SET NOCOUNT OFF
END


GO
