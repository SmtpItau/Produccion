USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CORRESPONSALES_MODIFICAR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_CORRESPONSALES_MODIFICAR    fecha de la secuencia de comandos: 03/04/2001 15:18:01 ******/
CREATE PROCEDURE [dbo].[SP_CORRESPONSALES_MODIFICAR] ( @rutcliente NUMERIC(8),
                                 @codigocliente NUMERIC(5),
                          @codigomoneda NUMERIC(5),
      @codigopais NUMERIC(5),
      @codigoplaza NUMERIC(5), 
      @codigoswift VARCHAR(10),
      @nombre  VARCHAR(50), 
      @cuentacorriente VARCHAR(30),
                             @swiftsantiago  VARCHAR(10),
                            @bancocentral    CHAR(1),
                             @fechavencimiento DATETIME)
 
 as
 begin
 set nocount on
         update CORRESPONSAL  set        codigo_moneda =@codigomoneda ,
      codigo_pais = @codigopais,
      codigo_plaza = @codigoplaza,
      codigo_swift = @codigoswift,
      nombre = @nombre,
      cuenta_corriente= @cuentacorriente,
      swift_santiago = @swiftsantiago,
      banco_central=@bancocentral,
      fecha_vencimiento=@fechavencimiento
 where rut_cliente = @rutcliente and  codigo_cliente = @codigocliente
 
 if @@error<>0
         begin
     select 'error'
 end else
     begin
           select ' modifica'
 end
   set nocount off 
END

GO
