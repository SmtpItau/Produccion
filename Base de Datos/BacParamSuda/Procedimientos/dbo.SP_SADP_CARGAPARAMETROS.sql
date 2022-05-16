USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_CARGAPARAMETROS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_CARGAPARAMETROS]
AS
BEGIN

   SET NOCOUNT ON

   SELECT acnomprop
      ,   acfecproc
     FROM BacTraderSuda.dbo.MDAC with(nolock)

END 
GO
