USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACRIEPAIS_GRABA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BACRIEPAIS_GRABA    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
CREATE PROCEDURE [dbo].[SP_BACRIEPAIS_GRABA] ( 
     @codigo   NUMERIC (5),
            @nombre   CHAR    (50),        
            @porcentaje  NUMERIC (8,4),
            @totalasignado  NUMERIC (19),
            @totalocupado  NUMERIC (19),
            @totaldisponible  NUMERIC (19),
            @totalexceso  NUMERIC (19)
         )
As
BEGIN
 SET NOCOUNT ON
 IF NOT EXISTS (SELECT codigo_pais FROM RIESGO_PAIS WHERE codigo_pais=@codigo) BEGIN
  INSERT INTO RIESGO_PAIS ( 
       codigo_pais,
       nombre,
       porcentaje,
       totalasignado,
       totalocupado,
       totaldisponible,
       totalexceso )
       
    VALUES ( 
       @codigo,
       @nombre, 
       @porcentaje,   
                                          @totalasignado,
       @totalocupado,
       @totaldisponible,
       @totalexceso
       )     
  SELECT 'INSERTA'
 END
 ELSE BEGIN
         UPDATE RIESGO_PAIS SET porcentaje      = @porcentaje,
           totalasignado   = @totalasignado
       WHERE
 
           codigo_pais      = @codigo AND
           nombre           = @nombre
  SELECT 'EDITA'
 END
 SET NOCOUNT OFF
           
END







GO
