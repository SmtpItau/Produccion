USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BSKDATAMNT]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BSKDATAMNT]
( @ctipomnt CHAR(30) )
AS
BEGIN
 SELECT  
  'nombre' = syscolumns.name, 
  'tipo'  = systypes.name,
  'largo'  = case upper( systypes.name ) when 'NUMERIC' THEN syscolumns.prec ELSE syscolumns.length END,
  'dec'  = ISNULL(syscolumns.scale,0)
 FROM  
  sysobjects , 
  syscolumns , 
 
 systypes   
 WHERE  
  sysobjects.name = @ctipomnt
        AND     sysobjects.type = 'U'
 AND   sysobjects.id  = syscolumns.id 
 AND  syscolumns.usertype = systypes.usertype
END

GO
