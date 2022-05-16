USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_OMA_SUDA]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_OMA_SUDA]( @TipoOpe CHAR(1) )
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
