USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_MONTO_FORMATEADO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RETORNA_MONTO_FORMATEADO] ( @nMonto  NUMERIC(19,4) ,
      @dec  INTEGER  ,
      @cMontoFMT CHAR(20) OUTPUT )
as
begin
 IF @nMonto =0
 BEGIN
  SELECT @cMontoFMT = ''
  RETURN
 END
 DECLARE @nLargo  INTEGER
 DECLARE @MntFormato CHAR(1) 
 SELECT @cMontoFMT = CASE @dec WHEN 0 THEN CONVERT(CHAR,CONVERT(NUMERIC(19,0),@nMonto))
     WHEN 2 THEN CONVERT(CHAR,CONVERT(NUMERIC(19,2),@nMonto))
     WHEN 4 THEN CONVERT(CHAR,CONVERT(NUMERIC(19,4),@nMonto))
     ELSE      CONVERT(CHAR,CONVERT(NUMERIC(19,0),@nMonto))
     END
-- SELECT @nLargo = DATALENGTH(LTRIM(RTRIM(@cMontoFMT)))
 IF @dec = 0
  SELECT @nLargo  = DATALENGTH(LTRIM(RTRIM(@cMontoFMT)))
 ELSE
  SELECT @nLargo  = DATALENGTH(SUBSTRING(@cMontoFMT,1,CHARINDEX('.',@cMontoFMT)-1))
 IF @dec <> 0
  SELECT @cMontoFMT = STUFF(@cMontoFMT,CHARINDEX('.',@cMontoFMT),1,',')
 WHILE @nLargo-3>0
 BEGIN 
  SELECT @MntFormato = SUBSTRING(@cMontoFMT,@nLargo-3,1)
  IF @MntFormato<>''
   SELECT @cMontoFMT = STUFF(@cMontoFMT, @nLargo-3 ,1 , @MntFormato +'.')
  SELECT @nLargo = DATALENGTH(SUBSTRING(@cMontoFMT,1,CHARINDEX('.',@cMontoFMT)-1))
 END
end

GO
