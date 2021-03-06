USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_USUSIS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_USUSIS]
AS
BEGIN
 DECLARE @cArchivo VARCHAR (20) ,
  @cBuffer VARCHAR (250) ,
  @cExecute VARCHAR (200) ,
  @User  VARCHAR (100)
 SELECT @User  = 'SP_USUSIS'     
 SELECT @cArchivo = LTRIM(@user)+CONVERT(CHAR(14),GETDATE(),114)
 SELECT @cArchivo = STUFF(@cArchivo,12 ,1,'_')
 SELECT @cArchivo = STUFF(@cArchivo,15,1,'_')
 SELECT @cArchivo = STUFF(@cArchivo,18,1,'_')
 SELECT @cArchivo = LTRIM(@cArchivo)
 SELECT @cBuffer = ''
 SELECT @cBuffer = @cBuffer+'SELECT * INTO '+@cArchivo+' FROM #TEMP1'
 SELECT 'nomemp' = 'A,'+ISNULL(acnomprop,'')     ,
  'rutemp' = ISNULL((RTRIM(CONVERT(CHAR(9),acrutprop))+'-'+acdigprop),'') ,
  'fecpro' = CONVERT(CHAR(10),acfecproc,103)    ,
  'usuario' = SPACE(15)       ,
  'nomusu' = SPACE(40)       ,
  'fechaexp' = SPACE(10)
 INTO #TEMP1
 FROM MDAC
 SELECT 'nomemp' = 'B,'+ISNULL(acnomprop,'')     ,
  'rutemp' = ISNULL((RTRIM(CONVERT(CHAR(9),acrutprop))+'-'+acdigprop),'') ,
  'fecpro' = CONVERT(CHAR(10),acfecproc,103)    ,
  'usuario' = RTRIM(usuario)     ,
  'nomusu' = RTRIM(nombre)      ,
  'fechaexp' = CONVERT(CHAR(10),fechaexp,103)
 INTO #TEMP2
 FROM MDAC, BACUSER 
 ORDER BY usuario
 INSERT INTO #TEMP1 SELECT * FROM #TEMP2
 SELECT * FROM #TEMP1 WHERE usuario<>''
        
 EXECUTE (@cBuffer)
 SELECT @cExecute = 'DROP TABLE '+@cArchivo
 EXECUTE (@cExecute)
   
END

GO
