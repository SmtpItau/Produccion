USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_ESTADO_REGLA]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACT_ESTADO_REGLA]
   (   @nNumero_Regla   NUMERIC(10)
   ,   @iEstado         CHAR(01)
   )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   UPDATE REGLA_MENSAJE
   SET    estado       = @iEstado
   WHERE  numero_regla = @nNumero_Regla

END


GO
