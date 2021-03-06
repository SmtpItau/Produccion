USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACUSERLEEMNTUSU]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Objeto:  procedimiento  almacenado SP_BACUSERLEEMNTUSU    fecha de la secuencia de comandos: 05/04/2001 13:13:10 ******/
CREATE PROCEDURE [dbo].[SP_BACUSERLEEMNTUSU](
                                      @Usuario  CHAR(15)  -- Usuario
                                    ) 
AS
BEGIN
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT       usuario         ,
                nombre          ,
                password        ,
                CONVERT(CHAR(10),fechaexp,103),
                tipoper  ,
                password2  
          FROM  BACUSER
          WHERE @Usuario = usuario
          
   /*=======================================================================*/
   /*=======================================================================*/
   RETURN 0
END


GO
