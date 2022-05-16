USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDOPELIMINAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDOPELIMINAR] 
       (
        @nrutcli     NUMERIC(9,0)    ,  -- RUT Cliente
        @nCodCli     NUMERIC(9,0)      -- Codigo cliente
   )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   DECLARE @nerror   INTEGER
   DELETE FROM VIEW_CLIENTE_OPERADOR WHERE oprutcli = @nrutcli AND opcodcli = @ncodcli 
   SET NOCOUNT OFF
   SELECT 0
END

GO
