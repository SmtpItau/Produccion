USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_APODERADOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_APODERADOS]
   (   @nRut      NUMERIC(9)
   ,   @nCodigo   INTEGER
   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT RutCliente   = cli.clrut
      ,   DigCliente   = cli.cldv
      ,   CodCliente   = cli.clcodigo
      ,   NomCliente   = cli.clnombre
      ,   NomApoderado = ISNULL( apo.apnombre, 'SIN INFORMACION')
      ,   RutApoderado = ISNULL( apo.aprutapo, 0)
      ,   DigApoderado = ISNULL( apo.apdvapo,  '')
      ,   DomCliente   = cli.Cldirecc
     FROM BacParamSuda.dbo.CLIENTE                     cli with(nolock)
          LEFT JOIN BacParamSuda.dbo.CLIENTE_APODERADO apo with(nolock) ON cli.clrut = apo.aprutcli
    WHERE cli.clrut    = @nRut
      AND cli.clcodigo = @nCodigo
  GROUP BY cli.clrut, cli.cldv, cli.clcodigo, cli.clnombre, cli.Cldirecc, apo.apnombre, apo.aprutapo, apo.apdvapo
  ORDER BY apo.apnombre



END


GO
