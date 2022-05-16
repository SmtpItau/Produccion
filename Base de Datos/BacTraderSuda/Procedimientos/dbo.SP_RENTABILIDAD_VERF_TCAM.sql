USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTABILIDAD_VERF_TCAM]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RENTABILIDAD_VERF_TCAM]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @dfecproc  DATETIME ,
  @nTasaCam FLOAT
 SELECT @dfecproc = acfecproc
 FROM mdac
 SELECT  @nTasaCam = 0
 SELECT  @nTasaCam = vmvalor
 FROM  view_valor_moneda
 WHERE vmcodigo = 8
 AND vmfecha = @dfecproc
 IF @nTasaCam = 0
  SELECT 'NO'
 ELSE
  SELECT 'SI'
 SET NOCOUNT OFF
END
-- SELECT * FROM renta_cp
-- SELECT * FROM renta_resumen
-- select * from mdcp where cpforpagi=8
-- select rstipoper,* from mdrs where rscartera = '121'
-- select * from  view_instrumento
-- select * from  view_forma_de_pago
-- sp_help mdcp

GO
