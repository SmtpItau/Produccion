USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[QRY_CONSULTA_RESULTADO_MESA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[QRY_CONSULTA_RESULTADO_MESA]
   (   @dFechaProceso   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT Fecha             = mofecpro
   ,      Documento         = monumdocu
   ,      Correlativo       = mocorrela
   ,      Operacion         = motipoper
   ,      Cliente           = clnombre
   ,      Serie             = moinstser
   ,      Nominal           = monominal
   ,      Tasa              = motir
   ,      vPresente         = movpresen
   ,      TasaTransferencia = moTirTran
   ,      vPresentetTrans   = moVPTran
   ,      Resultado         = moDifTran_MO
   ,      Resultado_Pesos   = moDifTran_CLP
   ,      Financiera        = Fin.tbglosa
   ,      Normativa         = Nor.tbglosa
   FROM   BacTraderSuda.dbo.MDMO mov                           with(nolock)
          LEFT JOIN BacParamSuda.dbo.CLIENTE               cli with(nolock) ON cli.clrut = morutcli and cli.clcodigo = mocodcli
          LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Fin with(nolock) ON Fin.tbcateg = 204  and Fin.tbcodigo1 = Tipo_Cartera_Financiera
          LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Nor with(nolock) ON Nor.tbcateg = 1111 and Nor.tbcodigo1 = codigo_carterasuper
   WHERE  mostatreg         = ''

   UNION

   SELECT Fecha             = mofecpro
   ,      Documento         = monumdocu
   ,      Correlativo       = mocorrela
   ,      Operacion         = motipoper
   ,      Cliente           = clnombre
   ,      Serie             = moinstser
   ,      Nominal           = monominal
   ,      Tasa              = motir
   ,      vPresente         = movpresen
   ,      TasaTransferencia = moTirTran
   ,      vPresentetTrans   = moVPTran
   ,      Resultado         = moDifTran_MO
   ,      Resultado_Pesos   = moDifTran_CLP
   ,      Financiera        = Fin.tbglosa
   ,      Normativa         = Nor.tbglosa
   FROM   BacTraderSuda.dbo.MDMOH mov                          with(nolock)
          LEFT JOIN BacParamSuda.dbo.CLIENTE               cli with(nolock) ON cli.clrut = morutcli and cli.clcodigo = mocodcli
          LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Fin with(nolock) ON Fin.tbcateg = 204  and Fin.tbcodigo1 = Tipo_Cartera_Financiera
          LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Nor with(nolock) ON Nor.tbcateg = 1111 and Nor.tbcodigo1 = codigo_carterasuper
   WHERE  mostatreg         = ''
      AND mofecpro          = @dFechaProceso
   ORDER BY mofecpro, monumdocu, mocorrela

END



GO
