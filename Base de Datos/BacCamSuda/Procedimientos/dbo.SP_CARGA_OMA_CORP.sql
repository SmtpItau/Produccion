USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_OMA_CORP]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_OMA_CORP]( @TipoOpe CHAR(1) )
AS
BEGIN
   SELECT codi_opera
         ,conc_opera
         ,op_concep
         ,codi_oma
         ,codigo_OMA
         ,comercio
         ,concepto
    FROM  TBOMADELSUDA
   WHERE op_concep=@TipoOpe OR op_concep = ''
END

GO
