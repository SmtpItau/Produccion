USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[GRABACOM]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.GraBacom    fecha de la secuencia de comandos: 03/04/2001 15:17:56 ******/
/****** Objeto:  procedimiento  almacenado dbo.GraBacom    fecha de la secuencia de comandos: 14/02/2001 09:58:22 ******/
CREATE PROCEDURE [dbo].[GRABACOM]
                   (@cod_pai NUMERIC(6),
                    @cod_ciu NUMERIC(6),
      @cod_com NUMERIC(6),
                    @nom_ciu CHAR(40))
AS
BEGIN
SET NOCOUNT ON
    IF EXISTS(SELECT * FROM CIUDAD_COMUNA WHERE cod_pai = @cod_pai AND cod_ciu = @cod_ciu AND cod_com = @cod_com) BEGIN  
       UPDATE CIUDAD_COMUNA SET nom_ciu = @nom_ciu WHERE cod_pai=@cod_pai AND cod_ciu=@cod_ciu AND cod_com = @cod_com        
    END ELSE BEGIN
       INSERT INTO CIUDAD_COMUNA(cod_pai,cod_ciu,cod_com,nom_ciu) VALUES (@cod_pai,@cod_ciu,@cod_com,@nom_ciu)
    END
      SELECT 'OK'      
      
    RETURN
END
GO
