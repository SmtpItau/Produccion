USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_CLIENTE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEE_CLIENTE]
       (
        @nrutcli     NUMERIC(9,0)  ,   -- RUT Cliente
        @ncodcli     NUMERIC(9,0)      -- Codigo Cliente 
       )
AS
BEGIN
   SET NOCOUNT ON
      SELECT a.*,b.cltipcli 
        FROM view_cliente_apoderado  a
            ,view_cliente            b
       WHERE aprutcli = Clrut     AND 
             aprutcli = @nrutcli  AND
             Clrut    = @nrutcli  AND
             Clcodigo = @ncodcli 
   
   SET NOCOUNT OFF
END






GO
