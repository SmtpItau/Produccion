USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACUSERLEETODO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Objeto:  procedimiento  almacenado DBO.SP_BACUSERLEETODO    fecha de la secuencia de comandos: 05/04/2001 13:13:10 ******/
CREATE PROCEDURE [dbo].[SP_BACUSERLEETODO]
AS
BEGIN
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT       'USUARIO' = usuario         ,
                'NOMBRE'  = nombre          ,                
                'FECEXP'  = CONVERT(CHAR(10),fechaexp,103)        
                
          FROM  BACUSER
          ORDER BY usuario
          
          
   /*=======================================================================*/
   /*=======================================================================*/
   RETURN 0
END

GO
