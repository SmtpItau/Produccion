USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONDATOSOPERACION]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CONDATOSOPERACION]
   (   @Id_Sistema   VARCHAR(5)
   ,   @nContrato    NUMERIC(9)
   )
AS
BEGIN

   --> Proceso Regenerado por Error en Anulacion de Anticipos. continuidad operativa

   SET NOCOUNT ON

   IF @Id_Sistema = 'BFW'
   BEGIN
      SELECT Id_sistema = 'BFW', Rut = cacodigo, Codigo = cacodcli, Posicion = CaCodPos1
        FROM BacFwdSuda.dbo.MFCA with(nolock)
       WHERE canumoper = @nContrato
   END

END

GO
