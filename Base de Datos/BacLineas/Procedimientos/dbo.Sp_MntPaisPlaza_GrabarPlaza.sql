USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MntPaisPlaza_GrabarPlaza]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MntPaisPlaza_GrabarPlaza    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[Sp_MntPaisPlaza_GrabarPlaza]
  ( @CODIGOPLAZA NUMERIC(5),
                        @GLOSA  VARCHAR(10),
                        @NOMBRE  VARCHAR(50),
                        @CODIGOPAIS NUMERIC(5))       
   
AS
BEGIN
 SET NOCOUNT ON
 
  INSERT INTO PLAZA ( codigo_plaza ,glosa,nombre,codigo_pais) 
   values (@CODIGOPLAZA,@GLOSA,@NOMBRE,@CODIGOPAIS)
    
    
 
 if @@error <> 0
 begin
  select "error"
 end else
  begin
  select "ok"   
  end
  
   set nocount off 
END






GO
