USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FORMATOBNS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FORMATOBNS]
AS
BEGIN
SET NOCOUNT ON
DECLARE @ACNOMPROP  CHAR(40)
DECLARE @ACFECPROC  CHAR(10)
DECLARE @ACRUTPROP NUMERIC (9)
DECLARE @ACDIGPROP      CHAR(1)
SELECT 
 @ACNOMPROP = acnomprop,
 @ACFECPROC = acfecproc,
 @ACRUTPROP = acrutprop,
 @ACDIGPROP = acdigprop
  FROM MDAC               
 SELECT  *,'ENIDAD' = @ACNOMPROP FROM FormatoBNS ORDER BY RutEmisor, CuentaBSA
 SET NOCOUNT OFF
END
-- select * from FormatoBNS
-- select * from cartera_cuenta where t_operacion = 'VI' AND Variable = 'valor_compra'
-- select * from cartera_cuenta where t_operacion = 'CP' AND Variable = 'valor_compra'
-- select * from mdcp
-- select * from mdvi
/*create table #n (n float)
declare @n  float
insert #n  values( 284876549139500.000000)
select * from #n*/
-- sp_Buscador_de_cuentas
-- sp_help
-- update mdcp set cpinstser = 'SUD040 *01' where cpinstser = 'SUD040*01'

GO
