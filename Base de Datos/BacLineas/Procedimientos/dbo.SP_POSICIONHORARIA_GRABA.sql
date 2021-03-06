USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_POSICIONHORARIA_GRABA]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_POSICIONHORARIA_GRABA    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[SP_POSICIONHORARIA_GRABA]
        (@codigo_grupo  varchar (5),            
  @porcentaje  numeric (10,4),
  @totalposicion  numeric (19,4),
  @totalocupado  numeric (19,4),
  --@totalcompra  numeric (19,4),
  --@totalventa  numeric (19,4),
  @totaldisponible numeric (19,4),
  @totalexcedido  numeric (19,4))
AS BEGIN
SET NOCOUNT ON
  IF EXISTS(SELECT codigo_grupo FROM POSICION_GRUPO WHERE @codigo_grupo= codigo_grupo)
   
   BEGIN
   UPDATE POSICION_GRUPO SET
    codigo_grupo = @codigo_grupo,
    porcentaje = @porcentaje,
    totalposicion = @totalposicion,
    totalocupado = @totalocupado,
    --totalcompra = @totalcompra,
    --totalventa = @totalventa,
    totaldisponible = @totaldisponible,
    totalexcedido = @totalexcedido
     where @codigo_grupo= codigo_grupo
    SELECT 'MODIFICADO'
   
   END   
  ELSE
   
   BEGIN
   INSERT INTO POSICION_GRUPO
                         (codigo_grupo,
     porcentaje,
     totalposicion,
     totalocupado,
     totalcompra,
     totalventa,
     totaldisponible,
     totalexcedido)
    
    VALUES
           (@codigo_grupo,
     @porcentaje,
     @totalposicion,
     @totalocupado,
     0,--totalcompra,
     0,--totalventa,
     @totaldisponible,
     @totalexcedido)
    SELECT 'INSERTADO'
  END
END
--Sp_PosicionHoraria_Graba 'BBBBB',100,15000,0,5000,0
--DELETE  FROM POSICION_GRUPO
GO
