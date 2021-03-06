USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_POSICIONHORARIA_LEE]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_POSICIONHORARIA_LEE    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[SP_POSICIONHORARIA_LEE]
AS BEGIN
SET NOCOUNT ON
 IF EXISTS(SELECT CODIGO_GRUPO FROM POSICION_GRUPO)
    BEGIN
  SELECT  
   b.capitalyreserva, --capitalyreserva
   b.invextocupado, --invextocupado
   a.codigo_grupo,
   c.descripcion, --descripcion
   a.porcentaje,
   a.totalposicion,
   a.totalocupado,
   a.totalcompra,
   a.totalventa,
   a.totaldisponible,
   a.totalexcedido
 
   FROM POSICION_GRUPO a, CONTROL_FINANCIERO b, GRUPO_POSICION c
    WHERE c.codigo_grupo=a.codigo_grupo
     END
  ELSE
     BEGIN
  SELECT  
   capitalyreserva, --capitalyreserva
   invextocupado, --invextocupado
   codigo_grupo = '',
   descripcion = '',
   porcentaje = 0.0000,
   totalposicion = 0.0000,
   totalocupado = 0.0000,
   totalcompra = 0.0000,
   totalventa = 0.0000,
   totaldisponible = 0.0000,
   totalexcedido = 0.0000
 
   FROM CONTROL_FINANCIERO
            END
END
--SELECT * FROM CONTROL_FINANCIERO
--SELECT * FROM GRUPO_POSICION
GO
