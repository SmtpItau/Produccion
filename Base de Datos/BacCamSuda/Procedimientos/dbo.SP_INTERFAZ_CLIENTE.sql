USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_CLIENTE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_CLIENTE]
AS
BEGIN
 SET NOCOUNT ON
 SELECT  rut = rtrim(convert(char(9),clrut)) + cldv,
  nombre = substring(ltrim(clnombre),1,50),
--  regcom = rtrim(isnull(clregion,'0')) + ltrim(isnull(clcomuna,'0')),
  region = ISNULL(clregion,'0'),
  comuna = ISNULL(clcomuna,'0'),
  sw = 'N',
  rutreal = clrut
 INTO #temp1
 FROM VIEW_CLIENTE
 WHERE clrut <> 97018000
 
 UPDATE #temp1 SET sw = 'S' FROM mdcp, view_noserie where cpseriado = 'N' and cpnumdocu = nsnumdocu and cpcorrela = nscorrela and nsrutemi = rutreal
 UPDATE #temp1 SET sw = 'S' FROM mdcp, view_serie where cpseriado = 'S' and semascara = cpmascara and serutemi = rutreal
 UPDATE #temp1 SET sw = 'S' FROM mdci where cirutcli = rutreal
 UPDATE #temp1 SET sw = 'S' FROM mdvi where virutcli = rutreal
 UPDATE #temp1 SET sw = 'S' FROM mdmo where morutemi = rutreal
 UPDATE #temp1 SET sw = 'S' FROM mdmo where morutcli = rutreal
 SELECT  rut ,
  nombre ,
  region ,
  comuna
 FROM #temp1
 WHERE sw = 'S'
 SET NOCOUNT OFF
END

GO
