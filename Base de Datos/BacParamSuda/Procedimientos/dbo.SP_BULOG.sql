USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BULOG]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Bulog    fecha de la secuencia de comandos: 03/04/2001 15:17:59 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Bulog    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BULOG](@cod CHAR(1))
                    
AS
  
            
BEGIN
SET NOCOUNT ON
 IF @cod ='1' BEGIN
 
 SELECT   DISTINCT MDLOG.user1,nombre  FROM  MDLOG, MUSER 
  WHERE MDLOG.user1 = MUSER.user1 GROUP BY MDLOG.user1,nombre ORDER BY 
  MDLOG.user1
 
 END ELSE IF @cod ='2' BEGIN
  SELECT   DISTINCT user1,evento  FROM  MDLOG  /* GROUP BY user1,evento*/  ORDER BY evento
 END ELSE IF @COD ='3' BEGIN
  SELECT   DISTINCT '',CONVERT(char(10),fechapro,103)  FROM  MDLOG GROUP BY  
  CONVERT(char(10),fechapro,103)
  ORDER BY CONVERT(char(10),fechapro,103)
 END
SET NOCOUNT OFF         
END
GO
