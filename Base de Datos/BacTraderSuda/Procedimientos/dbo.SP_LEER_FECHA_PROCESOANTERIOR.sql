USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_FECHA_PROCESOANTERIOR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEER_FECHA_PROCESOANTERIOR]
   (
          @fecha  DATETIME
   )
AS
BEGIN
 SET NOCOUNT ON
 SELECT DISTINCT rsfecha,rsfecprox,rsfecctb
 INTO #temp1
 FROM MDRS
 SELECT  CONVERT(CHAR(10),rsfecctb,112)
 FROM    #temp1
 WHERE   rsfecha = @fecha
 SET NOCOUNT OFF
END


GO
