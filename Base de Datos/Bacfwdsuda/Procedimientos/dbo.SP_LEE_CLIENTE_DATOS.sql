USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_CLIENTE_DATOS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_CLIENTE_DATOS]
       (
        @nrutcli     NUMERIC(9,0)  ,   -- RUT Cliente
        @ncodcli     NUMERIC(9,0)      -- Codigo Cliente 
       )
AS
BEGIN
   SET NOCOUNT ON
  select * from  view_cliente_apoderado where aprutcli=  @nrutcli
   
   SET NOCOUNT OFF
END

GO
