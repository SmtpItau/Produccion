USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[RETORNA_CLIENTES]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[RETORNA_CLIENTES]
AS
BEGIN

   SELECT 1, 1, ''
RETURN

   SET NOCOUNT ON

   SELECT DISTINCT
          cacodigo
   ,      cacodcli
   ,      clnombre
   FROM   BacfwdSuda..MFCA
          INNER JOIN BacParamSuda..CLIENTE ON clrut = cacodigo AND clcodigo = cacodcli
   ORDER BY cacodigo, cacodcli

END


GO
