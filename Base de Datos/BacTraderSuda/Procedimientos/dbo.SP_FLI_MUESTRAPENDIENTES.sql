USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLI_MUESTRAPENDIENTES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FLI_MUESTRAPENDIENTES]
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFecha   DATETIME
       SET @dFecha   = (SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )

   SELECT mo.monumoper, mo.monumdocu, mo.mocorrela, pendiente = CASE WHEN ISNULL(pa.panumoper,0) > 0 THEN 'N' ELSE 'S' END
     FROM BacTraderSuda.dbo.MDMO                mo with(nolock)
          LEFT JOIN BacTraderSuda.dbo.PAGOS_FLI pa with(nolock) ON pa.pafecpro = @dFecha and pa.panumoper = mo.monumoper and pa.panumdocu = mo.monumdocu and pa.pacorrela = mo.mocorrela
    WHERE mo.mofecpro  = @dFecha
      AND mo.motipoper = 'FLI'

   SELECT * FROM BacTraderSuda.dbo.PAGOS_FLI    

END


GO
