USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_EMISOR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_GRABA_EMISOR    fecha de la secuencia de comandos: 03/04/2001 15:18:04 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_GRABA_EMISOR    fecha de la secuencia de comandos: 14/02/2001 09:58:26 ******/
CREATE PROCEDURE [dbo].[SP_GRABA_EMISOR]( @xRut  NUMERIC(9) ,
     @xDv  CHAR(1)  ,
     @xNombre CHAR(40) ,
     @xGeneric CHAR(10) ,
     @xDirecc CHAR(40) ,
     @xComuna NUMERIC(4) ,
     @xTipoE CHAR(3)  ,
     @xCodigo NUMERIC(5) )
AS
BEGIN
   SET NOCOUNT ON
  IF EXISTS(SELECT 1 FROM Emisor WHERE emrut = @xrut) 
       UPDATE EMISOR SET  emnombre  = @xNombre  ,
   emgeneric = @xGeneric  ,
   emdirecc = @xDirecc  ,
   emcomuna = @xComuna  ,
   emtipo  = @xTipoE  ,
   emcodigo = @xCodigo  
   WHERE emrut = @xRut
  ELSE
     INSERT INTO Emisor( emrut  ,
   emdv  ,
   emnombre ,
   emgeneric ,
   emdirecc ,
   emcomuna ,
   emtipo  ,
   emcodigo ) 
     VALUES(  @xRut  ,
   @xDv  ,
   @xNombre ,
   @xGeneric ,
   @xDirecc ,
   @xComuna ,
   @xTipoE ,
   @xCodigo )
IF @@error <> 0  BEGIN
   SET NOCOUNT OFF
       SELECT 'NO'
       RETURN
END
SET NOCOUNT OFF
SELECT 'SI'
END
GO
