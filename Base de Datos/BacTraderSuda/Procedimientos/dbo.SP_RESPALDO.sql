USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESPALDO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RESPALDO]
   (@dFechoy DATETIME ,
   @cOpcion CHAR (03))
AS
BEGIN
set nocount on
 DECLARE @dFecborra DATETIME ,
  @nMes  INTEGER  ,
  @nDia  INTEGER  ,
  @cMes  CHAR (02) ,
  @cDia  CHAR (02) ,
  @cStrexec CHAR (255) ,
  @cArcMDAC CHAR (14) ,
  @cArcMDCP CHAR (14) ,
  @cArcMDCI CHAR (14) ,
  @cArcMDVI CHAR (14) ,
  @cArcMDDI CHAR (14) ,
  @cArcMDR1 CHAR (14) ,
  @cArcMDACd CHAR (14) ,
  @cArcMDCPd CHAR (14) ,
  @cArcMDCId CHAR (14) ,
  @cArcMDVId CHAR (14) ,
  @cArcMDDId CHAR (14) ,
  @cArcMDFMd CHAR (14) ,
  @cArcMDR1d CHAR (14) ,
  @cArcMDRS CHAR (14) ,
  @cArcMDFM CHAR (14) ,
  @cArcMDMO CHAR (14) ,
  @cArcMDCO CHAR (14) ,
  @cArcVIEW_NOSERIE CHAR (14) ,
  @cArcMDCV CHAR (14) ,
  @cArcPTW CHAR (14) ,
  @cArcTRD CHAR (14) ,
  @cArcBTW CHAR (14) ,
  @cArcD3  CHAR (14)
 SELECT @nMes  = 0  ,
  @nDia  = 0  ,
  @cMes  = ''  ,
  @cDia  = ''  ,
  @cStrexec = ''  ,
  @cArcMDAC = ''  ,
  @cArcMDCP = ''  ,
  @cArcMDCI = ''  ,
  @cArcMDVI = ''  ,
  @cArcMDDI = ''  ,
  @cArcMDR1 = ''  ,
  @cArcMDACd = ''  ,
  @cArcMDCPd = ''  ,
  @cArcMDCId = ''  ,
  @cArcMDVId = ''  ,
  @cArcMDDId = ''  ,
  @cArcMDFMd = ''  ,
  @cArcMDR1d = ''  ,
  @cArcMDRS = ''  ,
  @cArcMDFM = ''  ,
  @cArcMDMO = ''  ,
  @cArcMDCO = ''  ,
  @cArcVIEW_NOSERIE = ''  ,
  @cArcMDCV = ''  ,
  @cArcPTW = ''  ,
  @cArcTRD = ''  ,
  @cArcBTW = ''  ,
  @cArcD3  = ''
 SELECT @nMes  = DATEPART(MONTH,@dFechoy) ,
  @nDia  = DATEPART(  DAY,@dFechoy)
 IF @nMes<10
  SELECT @cMes = '0'+CONVERT(CHAR(1),@nMes)
 ELSE
  SELECT @cMes = CONVERT(CHAR(2),@nMes)
 IF @nDia<10
  SELECT @cDia = '0'+CONVERT(CHAR(1),@nDia)
 ELSE
  SELECT @cDia = CONVERT(CHAR(2),@nDia)
 IF @cOpcion='DEV'
  SELECT @cArcMDAC = 'RDEV_MDAC_'+@cMes+@cDia ,
   @cArcMDCP = 'RDEV_MDCP_'+@cMes+@cDia ,
   @cArcMDCI = 'RDEV_MDCI_'+@cMes+@cDia ,
   @cArcMDVI = 'RDEV_MDVI_'+@cMes+@cDia ,
   @cArcMDDI = 'RDEV_MDDI_'+@cMes+@cDia ,
   @cArcMDFM = 'RDEV_MDFM_'+@cMes+@cDia ,
   @cArcMDR1 = 'RDEV_MDR1_'+@cMes+@cDia
 ELSE
  SELECT @cArcMDAC = 'RFIN_MDAC_'+@cMes+@cDia ,
   @cArcMDCP = 'RFIN_MDCP_'+@cMes+@cDia ,
   @cArcMDCI = 'RFIN_MDCI_'+@cMes+@cDia ,
   @cArcMDVI = 'RFIN_MDVI_'+@cMes+@cDia ,
   @cArcMDDI = 'RFIN_MDDI_'+@cMes+@cDia ,
   @cArcMDR1 = 'RFIN_MDR1_'+@cMes+@cDia ,
   @cArcMDRS = 'RFIN_MDRS_'+@cMes+@cDia ,
   @cArcMDFM = 'RFIN_MDFM_'+@cMes+@cDia ,
   @cArcMDMO = 'RFIN_MDMO_'+@cMes+@cDia ,
   @cArcMDCO = 'RFIN_MDCO_'+@cMes+@cDia ,
   @cArcVIEW_NOSERIE = 'RFIN_VIEW_NOSERIE_'+@cMes+@cDia ,
   @cArcMDCV = 'RFIN_MDCV_'+@cMes+@cDia ,
   @cArcPTW = 'RFIN_PTW_'+@cMes+@cDia ,
   @cArcTRD = 'RFIN_TRD_'+@cMes+@cDia ,
   @cArcBTW = 'RFIN_BTW_'+@cMes+@cDia ,
   @cArcD3  = 'RES_INFD3_'+@cMes+@cDia
 
 SELECT @cStrexec  = 'SELECT * INTO '+@cArcMDAC+' FROM MDAC'
 IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDAC)
 BEGIN
  EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcMDAC+' TO PUBLIC'
  EXECUTE (@cStrexec)
 END
 SELECT @cStrexec  = 'SELECT * INTO '+@cArcMDCP+' FROM MDCP'
 IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDCP)
 BEGIN
  EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcMDCP+' TO PUBLIC'
  EXECUTE (@cStrexec)
 END
 SELECT @cStrexec  = 'SELECT * INTO '+@cArcMDCI+' FROM MDCI'
 IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDCI)
 BEGIN
  EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcMDCI+' TO PUBLIC'
  EXECUTE (@cStrexec)
 END
 SELECT @cStrexec  = 'SELECT * INTO '+@cArcMDVI+' FROM MDVI'
 IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDVI)
 BEGIN
  EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcMDVI+' TO PUBLIC'
  EXECUTE (@cStrexec)
 END
 SELECT @cStrexec  = 'SELECT * INTO '+@cArcMDDI+' FROM MDDI'
 IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDDI)
 BEGIN
  EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcMDDI+' TO PUBLIC'
  EXECUTE (@cStrexec)
 END
 SELECT @cStrexec  = 'SELECT * INTO '+@cArcMDFM+' FROM MDFM'
 IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDFM)
 BEGIN
  EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcMDFM+' TO PUBLIC'
  EXECUTE (@cStrexec)
 END
 SELECT @cStrexec  = 'SELECT * INTO '+@cArcMDR1+' FROM MDRS1'
 IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDR1)
 BEGIN
  EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcMDR1+' TO PUBLIC'
  EXECUTE (@cStrexec)
 END
 IF @cOpcion='FIN'
 BEGIN
  SELECT @cStrexec  = 'SELECT * INTO '+@cArcMDRS+' FROM MDRS'
  IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDRS)
  BEGIN
   EXECUTE (@cStrexec)
   SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcMDRS+' TO PUBLIC'
   EXECUTE (@cStrexec)
  END
  SELECT @cStrexec  = 'SELECT * INTO '+@cArcMDFM+' FROM MDFM'
  IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDFM)
  BEGIN
   EXECUTE (@cStrexec)
   SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcMDFM+' TO PUBLIC'
   EXECUTE (@cStrexec)
  END
  SELECT @cStrexec  = 'SELECT * INTO '+@cArcMDMO+' FROM MDMO'
  IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDMO)
  BEGIN
   EXECUTE (@cStrexec)
   SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcMDMO+' TO PUBLIC'
   EXECUTE (@cStrexec)
  END
  SELECT @cStrexec  = 'SELECT * INTO '+@cArcMDCO+' FROM MDCO'
  IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDCO)
  BEGIN
   EXECUTE (@cStrexec)
   SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcMDCO+' TO PUBLIC'
   EXECUTE (@cStrexec)
  END
  SELECT @cStrexec  = 'SELECT * INTO '+@cArcMDCV+' FROM MDCV'
  IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDCV)
  BEGIN
   EXECUTE (@cStrexec)
   SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcMDCV+' TO PUBLIC'
   EXECUTE (@cStrexec)
  END
  SELECT @cStrexec  = 'SELECT * INTO '+@cArcVIEW_NOSERIE+' FROM VIEW_NOSERIE'
  IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcVIEW_NOSERIE)
  BEGIN
   EXECUTE (@cStrexec)
   SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcVIEW_NOSERIE+' TO PUBLIC'
   EXECUTE (@cStrexec)
  END
  SELECT @cStrexec  = 'SELECT * INTO '+@cArcPTW+' FROM MDPTW'
  IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcPTW)
  BEGIN
   EXECUTE (@cStrexec)
