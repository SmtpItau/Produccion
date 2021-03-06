USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_LOG_POSCAM]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GENERA_LOG_POSCAM]
   (   @dFecha   DATETIME
   ,   @iNumero  NUMERIC(9)
   ,   @cUsuario VARCHAR(15)
   ,   @Anula    CHAR(1)    = 'N'
   ,   @Error    CHAR(1)    = 'N'
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iFound   INTEGER
   DECLARE @cEstado  CHAR(1)
   DECLARE @Mensaje  VARCHAR(250)
   DECLARE @cMercado VARCHAR(250)

      SET @iFound      = 0
   SELECT @iFound      = 1
        , @cEstado     = Estado
        , @cMercado    = CASE WHEN MercadoCambiario = 1 THEN 'OF. DE CAMBIO'
                              ELSE                           'COMEX'
                         END
     FROM dbo.MERCADO_CAMBIARIO
    WHERE OperacionBac = @iNumero
   
   IF @iFound = 0 --> Operación No Existe
   BEGIN
      RETURN
   END

   SET @Mensaje  = CASE WHEN @cEstado = 'E' THEN   'REENVIO DE OPERACION ' --> + LTRIM(RTRIM(@iNumero))
                        WHEN @cEstado = 'A' THEN 'ANULACION DE OPERACION ' --> + LTRIM(RTRIM(@iNumero))
                        WHEN @cEstado = 'P' THEN     'ENVIO DE OPERACION ' --> + LTRIM(RTRIM(@iNumero))
                   END
   IF @Anula = 'S'
      SET @Mensaje  = 'ANULACION DE OPERACION ' --> +  LTRIM(RTRIM(@iNumero))

   IF @Error = 'S'
   BEGIN
      SET @Mensaje  = 'ERROR DE ENVIO DE LA OPERACION ' --> +  LTRIM(RTRIM(@iNumero))
   END 

   INSERT INTO LOG_AUDITORIA
   (   Entidad
   ,   FechaProceso
   ,   FechaSistema
   ,   HoraProceso
   ,   Terminal
   ,   Usuario
   ,   Id_Sistema
   ,   Codigo_Evento
   ,   DetalleTransac
   ,   CodigoMenu
   ,   TablaInvolucrada
   ,   ValorAntiguo
   ,   ValorNuevo
   )
   SELECT 'Entidad'          = 1
   ,      'FechaProceso'     = @dFecha
   ,      'FechaSistema'     = GETDATE()
   ,      'HoraProceso'      = CONVERT(CHAR(10),GETDATE(),108)
   ,      'Terminal'         = 'POSCAM'
   ,      'Usuario'          = @cUsuario
   ,      'Id_Sistema'       = 'BCC'
   ,      'Codigo_Evento'    = '10'
   ,      'DetalleTransac'   = @Mensaje
   ,      'CodigoMenu'       = @iNumero
   ,      'TablaInvolucrada' = @cMercado
   ,      'ValorAntiguo'     = @cMercado
   ,      'ValorNuevo'       = @cMercado
   FROM   dbo.MERCADO_CAMBIARIO
   WHERE  OperacionBac       = @iNumero

END
GO
