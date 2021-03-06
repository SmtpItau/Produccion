USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_OPERACIONES_FLI]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_OPERACIONES_FLI]
AS
BEGIN

  SET NOCOUNT ON
  IF EXISTS(SELECT 1 FROM MDMO WITH (NOLOCK), MDVI WITH (NOLOCK) WHERE MONUMOPER = VINUMOPER AND MOTIPOPER = 'FLI')
   BEGIN
      SELECT -1, 'No se puede ejecutar el proceso, debido a que existen Operaciones FLI pendientes'
      RETURN
   END

   /*
   IF EXISTS(SELECT 1 FROM MDMO WITH (NOLOCK) WHERE MOTIPOPER = 'VFM' AND MOPVP = 0.0)
   BEGIN
      SELECT -1, 'No se puede ejecutar el proceso, debido a que no ha liquidado Cuotas FM'
      RETURN
   END
   */

   SELECT 0, 'OK'

END


GO
