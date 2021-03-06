USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FRMLETRASHIPOTECARIAS_GRABA_ELIMINA_CORTES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FRMLETRASHIPOTECARIAS_GRABA_ELIMINA_CORTES]
            (
            @codigo_planilla      NUMERIC(10)
            )
AS
BEGIN
      SET NOCOUNT ON
            DELETE FROM LETRA_HIPOTECARIA_CORTE WHERE codigo_planilla = @codigo_planilla
      SET NOCOUNT OFF
END

GO
