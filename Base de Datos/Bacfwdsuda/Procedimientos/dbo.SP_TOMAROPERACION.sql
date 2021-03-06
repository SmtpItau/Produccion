USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TOMAROPERACION]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TOMAROPERACION]
       (
        @nnumoper    NUMERIC(10)     ,
        @cusuario    CHAR(10)
       )
AS
BEGIN
   SET NOCOUNT ON
   UPDATE mfmo
   SET    molock = @cusuario
   WHERE  monumoper = @nnumoper
   UPDATE mfmoh
   SET    molock = @cusuario
   WHERE  monumoper = @nnumoper
   UPDATE mfca
   SET    calock = @cusuario
   WHERE  canumoper = @nnumoper
   SET NOCOUNT OFF
   SELECT 0
END

GO
