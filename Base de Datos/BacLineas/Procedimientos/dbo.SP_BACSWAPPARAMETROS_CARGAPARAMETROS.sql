USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACSWAPPARAMETROS_CARGAPARAMETROS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BACSWAPPARAMETROS_CARGAPARAMETROS    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_BACSWAPPARAMETROS_CARGAPARAMETROS    fecha de la secuencia de comandos: 14/02/2001 09:58:22 ******/
CREATE PROCEDURE [dbo].[SP_BACSWAPPARAMETROS_CARGAPARAMETROS]
AS
BEGIN
   SET NOCOUNT ON
   SELECT 
         CONVERT(CHAR(10),acfecproc,103), 
         acnomprop,
         CONVERT(CHAR(10),acfecprox,103),
         acrutprop, 
         acdigprop,
         acrutcomi,
         accomision,
         aciva 
   FROM 
         VIEW_MDAC
  
   SET NOCOUNT OFF
END
GO
