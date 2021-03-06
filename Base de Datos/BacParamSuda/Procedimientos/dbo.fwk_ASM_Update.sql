USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_ASM_Update]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_ASM_Update] 
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdFile           NVARCHAR(100)
   ,@Descripcion      VARCHAR(100)
   ,@Version          VARCHAR(30)
   ,@Data             VARBINARY(MAX)
   ,@CreatedTicks     VARCHAR(30)
)
--WITH ENCRYPTION
AS
	/*
Crear/Actualizar los ensamblados

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_ASM_Update 'FFMM', 'Participe.UI.dll', 'Participe.UI', '1.0.0.1', NULL

*/ 

BEGIN
	BEGIN TRAN
	
	IF EXISTS (
	       SELECT id_file
	       FROM   FWK_ENSAMBLADOS
	       WHERE  id_file = @IdFile
	   )
	BEGIN
	    -- actualizar la informacion
	    UPDATE FWK_ENSAMBLADOS
	    SET    version           = @Version
	          ,descripcion       = @Descripcion
	          ,created_ticks     = @CreatedTicks
	          ,DATA              = @Data
	    WHERE  id_file           = @IdFile
	END
	ELSE
	BEGIN
	    -- generar la informacion
	    INSERT INTO FWK_ENSAMBLADOS
	      (
	        id_file
	       ,version
	       ,descripcion
	       ,created_ticks
	       ,DATA
	      )
	    VALUES
	      (
	        @IdFile
	       ,@Version
	       ,@Descripcion
	       ,@CreatedTicks
	       ,@Data
	      )
	END
	
	IF NOT EXISTS (
	       SELECT id_aplicacion
	       FROM   FWK_APLICACIONES_ENSAMBLADOS
	       WHERE  id_aplicacion     = @IdAplicacion
	              AND id_file       = @IdFile
	   )
	BEGIN
	    -- generar la informacion
	    INSERT INTO FWK_APLICACIONES_ENSAMBLADOS
	      (
	        id_aplicacion
	       ,id_file
	      )
	    VALUES
	      (
	        @IdAplicacion
	       ,@IdFile
	      )
	END
	
	COMMIT TRAN
END
GO
