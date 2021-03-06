USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MT_298]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MT_298]
   (   @Sistema VARCHAR(4)
   ,   @Numero  NUMERIC(10)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Rutprop        NUMERIC(10)
   ,       @LBTR           DATETIME
   ,       @LBTR24         DATETIME
   ,       @LBTR48         DATETIME
   ,       @fc_proceso     DATETIME

   SELECT @Rutprop    = acrut
   ,      @fc_proceso = acfecpro  
   FROM   MEAC
   
   EXECUTE BacTraderSuda..SP_BUSCA_FECHA_HABIL @fc_proceso , 0 , @lbtr   OUTPUT
   EXECUTE BacTraderSuda..SP_BUSCA_FECHA_HABIL @fc_proceso , 1 , @lbtr24 OUTPUT
   EXECUTE BacTraderSuda..SP_BUSCA_FECHA_HABIL @fc_proceso , 2 , @lbtr48 OUTPUT

   IF @Sistema = 'SPT'
   BEGIN
      SELECT 'Banco_emisor'    = 'CORPBANCA'
      ,      'codswift_emi'    = isnull((SELECT DISTINCT codigo_swift FROM BACPARAMSUDA..CORRESPONSAL WHERE rut_cliente = @Rutprop AND codigo_moneda = 999),'')
      ,      'Banco_receptor'  = isnull(MONOMCLI,'')
      ,      'codswift_recep'  = isnull((SELECT DISTINCT codigo_swift FROM BACPARAMSUDA..CORRESPONSAL WHERE rut_cliente = morutcli AND codigo_moneda = 999),'')
      ,      'ref_transaccion' = CASE WHEN motipope = 'C' THEN 'CSPT' ELSE 'VSPT' END + ' ' + CONVERT(CHAR(10),monumope)
      ,      'moneda_prestamo' = mocodmon
      ,      'moneda_pagos'    = 'CLP'
      ,      'capital'         = momonmo
      ,      'interes'         = moticam
      ,      'monto a pagar'   = momonpe
      ,      'tasa'            = 0
      ,      'fecha_inicio'    = CASE WHEN motipope = 'C' THEN CONVERT(CHAR(10),movaluta1,103) ELSE CONVERT(CHAR(10),movaluta2,103) END
      ,      'fecha_vcto'      = CASE WHEN motipope = 'C' THEN CONVERT(CHAR(10),movaluta2,103) ELSE CONVERT(CHAR(10),movaluta1,103) END
      ,      'hora'            = mohora
      ,      'personas'        = isnull(usr.nombre,'')
      ,      'renuncia'        = 'S'
      ,      'Fecha_Impresion' = convert(char(10),acfecpro,103)
      ,      'Hora_Impresion'  = convert(char(5),GETDATE(),108)
      ,      'sistema_pago'    = fpag.glosa
      ,      'valuta'	       = fpag.glosa
      FROM   MEMO
             LEFT JOIN BacParamSuda..FORMA_DE_PAGO fpag ON fpag.codigo = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
             LEFT JOIN BacParamSuda..USUARIO       usr  ON usr.usuario = mooper
      ,      MEAC
      WHERE  monumope         = @Numero
      AND   (motipope         = 'V' OR motipope  = 'C')
      AND    moestatus       <> 'A'
   END

END

GO
