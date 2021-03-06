USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACSWAPPARAMETROS_CARGAPARAMETROS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
         aciva, 
         CONVERT(CHAR(10),acfecante,103)            
   FROM  VIEW_MDAC with (nolock)
  

END
GO
