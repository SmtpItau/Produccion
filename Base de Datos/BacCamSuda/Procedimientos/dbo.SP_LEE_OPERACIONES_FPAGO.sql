USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_OPERACIONES_FPAGO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_LEE_OPERACIONES_FPAGO]
   (   @Usuario   VARCHAR(15)   )
AS
BEGIN 

   SET NOCOUNT ON

   DECLARE @xTipoUsuario   CHAR(15)
       SET @xTipoUsuario   = ( SELECT tipo_usuario FROM BacParamSuda.dbo.USUARIO with(nolock) WHERE usuario = @Usuario)

   IF @xTipoUsuario = 'DIGITADOR'
      SET @xTipoUsuario = 'TRADER'

      SELECT NumeroOperacion  = operac.monumope
           , RutCliente       = operac.morutcli
           , CodCliente       = operac.mocodcli
           , NomCliente       = operac.monomcli
           , TipOperacion     = operac.motipope
           , MonOperacion     = operac.mocodmon
           , MonConversion    = operac.mocodcnv
           , Monto            = operac.momonmo
           , Dolarres         = operac.moussme
           , Precio           = operac.moticam
           , Pesos            = operac.momonpe
           , FpagoEntregamios = Entre.glosa -->  operac.moentre
           , ValutaEntregamos = operac.movaluta1
           , FpagoRecibimos   = Recib.glosa -->  operac.morecib
           , ValutaRecibimos  = operac.movaluta2
           , CodMonedaOpe     = mon1.mncodmon
           , CodMonedaCnv     = mon2.mncodmon
           , CodFPagoEntre    = Entre.codigo
           , CodFPagoRecib    = Recib.codigo
        FROM BacCamSuda.dbo.MEMO                       operac with(nolock) 
             INNER JOIN BacParamSuda.dbo.USUARIO       tipusr with(nolock) ON tipusr.usuario = operac.mooper
             INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO Entre  with(nolock) ON Entre.codigo   = operac.moentre
             INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO Recib  with(nolock) ON Recib.codigo   = operac.morecib
             INNER JOIN BacParamSuda.dbo.MONEDA        mon1   with(nolock) ON mon1.mnnemo    = operac.mocodmon
             INNER JOIN BacParamSuda.dbo.MONEDA        mon2   with(nolock) ON mon2.mnnemo    = operac.mocodcnv
       WHERE tipusr.tipo_usuario = @xTipoUsuario
     ORDER BY operac.morutcli, operac.monumope

END



GO
