USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VOLVER_SW]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE  [dbo].[SP_VOLVER_SW](@PROCESO CHAR(10),
     @PROXIMO CHAR(10),
     @ANTERIOR CHAR(10))
AS
BEGIN
SET NOCOUNT ON
 UPDATE MDAC SET acsw_pd = 0 ,
          acsw_dv = 0,
   acsw_cm = 1,
   acsw_fd = 1,
          acsw_dvprop= 0 ,
   acsw_dvci   = 0,
   acsw_dvvi   = 0,
   acsw_dvib   = 0,
   acfecproc  = @PROCESO,
   acfecprox  = @PROXIMO,
   acfecante  = @ANTERIOR
 SELECT 'OK'
SET NOCOUNT OFF
END 


GO
