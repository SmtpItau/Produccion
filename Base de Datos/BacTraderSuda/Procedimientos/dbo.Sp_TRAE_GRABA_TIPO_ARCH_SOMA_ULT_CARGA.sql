USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TRAE_GRABA_TIPO_ARCH_SOMA_ULT_CARGA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_TRAE_GRABA_TIPO_ARCH_SOMA_ULT_CARGA]
     ( @Evento           NUMERIC(01,0),
       @TipoArchivoSOMA  NUMERIC(01,0) = 0
     ) 
AS
BEGIN

  SET NOCOUNT ON

    IF @Evento = 1 
      UPDATE MDAC
      SET  acTipArchUltCargaSOMA = @TipoArchivoSOMA
    ELSE 
      SELECT acTipArchUltCargaSOMA FROM MDAC

END

GO
