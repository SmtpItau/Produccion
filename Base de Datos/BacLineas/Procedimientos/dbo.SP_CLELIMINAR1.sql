USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLELIMINAR1]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_CLELIMINAR1    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_CLELIMINAR1    fecha de la secuencia de comandos: 14/02/2001 09:58:24 ******/
CREATE PROCEDURE [dbo].[SP_CLELIMINAR1] (
                                  @clrut1   NUMERIC(9,0) ,
      @CLCODIGO numeric(9,0)
                                 )
AS
  BEGIN
  
      
       DELETE  FROM CLIENTE WHERE clrut = @clrut1 and clcodigo = @clcodigo
  END


-- Sp_ClEliminar1 12947634, 1

-- select * from CLIENTE
GO
