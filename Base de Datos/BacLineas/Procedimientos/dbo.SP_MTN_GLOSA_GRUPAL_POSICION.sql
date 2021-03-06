USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MTN_GLOSA_GRUPAL_POSICION]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MTN_GLOSA_GRUPAL_POSICION]
		(
			@iFlag 		CHAR(01)
		,	@iCodigo	CHAR(05) = ''
		,	@iDescripcion	CHAR(50) = ''
		,	@iSist	        CHAR(03) = ''
		)
AS
BEGIN
 SET NOCOUNT ON

  IF @iFlag = 'I'
    BEGIN
	IF EXISTS(SELECT 1 
		    FROM GRUPO_POSICION
		   WHERE codigo_grupo = @iCodigo)
	  BEGIN
		UPDATE GRUPO_POSICION
		   SET descripcion  = @iDescripcion
		   ,   sistema = @iSist
	         WHERE codigo_grupo = @iCodigo
		SELECT 0,'Modificacion Correcta'
		RETURN
	  END
	  ELSE
	  BEGIN
		INSERT INTO GRUPO_POSICION
			(
				codigo_grupo 
			,	descripcion 
			,	sistema
			)
		  VALUES
			(
				@iCodigo
			,	@iDescripcion
			,	@iSist
			)
		SELECT 0,'Grabacion Correcta'
		RETURN
	  END
    END

  IF @iFlag = 'B'
    BEGIN
	SELECT codigo_grupo 
              ,descripcion
              ,sistema 
              ,'Glosa_sistema'=(select nombre_sistema  from  bacparamsuda..sistema_cnt where  id_sistema =sistema) 
	FROM GRUPO_POSICION
	WHERE codigo_grupo = @iCodigo
    END

  IF @iFlag = 'E'
    BEGIN

	DELETE POSICION_GRUPO
	 WHERE codigo_grupo = @iCodigo

	DELETE GRUPO_POSICION
	 WHERE codigo_grupo = @iCodigo

	DELETE GRUPO_POSICION_detalle 
	 WHERE codigo_grupo = @iCodigo
    END

  IF @iFlag = 'C'
    BEGIN
	SELECT *
	  FROM GRUPO_POSICION
    END

 SET NOCOUNT OFF
END
















GO
