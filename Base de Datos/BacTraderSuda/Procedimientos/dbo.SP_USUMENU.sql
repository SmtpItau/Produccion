USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_USUMENU]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_USUMENU]
AS
BEGIN
 DECLARE @cArchivo VARCHAR (20) ,
  @cBuffer VARCHAR (250) ,
  @cExecute VARCHAR (200) ,
  @User  VARCHAR (100)
 SELECT @User  = 'SP_USUMENU'
 SELECT @cArchivo = LTRIM(@user)+CONVERT(CHAR(14),GETDATE(),114)
 SELECT @cArchivo = STUFF(@cArchivo,13 ,1,'_')
 SELECT @cArchivo = STUFF(@cArchivo,16,1,'_')
 SELECT @cArchivo = STUFF(@cArchivo,19,1,'_')
 SELECT @cArchivo = LTRIM(@cArchivo )
 SELECT @cBuffer = ''
        SELECT @cBuffer  = @cBuffer+'SELECT * INTO '+@cArchivo+' FROM #TEMP1'
 SELECT 'nomemp' = 'A,'+ISNULL(acnomprop,'')     ,
  'rutemp' = ISNULL((RTRIM(CONVERT(CHAR(9),acrutprop))+'-'+acdigprop),'') ,
  'fecpro' = ISNULL(CONVERT(CHAR(10),acfecproc,103),'')   ,
  'nivel'  = SPACE(15)       ,
  'descripcion' = SPACE(40)       ,
  'funcion' = SPACE(10)
 INTO #TEMP1
 FROM MDAC
 
 SELECT 'nomemp' = 'B,'+ISNULL(acnomprop,'')              ,
  'rutemp' = ISNULL((RTRIM (CONVERT(CHAR(9),acrutprop))+'-'+acdigprop),'')          ,
  'fecpro' = ISNULL(CONVERT(CHAR(10),acfecproc,103),'')            ,
  'nivel'  = SUBSTRING(mnivel,1,3)+'.'+SUBSTRING(mnivel,4,2)+'.'+SUBSTRING(mnivel,6,2)+'.'+SUBSTRING(mnivel,8,2)+'.'+SUBSTRING(mnivel,10,2) ,
  'descripcion' = SUBSTRING(mtexto,2,39)              ,
  'tipo'  = mtipo                 ,
  'funcion' = CONVERT(CHAR(10),mopcion)
 INTO #TEMP2
 FROM BACMENU, MDAC
       
 UPDATE #TEMP2
 SET descripcion = '.....'+RTRIM(descripcion) WHERE SUBSTRING(RTRIM(nivel),5,2)<>'00' 
        AND SUBSTRING(RTRIM(nivel),8,2)='00'                                                                          AND   SUBSTRING(RTRIM(nivel),11,2) = '00' 
        AND SUBSTRING(RTRIM(nivel),14,2)='00'
 UPDATE #TEMP2
 SET descripcion = '..........'+RTRIM(descripcion) WHERE SUBSTRING(RTRIM(nivel),5,2)<>'00'
         AND SUBSTRING(RTRIM(nivel),8,2)<>'00'
         AND SUBSTRING(RTRIM(nivel),11,2)='00'
         AND SUBSTRING(RTRIM(nivel),14,2)='00'
 UPDATE #TEMP2
 SET descripcion = '...............'+RTRIM(descripcion) WHERE SUBSTRING(nivel,5,2)<>'00'
         AND  SUBSTRING(nivel,8,2)<>'00' 
         AND  SUBSTRING(nivel,11,2)<>'00'
         AND  SUBSTRING(RTRIM(nivel),14,2)='00'
 UPDATE #TEMP2
 SET descripcion = '....................'+RTRIM(descripcion) WHERE SUBSTRING(nivel,5,2)<>'00'
          AND SUBSTRING(nivel,8,2)<>'00' 
          AND SUBSTRING(nivel,11,2)<>'00'
          AND SUBSTRING(RTRIM(nivel),14,2)<>'00'
 INSERT INTO #TEMP1 
 SELECT nomemp  ,
  rutemp  ,
  fecpro  ,
  nivel  ,
  descripcion ,
  funcion 
 FROM #TEMP2
 ORDER BY nivel
 SELECT nomemp    ,
  rutemp    ,
  fecpro    ,
  CASE
   WHEN nivel='' THEN '0'
   ELSE nivel
  END    ,
  CASE
   WHEN descripcion='' THEN 'Menu'
   ELSE descripcion
  END    ,
  CASE
   WHEN funcion='' THEN '0'
   ELSE funcion
  END
 FROM #TEMP1 
                
        EXECUTE (@cBuffer)
        SELECT @cExecute = 'DROP TABLE '+@cArchivo
        EXECUTE (@cExecute)
   
END


GO
