USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EXISTEOPERACION1]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_EXISTEOPERACION1]
 ( 
  @NUMOPE       NUMERIC(9),
    @ENTIDAD      FLOAT 
 )
AS BEGIN
 SELECT CASE  @NUMOPE
  WHEN ( SELECT monumope 
   FROM  MEMO  
   WHERE MOENTIDAD =  @ENTIDAD  
     AND monumope  =  @NUMOPE ) THEN 'MEMO'  
  WHEN ( SELECT monumope 
    FROM MEMOH 
                        WHERE moentidad =  @ENTIDAD  
                         AND monumope   =  @NUMOPE ) THEN 'MEMOH' 
  ELSE 'NO' 
     END
END

GO
