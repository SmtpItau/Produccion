USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Agregar_Pais]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Agregar_Pais] (
                  @codigo_pais   int 
          ,@nombre        varchar(50) 
                                                    ,@codigo_Bcch   int
         )
AS
BEGIN
    SET NOCOUNT OFF
BEGIN TRANSACTION
 IF NOT EXISTS(SELECT codigo_pais, nombre FROM PAIS
  WHERE codigo_pais = @codigo_pais)  BEGIN
    INSERT INTO PAIS(codigo_pais,nombre,cod_bcch)
  VALUES (@codigo_pais, @nombre,@codigo_Bcch)
    END ELSE
    BEGIN
    IF EXISTS(SELECT codigo_pais, nombre FROM PAIS
              WHERE codigo_pais = @codigo_pais) BEGIN
  UPDATE PAIS SET nombre = @nombre , cod_bcch = @codigo_Bcch where  codigo_pais = @codigo_pais
     SELECT "EXISTE"
    END 
  END
 
    IF @@ERROR <> 0  BEGIN
        ROLLBACK TRANSACTION
 SELECT 'ERR'          -- SI OCURRE ALGUN ERROR 
 RETURN 
     END ELSE BEGIN
        COMMIT TRANSACTION   -- SI GRABA 
        SELECT 'Ok'
        RETURN
     END
   SET NOCOUNT ON
END






GO
