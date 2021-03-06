USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDAPLEERRUT]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDAPLEERRUT]
       (
        @nrutcli     NUMERIC(9,0)  ,   -- RUT Cliente
        @ncodcli     NUMERIC(9,0)      -- Codigo Cliente 
       )
AS
BEGIN
   SET NOCOUNT ON
   SELECT       aprutapo          ,
                apdvapo           ,
                apnombre   ,
  apcargo    ,
  apfono
          FROM  VIEW_CLIENTE_APODERADO
          WHERE aprutcli = @nrutcli and apcodcli= @ncodcli
   
   SET NOCOUNT OFF
END

GO
