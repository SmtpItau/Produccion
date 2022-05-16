USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDTCLEERCODI]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MDTCLeerCodi    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDTCLeerCodi    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
CREATE PROCEDURE [dbo].[SP_MDTCLEERCODI]
       (
       @ncodtab NUMERIC(03)
  
       )
AS
BEGIN
set nocount on
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT          tbcodigo1    ,
                   tbglosa 
          FROM     TABLA_GENERAL_DETALLE
          WHERE    tbcateg =  @ncodtab
   ORDER BY tbcodigo1
   /*=======================================================================*/
   /*=======================================================================*/
   RETURN
set nocount off
END

GO
