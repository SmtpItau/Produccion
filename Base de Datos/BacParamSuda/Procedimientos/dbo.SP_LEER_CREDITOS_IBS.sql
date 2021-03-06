USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CREDITOS_IBS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_CREDITOS_IBS]
   (   @nRutCliente   NUMERIC(10) = 0
   ,   @nCodCliente   INTEGER     = 0
   ,   @nMoneda       INTEGER     = 0
   ,   @eFiltro       INTEGER     = 0
   ,   @dFechaVcto    DATETIME    = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nContador   NUMERIC(9)

   IF @eFiltro = 0
   BEGIN

      SELECT  NumCredito           = ca.Numero_Credito
          ,   NomCliente           = ca.Nombre_Cliente
          ,   RutClient            = LTRIM(RTRIM( ca.Rut_Cliente )) + '-' + ca.Dv_Cliente
          ,   Moneda               = mn.mnnemo --> ca.Moneda
          ,   Capital              = ca.Monto_Capital
          ,   FecVcto              = ca.Fecha_Vencimiento
          ,   Derivado             = 0
          ,   Modulo               = ' '
        INTO  #RETORNO_A
        FROM  BacParamSuda.dbo.CREDITOS_IBS     ca
              LEFT JOIN BacParamSuda.dbo.MONEDA mn ON mn.mncodmon = ca.Moneda
       WHERE (ca.Rut_Cliente       = @nRutCliente OR @nRutCliente = 0)
       AND   (ca.Codigo_Cliente    = @nCodCliente OR @nCodCliente = 0)
       AND   (ca.Moneda            = @nMoneda     OR @nMoneda     = 0)
       AND   (ca.Fecha_Vencimiento = @dFechaVcto  OR @dFechaVcto  = '')
       AND    ca.Numero_Credito    NOT IN( SELECT Numero_Credito FROM BacParamSuda.dbo.RELACION_CREDITO_DERIVADO with(nolock) )

       SET @nContador = (SELECT COUNT(1) FROM #RETORNO_A)

      SELECT  NumCredito
          ,   NomCliente
          ,   RutClient
          ,   Moneda
          ,   Capital
          ,   FecVcto
          ,   Derivado
          ,   Modulo
          ,   Registros = @nContador
      FROM    #RETORNO_A

   END ELSE
   BEGIN

      SELECT  NumCredito           = ca.Numero_Credito
          ,   NomCliente           = ca.Nombre_Cliente
          ,   RutClient            = LTRIM(RTRIM( ca.Rut_Cliente )) + '-' + ca.Dv_Cliente
          ,   Moneda               = mn.mnnemo --> ca.Moneda
          ,   Capital              = ca.Monto_Capital
          ,   FecVcto              = ca.Fecha_Vencimiento
          ,   Derivado             = rela.Numero_Derivado
          ,   Modulo               = rela.Modulo_Derivado
        INTO  #RETORNO_B
        FROM  BacParamSuda.dbo.CREDITOS_IBS     ca
              LEFT  JOIN BacParamSuda.dbo.MONEDA mn ON mn.mncodmon = ca.Moneda
              INNER JOIN BacParamSuda.dbo.RELACION_CREDITO_DERIVADO rela ON rela.Numero_Credito = ca.Numero_Credito
       WHERE (ca.Rut_Cliente       = @nRutCliente OR @nRutCliente = 0)
       AND   (ca.Codigo_Cliente    = @nCodCliente OR @nCodCliente = 0)
       AND   (ca.Moneda            = @nMoneda     OR @nMoneda     = 0)
       AND   (ca.Fecha_Vencimiento = @dFechaVcto  OR @dFechaVcto  = '')
       AND    ca.Numero_Credito    IN( SELECT Numero_Credito FROM BacParamSuda.dbo.RELACION_CREDITO_DERIVADO with(nolock) )

      SET @nContador = (SELECT COUNT(1) FROM #RETORNO_B)

      SELECT  NumCredito
          ,   NomCliente
          ,   RutClient
          ,   Moneda
          ,   Capital
          ,   FecVcto
          ,   Derivado
          ,   Modulo
          ,   Registros = @nContador
      FROM    #RETORNO_B

   END

END
GO
