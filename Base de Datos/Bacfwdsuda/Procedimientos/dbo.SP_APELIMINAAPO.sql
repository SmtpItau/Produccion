USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_APELIMINAAPO]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_APELIMINAAPO]
       (
        @nrutcli     NUMERIC(9,0)   ,  -- RUT Cliente
        @ncodcli     NUMERIC(9,0)      -- codigo Cliente
       )
AS
BEGIN
Set NoCount On
   /*=======================================================================*/
   /*=======================================================================*/
   DECLARE @nerror   INTEGER
   /*=======================================================================*/
   /*=======================================================================*/
    DELETE FROM VIEW_CLIENTE_APODERADO WHERE aprutcli = @nrutcli  and apcodcli = @ncodcli
    Select  0
   SET NOCOUNT OFF
END

GO
