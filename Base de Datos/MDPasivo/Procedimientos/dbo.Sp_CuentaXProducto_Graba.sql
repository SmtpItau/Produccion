USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CuentaXProducto_Graba]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_CuentaXProducto_Graba]
            (     @id_sistema	          CHAR      ( 3  )
            ,     @codigo_producto	  VARCHAR   ( 5  )
            ,     @codigo_moneda1	  NUMERIC   ( 5  )
            ,     @codigo_moneda2	  NUMERIC   ( 5  )
            ,     @codigo_instrumento     CHAR      ( 12 )
            ,     @tipo_operacion	  CHAR      ( 3  )
            ,     @rut_emisor	          NUMERIC   ( 9  )
            ,     @tipo_emisor	          CHAR      ( 3  )
            ,     @codigo_plazo	          CHAR      ( 3  )
            ,     @tipo_cliente	          NUMERIC   ( 5  )
            ,     @modalidad	          CHAR      ( 1  )
            ,     @tipo_mercado	          CHAR      ( 1  )
            ,     @codigo_carterasuper    CHAR      ( 1  )
            ,     @descripcion	          VARCHAR   ( 80 )
            ,     @cuenta_capital	  CHAR      ( 12 )
            ,     @cuenta_interes	  CHAR      ( 12 )
            ,     @cuenta_reajuste	  CHAR      ( 12 )
            ,     @cuenta_res_interes     CHAR      ( 12 )
            ,     @cuenta_res_reajuste    CHAR      ( 12 )
            ,     @producto_interfaz      CHAR      ( 5  )
            ,     @SW                     CHAR      ( 1  ) = ' '
            ,     @forma_pago             NUMERIC   ( 5  ) 
            ,     @cuenta_p17             CHAR      ( 12 )
            ,     @producto_p17           CHAR      ( 10 ) 
            ,     @codigo_p17             CHAR      ( 10 ) 
            ,     @moneda_contable        CHAR      ( 5  )   
            )


AS 
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy




   SELECT @tipo_mercado = CASE WHEN @tipo_mercado = ' '  THEN 0
                               WHEN @tipo_mercado = 'L' THEN 1
                               WHEN @tipo_mercado = 'E' THEN 2
                               END     



   IF @SW = '1' BEGIN

      DELETE FROM PRODUCTO_CUENTA
   
   END 

   IF @codigo_carterasuper = ' ' BEGIN

      SELECT @codigo_carterasuper  = 'S'      

   END

   IF NOT EXISTS (SELECT 1 FROM PRODUCTO_CUENTA WHERE
                                                      id_sistema            =	@id_sistema
                                                  AND codigo_producto       =	@codigo_producto
                                                  AND codigo_moneda1        =	@codigo_moneda1 
                                                  AND codigo_moneda2        =	@codigo_moneda2
                                                  AND codigo_instrumento    =	@codigo_instrumento
                                                  AND tipo_operacion        =	@tipo_operacion
                                                  AND rut_emisor            =	@rut_emisor
                                                  AND tipo_emisor           =	@tipo_emisor
                                                  AND codigo_plazo          =	@codigo_plazo
                                                  AND tipo_cliente          =	@tipo_cliente
                                                  AND modalidad             =	@modalidad
                                                  AND tipo_mercado          =	@tipo_mercado
                                                  AND codigo_carterasuper   =	@codigo_carterasuper
                                                  AND forma_pago            =   @forma_pago
                  )
   BEGIN




      INSERT INTO PRODUCTO_CUENTA

            (      id_sistema
            ,      codigo_producto
            ,      codigo_moneda1
            ,      codigo_moneda2
            ,      codigo_instrumento
            ,      tipo_operacion
            ,      rut_emisor
            ,      tipo_emisor
            ,      codigo_plazo
            ,      tipo_cliente
            ,      modalidad
            ,      tipo_mercado
            ,      codigo_carterasuper
            ,      descripcion
            ,      cuenta_capital
            ,      cuenta_interes
            ,      cuenta_reajuste
            ,      cuenta_res_interes
            ,      cuenta_res_reajuste
            ,      producto_interfaz
            ,      forma_pago 
            ,      cuenta_p17 
            ,      producto_p17
            ,      codigo_p17  
            ,      moneda_contable
            )
      VALUES
   
            (      @id_sistema
            ,      @codigo_producto
            ,      @codigo_moneda1
            ,      @codigo_moneda2
            ,      @codigo_instrumento
            ,      @tipo_operacion
            ,      @rut_emisor
            ,      @tipo_emisor
            ,      @codigo_plazo
            ,      @tipo_cliente
            ,      @modalidad
            ,      @tipo_mercado
            ,      @codigo_carterasuper
            ,      @descripcion
            ,      @cuenta_capital
            ,      @cuenta_interes
            ,      @cuenta_reajuste
            ,      @cuenta_res_interes
            ,      @cuenta_res_reajuste
            ,      @producto_interfaz
            ,      @forma_pago 
            ,      @cuenta_p17 
            ,      @producto_p17
            ,      @codigo_p17  
            ,      @moneda_contable
            )

   END
   ELSE   BEGIN

            UPDATE PRODUCTO_CUENTA   SET   descripcion	        =   @descripcion
                                       ,   cuenta_capital	=   @cuenta_capital
                                       ,   cuenta_interes	=   @cuenta_interes
                                       ,   cuenta_reajuste	=   @cuenta_reajuste
                                       ,   cuenta_res_interes	=   @cuenta_res_interes
                                       ,   cuenta_res_reajuste	=   @cuenta_res_reajuste
                                       ,   producto_interfaz	=   @producto_interfaz
                                       ,   forma_pago           =   @forma_pago   
                                       ,   cuenta_p17           =   @cuenta_p17 
                                       ,   producto_p17         =   @producto_p17
                                       ,   codigo_p17           =   @codigo_p17
                                       ,   moneda_contable      =   @moneda_contable


            WHERE       
                   id_sistema            =	@id_sistema
               AND codigo_producto       =	@codigo_producto
               AND codigo_moneda1        =	@codigo_moneda1 
               AND codigo_moneda2        =	@codigo_moneda2
               AND codigo_instrumento    =	@codigo_instrumento
               AND tipo_operacion        =	@tipo_operacion
               AND rut_emisor            =	@rut_emisor
               AND tipo_emisor           =	@tipo_emisor
               AND codigo_plazo          =	@codigo_plazo
               AND tipo_cliente          =	@tipo_cliente
               AND modalidad             =	@modalidad
               AND tipo_mercado          =	@tipo_mercado
               AND codigo_carterasuper   =	@codigo_carterasuper
               AND forma_pago            =	@forma_pago

   END

   SET NOCOUNT OFF

END




GO
