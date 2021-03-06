USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_AGREGAR_REGION]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TABLALOCALIDADES_AGREGAR_REGION    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_AGREGAR_REGION] (
           @codigo_region   int,
                         @codigo_pais     int,
        @nombre          varchar(50)
                                        )
AS 
BEGIN
 SET NOCOUNT OFF
    IF NOT EXISTS(SELECT codigo_region,codigo_pais, nombre FROM REGION
  WHERE codigo_region = @codigo_region)
  --WHERE codigo_region = @codigo_region or nombre = @nombre and codigo_pais = @codigo_Pais)
  --WHERE codigo_region = @codigo_region and codigo_pais = @codigo_Pais)
    BEGIN
  INSERT INTO REGION(Codigo_region, codigo_pais, nombre)
  VALUES (@codigo_region, @codigo_pais, @nombre)
  IF @@ERROR <> 0 
     BEGIN
 
      SELECT 'ERROR'
     END ELSE
     BEGIN
   SELECT 'OK'
     END
    END ELSE
    BEGIN
  IF EXISTS(SELECT codigo_region,codigo_pais, nombre FROM REGION
  WHERE codigo_region = @codigo_region)
  --WHERE codigo_region = @codigo_region AND nombre <> @nombre and codigo_pais = @codigo_Pais)
    BEGIN
   UPDATE REGION SET nombre = @nombre, codigo_pais = @codigo_pais where codigo_region= @codigo_region --and codigo_pais = @codigo_Pais
    END ELSE
    BEGIN
     SELECT 'EXISTE'
    end
   END
   SET NOCOUNT ON 
END
GO
