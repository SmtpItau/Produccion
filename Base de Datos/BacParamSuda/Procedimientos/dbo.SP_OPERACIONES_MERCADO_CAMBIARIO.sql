USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERACIONES_MERCADO_CAMBIARIO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_OPERACIONES_MERCADO_CAMBIARIO]
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProc DATETIME
   SET     @dFechaProc = (SELECT acfecpro FROM BacCamSuda..MEAC)

   DELETE  dbo.MERCADO_CAMBIARIO
   WHERE   Fecha            = @dFechaProc
      AND  Estado           = 'P'
      AND  MercadoCambiario = 0

   INSERT INTO dbo.MERCADO_CAMBIARIO
   SELECT Fecha        = mofech
   ,      NumeroBac    = monumope
   ,      TipoOper     = motipope
   ,      Cliente      = morutcli
   ,      Codigo       = mocodcli
   ,      Moneda       = mocodmon
   ,      MontoMx      = momonmo
   ,      MonedaCnv    = mocodcnv
   ,      MontoCnv     = CASE WHEN mocodcnv = 'CLP' THEN momonpe ELSE moussme END
   ,      TCambio      = moticam
   ,      Pesos        = moparme
   ,      Mercado      = 0
   ,      FormaPago    = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      Estado       = 'P'
   ,      Operador     = mooper
   ,      Confirma     = ''
   ,      NumeroIBS    = CONVERT(NUMERIC(10),0)
   ,      Liquidado    = CONVERT(NUMERIC(21,4),0.0)
   ,      LiquiCnv     = CONVERT(NUMERIC(21,4),0.0)
   ,      Mercoper     = motipmer
   FROM   BacCamSuda..MEMO
   WHERE  motipmer     = 'EMPR'
   AND    moestatus    = ''
   AND    monumope     NOT IN( SELECT OperacionBac FROM dbo.MERCADO_CAMBIARIO WHERE Fecha = @dFechaProc )

   INSERT INTO dbo.MERCADO_CAMBIARIO
   SELECT Fecha        = mofech
   ,      NumeroBac    = monumope
   ,      TipoOper     = motipope
   ,      Cliente      = morutcli
   ,      Codigo       = mocodcli
   ,      Moneda       = mocodmon
   ,      MontoMx      = momonmo
   ,      MonedaCnv    = mocodcnv
   ,      MontoCnv     = CASE WHEN mocodcnv = 'CLP' THEN momonpe ELSE moussme END
   ,      TCambio      = moticam
   ,      Pesos        = moparme
   ,      Mercado      = 0
   ,      FormaPago    = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      Estado       = 'P'
   ,      Operador     = mooper
   ,      Confirma     = ''
   ,      NumeroIBS    = CONVERT(NUMERIC(10),0)
   ,      Liquidado    = CONVERT(NUMERIC(21,4),0.0)
   ,      LiquiCnv     = CONVERT(NUMERIC(21,4),0.0)
   ,      Mercoper     = motipmer
   FROM   BacCamSuda..MEMO
   WHERE  motipmer     = 'ARBI'
   AND    moestatus    = ''
   AND    monumope     NOT IN( SELECT OperacionBac FROM dbo.MERCADO_CAMBIARIO WHERE Fecha = @dFechaProc )
   

END
GO
