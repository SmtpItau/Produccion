USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROLCIERREMESA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROLCIERREMESA]
AS
BEGIN
      SET NOCOUNT ON
            SELECT 
            'BLOQUEO DE OPERACIONES'    = ACsw_mesa +'-BLOQUEO DE OPERACIONES'   -- bloquear operaciones
            FROM MDAC
      SET NOCOUNT OFF
END


GO
