USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_INSTRUMENTOS_SUBYACENTES]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VALIDA_INSTRUMENTOS_SUBYACENTES]
   (   @SerieBursatil   VARCHAR(20)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iFound INTEGER
   SELECT  @iFound = -1

   SELECT  @iFound = 0
   FROM    INSTRUMENTOS_SUBYACENTES
   WHERE   Serie   = @SerieBursatil

   SELECT @iFound

END


GO
