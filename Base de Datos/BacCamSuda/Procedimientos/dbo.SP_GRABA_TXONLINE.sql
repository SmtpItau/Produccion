USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_TXONLINE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_TXONLINE]
		( 	@Fecha            CHAR( 8)   ,
                        @Hora             CHAR( 8)   ,
                        @Origen        VARCHAR(20)   ,  -- DATATEC / BOLSA / otros ...
                        @Codigo        VARCHAR(20)   ,  -- Identificador
                        @Numero        NUMERIC(10)   ,
                        @Mercado          CHAR( 4)   ,
                        @Tipo             CHAR( 1)   ,
                        @Moneda           CHAR( 3)   ,
                        @MonedaCnv        CHAR( 3)   ,
                        @Monto         NUMERIC(19,2) ,
                        @Precio        NUMERIC(10,4) ,
                        @Equivalente   NUMERIC(19,2) ,
                        @Rut           NUMERIC( 9)   ,
                        @CodigoCliente NUMERIC( 9)   ,
                        @Contraparte   VARCHAR(40)   ,
                        @Contrausuario VARCHAR(40)   ,
                        @Usuario       VARCHAR(40)   ,
                        @Estado           CHAR( 1)   ,  -- E=Eliminada/Nula  P=Pendiente  I=Ingresada
                        @Operacion     NUMERIC(10)      -- Numero de operacion en movimiento
		)  
AS
BEGIN

     SET NOCOUNT ON

     ----<< verifica que cliente exista en ...
     SET ROWCOUNT 1
     -- DATATEC
     IF @rut = 0  AND @origen = 'DATATEC'
	SELECT 	@rut           = rut   ,
               	@codigocliente = codigo
         FROM 	view_cliente_datatec
        WHERE 	nombre  = @contraparte

     -- OTC - Bolsa
     IF @rut = 0  AND @origen = 'BOLSA'
        SELECT 	@rut           = rut   ,
               	@codigocliente = codigo
       FROM 	view_cliente_bolsa 
        WHERE 	cliente = @contraparte

     SET ROWCOUNT 0

     IF @rut = 0   BEGIN
        SELECT -1,'Cliente ' + @Contraparte +  ' no fue reconocido para transar con ' + @origen + CHAR(10) + CHAR(13) + 'Verifique Pseudonimos'
        RETURN
     END

     ----<< valida la existencia de la operacion
     IF NOT EXISTS (SELECT * FROM tbTXonline WHERE fecha = @fecha AND origen = @origen AND numero = @numero)  
	BEGIN
        	INSERT INTO tbTXonline( fecha, origen, numero)  
                VALUES(@fecha,@origen,@numero)
      
        IF @@ERROR<>0  
	BEGIN
           SELECT -1, 'No se pudo Agregar Nueva transaccion en linea'
           RETURN
        END
        
     END

     ----<< Actualiza movimiento capturado
     UPDATE tbTXonline
     SET    codigo        = @codigo        ,
            hora          = @hora          ,
            mercado       = @mercado       ,
            tipo          = @tipo          ,
            moneda        = @moneda        ,
            monedacnv     = @monedacnv     ,
            monto         = @monto         ,
            precio        = @precio        ,
            equivalente   = @equivalente   ,
            rut           = @rut           ,
            codigocliente = @codigocliente ,
            contraparte   = @contraparte   ,
            contrausuario = @contrausuario ,
            usuario       = @usuario       ,
            estado        = @estado        ,
            operacion     = ISNULL(@operacion,0),
	    indicador     = 'D'	    
      WHERE fecha  = @fecha
        AND origen = @origen
        AND numero = @numero
         
     IF @@ERROR<>0  BEGIN 
        SELECT -1, 'No se pudo actualizar transacciones en linea'
        RETURN
     END

	SELECT 	0		,
		@Rut		,
		@CodigoCliente	,
		ISNULL((SELECT clnombre FROM view_cliente WHERE clrut = @rut AND clcodigo = @CodigoCliente ),'NO ENCONTRADO'),
		@numero
END
GO
