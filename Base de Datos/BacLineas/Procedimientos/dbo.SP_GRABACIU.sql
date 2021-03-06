USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABACIU]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_GRABACIU    fecha de la secuencia de comandos: 03/04/2001 15:18:04 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_GRABACIU    fecha de la secuencia de comandos: 14/02/2001 09:58:26 ******/
CREATE PROCEDURE [dbo].[SP_GRABACIU]( @cod_pai NUMERIC(6),
                      @cod_ciu NUMERIC(6),
                     @nom_ciu CHAR(40)
   )
AS
BEGIN              
    IF EXISTS(SELECT 1 FROM CIUDAD_COMUNA WHERE cod_pai = @cod_pai and cod_ciu = @cod_ciu and cod_com = 0) BEGIN  
       UPDATE ciudad_comuna SET nom_ciu = @nom_ciu where cod_pai=@cod_pai and cod_ciu=@cod_ciu and cod_com = 0        
    END ELSE BEGIN
       INSERT INTO CIUDAD_COMUNA(cod_pai,cod_ciu,cod_com,nom_ciu) VALUES (@cod_pai,@cod_ciu,0,@nom_ciu)
    END
    RETURN
END
GO
