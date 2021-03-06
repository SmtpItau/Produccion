USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHECKIN]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CHECKIN]
   (   @DCV_FileName   VARCHAR(15)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @IdArchivo   SMALLINT
       SET @IdArchivo   = -1
       SET @IdArchivo   = ISNULL((SELECT MAX( IdArchivo ) 
                                    FROM TBL_ARCHIVOS 
                                   WHERE NombreLogico   LIKE LTRIM(RTRIM( @DCV_FileName )) + '%' ), -1)

   DECLARE @Status      VARCHAR(5)
       SET @Status      = 'True'

   IF @IdArchivo  = -1
      SET @Status = 'False'

   SELECT Status  = @Status
      ,   Code    = @IdArchivo

END

GO
