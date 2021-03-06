USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNTPAISPLAZA_GRABARPAIS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MntPaisPlaza_GrabarPais    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[SP_MNTPAISPLAZA_GRABARPAIS]
  ( @CODIGOPAIS NUMERIC(5),
                        @NOMBRE  VARCHAR(50))        
   
AS
BEGIN
 SET NOCOUNT ON
 
  INSERT INTO PAIS ( codigo_pais,nombre) 
   values (@CODIGOPAIS,
    @NOMBRE)
    
 
 if @@error <> 0
 begin
  select 'error'
 end else
  begin
  select 'ok'   
  end
  
   set nocount off 
END

GO