--   SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcPTW+' TO PUBLIC'
--   EXECUTE (@cStrexec)
  END
  SELECT @cStrexec  = 'SELECT * INTO '+@cArcTRD+' FROM TRDMOVA'
  IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcTRD)
  BEGIN
   EXECUTE (@cStrexec)
   SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcTRD+' TO PUBLIC'
   EXECUTE (@cStrexec)
  END
  SELECT @cStrexec  = 'SELECT * INTO '+@cArcBTW+' FROM BTWGARA'
  IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcBTW)
  BEGIN
   EXECUTE (@cStrexec)
   SELECT @cStrexec  = 'GRANT SELECT ON '+@cArcBTW+' TO PUBLIC'
   EXECUTE (@cStrexec)
  END
  SELECT @dFecborra = DATEADD(DAY,-7,@dFechoy)
  SELECT @nMes  = DATEPART(MONTH,@dFecborra) ,
   @nDia  = DATEPART(  DAY,@dFecborra)
  IF @nMes<10
   SELECT @cMes = '0'+CONVERT(CHAR(1),@nMes)
  ELSE
   SELECT @cMes = CONVERT(CHAR(2),@nMes)
  IF @nDia<10
   SELECT @cDia = '0'+CONVERT(CHAR(1),@nDia)
  ELSE
   SELECT @cDia = CONVERT(CHAR(2),@nDia)
  SELECT @cArcMDACd = 'RDEV_MDAC_'+@cMes+@cDia ,
   @cArcMDCPd = 'RDEV_MDCP_'+@cMes+@cDia ,
   @cArcMDCId = 'RDEV_MDCI_'+@cMes+@cDia ,
   @cArcMDVId = 'RDEV_MDVI_'+@cMes+@cDia ,
   @cArcMDDId = 'RDEV_MDDI_'+@cMes+@cDia ,
   @cArcMDFMd = 'RDEV_MDFM_'+@cMes+@cDia ,
   @cArcMDR1d = 'RDEV_MDR1_'+@cMes+@cDia ,
   @cArcMDAC = 'RFIN_MDAC_'+@cMes+@cDia ,
   @cArcMDCP = 'RFIN_MDCP_'+@cMes+@cDia ,
   @cArcMDCI = 'RFIN_MDCI_'+@cMes+@cDia ,
   @cArcMDVI = 'RFIN_MDVI_'+@cMes+@cDia ,
   @cArcMDDI = 'RFIN_MDDI_'+@cMes+@cDia ,
   @cArcMDR1 = 'RFIN_MDR1_'+@cMes+@cDia ,
   @cArcMDRS = 'RFIN_MDRS_'+@cMes+@cDia ,
   @cArcMDFM = 'RFIN_MDFM_'+@cMes+@cDia ,
   @cArcMDMO = 'RFIN_MDMO_'+@cMes+@cDia ,
   @cArcMDCO = 'RFIN_MDCO_'+@cMes+@cDia ,
   @cArcVIEW_NOSERIE = 'RFIN_VIEW_NOSERIE_'+@cMes+@cDia ,
   @cArcMDCV = 'RFIN_MDCV_'+@cMes+@cDia ,
   @cArcPTW = 'RFIN_PTW_'+@cMes+@cDia ,
   @cArcTRD = 'RFIN_TRD_'+@cMes+@cDia ,
   @cArcBTW = 'RFIN_BTW_'+@cMes+@cDia ,
   @cArcD3  = 'RES_INFD3_'+@cMes+@cDia
  --** Borra Respaldo Devengamiento **-- 
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDACd
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDACd)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDCPd
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDCPd)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDCId
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDCId)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDVId
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDVId)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDDId
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDDId)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDFMd
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDFMd)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDR1d
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDR1d)
   EXECUTE (@cStrexec)
  --** Borra Respaldo Fin de D¡a **-- 
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDAC
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDAC)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDCP
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDCP)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDCI
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDCI)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDVI
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDVI)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDDI
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDDI)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDR1
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDR1)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDRS
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDRS)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDFM
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDFM)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDMO
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDMO)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDCO
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDCO)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcMDCV
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcMDCV)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcVIEW_NOSERIE
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcVIEW_NOSERIE)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcPTW
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcPTW)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcTRD
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcTRD)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcBTW
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcBTW)
   EXECUTE (@cStrexec)
  SELECT @cStrexec  = 'DROP TABLE '+@cArcD3
  IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArcD3)
   EXECUTE (@cStrexec)
 END
SELECT 'OK'
set nocount off 
END

GO
