USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_MONEDAPRODUCTO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_GRABAR_MONEDAPRODUCTO    fecha de la secuencia de comandos: 03/04/2001 15:18:05 ******/
CREATE PROCEDURE [dbo].[SP_GRABAR_MONEDAPRODUCTO]( @Sistema  CHAR(3) , -- Sistema Tabla_General_Detalle = 49
                                           @CodProd  CHAR(5), -- Codigo Producto
                                           @CodMon   INTEGER , -- Codigo Moneda
                                           @Estado   CHAR(1) ) -- Estado de la relacion
AS
BEGIN
     SET NOCOUNT ON
     IF EXISTS (SELECT 1 FROM PRODUCTO_MONEDA WHERE mpsistema = @Sistema AND mpproducto = @CodProd AND mpcodigo = @CodMon)
     BEGIN
          UPDATE Producto_Moneda 
             SET mpestado  = @Estado
           WHERE mpsistema  = @Sistema
             AND mpproducto = @CodProd
             AND mpcodigo   = @CodMon
          IF @@ERROR <> 0   BEGIN
             SELECT -1, 'ERROR no se puede Actualizar Relacion Moneda Producto'
          END 
     END ELSE BEGIN
          INSERT INTO PRODUCTO_MONEDA( mpproducto ,
                            mpcodigo   ,
                            mpestado   ,
                     mpSistema  ,
       mptipoper, 
       mpmoneda )
                    VALUES( @CodProd   ,
                            @CodMon    ,
                            @Estado    ,
       @Sistema   ,
    '',
    0)
          IF @@ERROR <> 0   BEGIN
             SELECT -1, 'ERROR no se puede Agregar Relacion Moneda Producto'
          END 
     END
END  -- PROCEDURE
GO
