USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Modifica_Por_Cotizacion]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[Sp_Modifica_Por_Cotizacion] 
( @NumContrato numeric(10) , @NumCotizacion numeric(10) ) 
-- Sp_Modifica_Por_Cotizacion  783, 829 
AS BEGIN			
			
   SET NOCOUNT ON
      -- Criterios que no pueden cambiar
      declare @CaCVEstructura  character(1)
            , @CaRutCliente    numeric(13)
            , @CaCodigo        numeric(2)
            , @CaCodEstructura numeric(2)
            , @CaCaFechaContrato datetime
            , @Control_Error   int

      declare @CotCVEstructura  character(1)
            , @CotRutCliente    numeric(13)
            , @CotCodigo        numeric(2)
            , @CotCodEstructura numeric(2)


      select  @CaCVEstructura  = CaCVEstructura 
            , @CaRutCliente    = CaRutCliente
            , @CaCodigo        = CaCodigo
            , @CaCodEstructura = CaCodEstructura 
            , @CaCaFechaContrato = CaFechaContrato
           
          from CaEncContrato where CaNumContrato = @NumContrato

      IF @@rowcount = 0
      BEGIN
         select Convert( varchar(80) ,  ' Contrato no Existe'  )   as Mensaje
         return(1)
      END


      select  @CotCVEstructura  = CaCVEstructura 
            , @CotRutCliente    = CaRutCliente
            , @CotCodigo        = CaCodigo
            , @CotCodEstructura = CaCodEstructura 
          from CaEncContrato where CaNumContrato = @NumCotizacion

      IF @@rowcount = 0
      BEGIN
         select Convert( varchar(80) ,  ' Cotizacion no Existe'  )   as Mensaje
         return(1)
      END

      declare @Diferencias character(120) 
      select  @Diferencias = 'Cotizacion cambia'
      if @CaCVEstructura <> @CotCVEstructura   
          select @Diferencias = rtrim( @Diferencias ) + ' Compra-Vta de Estructura, '
      if @CaRutCliente  <> @CotRutCliente      
          select @Diferencias = rtrim( @Diferencias ) + ' Rut Cliente '
      if @CaCodigo  <> @CotCodigo              
          select @Diferencias = rtrim( @Diferencias ) + ' Codigo Cliente '
      if @CaCodEstructura <> @CotCodEstructura 
           select @Diferencias = rtrim( @Diferencias ) + ' Estructura '


      if @Diferencias <> 'Cotizacion cambia' begin
         select Convert( varchar(80) , rtrim( @Diferencias ) + ' NO SE APLICA'  )   as Mensaje
         return(1)
      end
      begin
         -- Genera Movimiento MODIFICA         
         begin tran
         delete CntError
         IF @@ERROR <> 0
         BEGIN
            SELECT @Control_Error = 1
            INSERT CntError (Mensaje) VALUES ('Modifica_Por_Cotizacion Borrando CntError')
            GOTO   FIN_PROCEDIMIENTO
         END

         update MoEncContrato 
            set MoNumContrato     = @NumContrato
              , MoTipoTransaccion = 'MODIFICA'
              , MoEstado          = ' '
              , MoFechaContrato   = @CaCaFechaContrato
              , MoFechaCreacionRegistro = GETDATE()
         where MoNumContrato = @NumCotizacion
         IF @@ERROR <> 0
         BEGIN
            SELECT @Control_Error = 1
            INSERT CntError (Mensaje) VALUES ('Modifica_Por_Cotizacion Generando Movimiento de Modificacion')
            GOTO   FIN_PROCEDIMIENTO
         END
        
         -- Eliminar la Cartera actual de @NumContrato
         delete CaEncContrato where CaNumContrato = @NumContrato
         IF @@ERROR <> 0
         BEGIN
            SELECT @Control_Error = 1
            INSERT CntError (Mensaje) VALUES ('Falla Modifica_Por_Cotizacion Eliminando Cartera Enc')
            GOTO   FIN_PROCEDIMIENTO
         END
         delete CaDetContrato where CaNumContrato = @NumContrato
         IF @@ERROR <> 0
         BEGIN
            SELECT @Control_Error = 1
            INSERT CntError (Mensaje) VALUES ('Falla Modifica_Por_Cotizacion Eliminando Cartera Det')
            GOTO   FIN_PROCEDIMIENTO
         END
         delete CaFixing      where CaNumContrato = @NumContrato 
         IF @@ERROR <> 0
         BEGIN
            SELECT @Control_Error = 1
            INSERT CntError (Mensaje) VALUES ('Falla Modifica_Por_Cotizacion Eliminando Fixing Enc')
            GOTO   FIN_PROCEDIMIENTO
         END
         delete CaCaja        where @NumContrato  = @NumContrato
         IF @@ERROR <> 0
         BEGIN
            SELECT @Control_Error = 1
            INSERT CntError (Mensaje) VALUES ('Falla Modifica_Por_Cotizacion Eliminando Cartera Caja')
            GOTO   FIN_PROCEDIMIENTO
         END


         update CaEncContrato 
            set CaNumContrato     = @NumContrato
              , CaTipoTransaccion = 'MODIFICA'
              , CaEstado          = ' '
              , CaFechaContrato   = @CaCaFechaContrato
         where CaNumContrato = @NumCotizacion
         IF @@ERROR <> 0
         BEGIN
            SELECT @Control_Error = 1
            INSERT CntError (Mensaje) VALUES ('Falla Modifica_Por_Cotizacion Generando Movimiento de Cartera Enc')
            GOTO   FIN_PROCEDIMIENTO
         END

         update CaDetContrato 
            set CaNumContrato     = @NumContrato
         where CaNumContrato = @NumCotizacion
         IF @@ERROR <> 0
         BEGIN
            SELECT @Control_Error = 1
            INSERT CntError (Mensaje) VALUES ('Falla Modifica_Por_Cotizacion Generando Movimiento de Cartera Det')
            GOTO   FIN_PROCEDIMIENTO
         END

         update CaFixing 
            set CaNumContrato     = @NumContrato
         where CaNumContrato = @NumCotizacion
         IF @@ERROR <> 0
         BEGIN
            SELECT @Control_Error = 1
            INSERT CntError (Mensaje) VALUES ('Falla Modifica_Por_Cotizacion Generando Movimiento de Cartera Fixing')
            GOTO   FIN_PROCEDIMIENTO
         END


         update CaCaja 
            set CaNumContrato     = @NumContrato
         where CaNumContrato = @NumCotizacion
         IF @@ERROR <> 0
         BEGIN
            SELECT @Control_Error = 1
            INSERT CntError (Mensaje) VALUES ('Falla Modifica_Por_Cotizacion Generando Movimiento de Cartera Caja')
            GOTO   FIN_PROCEDIMIENTO
         END
         select Convert( varchar(80) ,  'Cotizacion Realizada:' + convert( character(9) , @NumCotizacion ) + ' Sobre Contrato N° ' + convert( character(9), @NumContrato ) )   as Mensaje
         commit
         return(1)
      end
FIN_PROCEDIMIENTO:
        select Max( Mensaje ) from CntError  
        rollback    
	return(-1)
     			
END

GO
