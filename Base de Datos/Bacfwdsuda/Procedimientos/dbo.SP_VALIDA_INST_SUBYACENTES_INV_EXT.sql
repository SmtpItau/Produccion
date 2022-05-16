USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_INST_SUBYACENTES_INV_EXT]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VALIDA_INST_SUBYACENTES_INV_EXT]
   (   @SerieBursatil   VARCHAR(20)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iFound INTEGER
   SELECT  @iFound = -1

   SELECT  @iFound = 0
   FROM    INSTRUMENTOS_SUBYACENTES_INV_EXT
   WHERE   cod_nemo   = @SerieBursatil

   SELECT @iFound

END


-- select * from INSTRUMENTOS_SUBYACENTES_INV_EXT

GO
