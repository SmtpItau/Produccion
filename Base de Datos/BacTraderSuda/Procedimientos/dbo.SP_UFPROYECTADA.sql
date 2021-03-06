USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_UFPROYECTADA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_UFPROYECTADA]( @dFecVen DATETIME     , -- Fecha de Vencimiento
      @ValUFFecVcto FLOAT OUTPUT )
AS 
BEGIN
   SET NOCOUNT ON
   DECLARE @Retorna CHAR(1)
 IF @ValUFFecVcto = -1
    SELECT @Retorna = 'N'
 ELSE
    SELECT @Retorna = 'S'
 SELECT @ValUFFecVcto = 0
 
 SELECT  @ValUFFecVcto = vmvalor FROM VIEW_VALOR_MONEDA
         WHERE vmfecha = @dFecVen AND vmcodigo = 998
 IF @ValUFFecVcto = 0 BEGIN
  -- Calcula U.F. Proyectada
  DECLARE @Dia   NUMERIC(2,0)
  DECLARE @Mes  NUMERIC(2,0)
  DECLARE @Ano   NUMERIC(4,0)
  DECLARE @FecCal  DATETIME 
  DECLARE @FechaCal     DATETIME
  DECLARE @ValorUF    NUMERIC(12,2)
  DECLARE @ValorIPC   NUMERIC(6,2)
  DECLARE @nMaxDia    NUMERIC(2,0)
  DECLARE @nCanDias   NUMERIC(2,0)
  DECLARE @nDiasCal   FLOAT
  DECLARE @nIPC       FLOAT
  DECLARE @nValIPC    FLOAT
  SELECT @Dia=DATEPART(DAY,@dFecVen)
  SELECT @Mes=DATEPART(MM,@dFecVen)
  SELECT @Ano=DATEPART(YY,@dFecVen) 
  IF @DIA <= 9 BEGIN
   IF @MES = 1 BEGIN
    SELECT @MES=12
    SELECT @ANO= @ANO - 1 
   END ELSE BEGIN
    SELECT @MES=@MES - 1
     
   END
  END 
   
  SELECT @FecCal=CONVERT(DATETIME, '09/' + CONVERT(CHAR(2),@MES) + '/' + CONVERT(CHAR(4),@ANO) )
  SELECT @FECHACAL = ipcfeccal  ,
  @VALORUF  = ipcvaloruf ,
  @VALORIPC = ipcvaloripc FROM MDIPC WHERE CONVERT(CHAR(8),ipcfeccal,102) = CONVERT(CHAR(8),@FecCal,102)
  SELECT @nCanDias = DATEDIFF(DD,@FecCal,@dFecVen)
  SELECT @nMaxDia = 0
  /*=======================================================================*/
  IF  @Mes =  1  BEGIN   SELECT @nMaxDia = 31  END --Enero
  IF  @Mes =  2  BEGIN   SELECT @nMaxDia = 28  END --Febrero
  IF  @Mes =  3  BEGIN   SELECT @nMaxDia = 31  END --Marzo
  IF  @Mes =  4  BEGIN   SELECT @nMaxDia = 30  END --Abril
  IF  @Mes =  5  BEGIN   SELECT @nMaxDia = 31  END --Mayo
  IF  @Mes =  6  BEGIN   SELECT @nMaxDia = 30  END --Junio
  IF  @Mes =  7  BEGIN   SELECT @nMaxDia = 31  END --Julio
  IF  @Mes =  8  BEGIN   SELECT @nMaxDia = 31  END --Agosto
  IF  @Mes =  9  BEGIN   SELECT @nMaxDia = 30  END --Septiembre
  IF  @Mes =  10 BEGIN   SELECT @nMaxDia = 31  END --Octubre
  IF  @Mes =  11 BEGIN   SELECT @nMaxDia = 30  END --Noviembre
  IF  @Mes =  12 BEGIN   SELECT @nMaxDia = 31  END --Diciembre
  /*=======================================================================*/
  SELECT @nIPC = (CONVERT(FLOAT,@VALORIPC)/100) + 1
   
  SELECT @nDiasCal = CONVERT(FLOAT,@nCanDias / @nMaxDia)
  SELECT @nValIPC =  POWER( @nIPC , @nDiasCal )
  SELECT @ValUFFecVcto =  @VALORUF * @nValIPC
 END
 IF @Retorna = 'S'
    SELECT ROUND( @ValUFFecVcto , 4 )
 
   SET NOCOUNT OFF
END

GO
