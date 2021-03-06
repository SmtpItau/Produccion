USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_AGREGAR_PAIS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_AGREGAR_PAIS] (@codigo_pais   INT 
						  ,@nombre        VARCHAR(50) 
                                                  ,@codigo_Bcch   INT
						  ,@codigo_Swift  CHAR(02)
         )
AS
BEGIN
	SET NOCOUNT OFF
	BEGIN TRANSACTION
	IF NOT EXISTS(SELECT codigo_pais, nombre FROM pais WHERE codigo_pais = @codigo_pais)  BEGIN
		INSERT INTO PAIS(codigo_pais,nombre,cod_bcch,cod_swift)
		VALUES (@codigo_pais, @nombre,@codigo_Bcch,@codigo_Swift)
	END
	ELSE BEGIN
		IF EXISTS(SELECT codigo_pais, nombre FROM pais WHERE codigo_pais = @codigo_pais) BEGIN
			UPDATE pais 
			   SET nombre    = @nombre
			      ,cod_bcch  = @codigo_Bcch 
			      ,cod_swift = @codigo_Swift 
			WHERE  codigo_pais = @codigo_pais
			SELECT 'EXISTE'
		END 
	END
 
	IF @@ERROR <> 0  BEGIN
		ROLLBACK TRANSACTION
		SELECT 'ERR'          -- SI OCURRE ALGUN ERROR 
		RETURN 
	END
	ELSE BEGIN
	        COMMIT TRANSACTION   -- SI GRABA 
        	SELECT 'Ok'
	        RETURN
	END
	SET NOCOUNT ON
END

--alter table pais add cod_swift CHAR(02) NOT NULL DEFAULT ('')
-- SP_AUTORIZA_EJECUTAR 'bacuser'
GO
