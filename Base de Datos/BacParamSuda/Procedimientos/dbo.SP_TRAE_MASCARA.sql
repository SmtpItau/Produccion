USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_MASCARA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_MASCARA](@xSerie CHAR(12))
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS(SELECT * FROM TABLA_DESARROLLO WHERE tdmascara = @xSerie)
 BEGIN
 SELECT  tdcupon       ,--1
   tdfecven    ,--2
   tdinteres    ,--3
   tdamort     ,--4
   tdflujo     ,--5
   tdsaldo     , --6
   'mascara' = @xSerie   , --7
   'hora'   = CONVERT(VARCHAR(10),GETDATE(),108),
 'entidad'  =  ( select acnomprop from VIEW_MDAC)
  FROM TABLA_DESARROLLO 
  WHERE tdmascara = @xSerie
 END
 ELSE
  SELECT  'tdcupon' = 0       ,--1
      'tdfecven'  =SPACE(9)    ,--2
      'tdinteres'  = 0     ,--3
      'tdamort'  = 0     ,--4
      'tdflujo'  = 0     ,--5
      'tdsaldo'  = 0     , --6
      'mascara'  = @xSerie    , --7
      'hora'     = CONVERT(VARCHAR(10),GETDATE(),108),
   'entidad'  =  ( select acnomprop from VIEW_MDAC)
END 
---SP_HELP TABLA_DESARROLLO

GO
