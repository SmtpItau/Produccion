USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[sp_Cierre_Abre_Mesa]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_Cierre_Abre_Mesa 'freddy'  
--update MoEncContrato set moEstado='P' where monumcontrato=8388
--select  * from MoEncContrato where moEstado in ( 'P' )         
--select * from CbMdbOpc.dbo.CaDetContrato where CaMdaCompensacion=0 and CaModalidad='C'
--update CbMdbOpc.dbo.CaDetContrato set CaMdaCompensacion=0 where CaNumContrato=7754

CREATE PROC [dbo].[sp_Cierre_Abre_Mesa] ( @Usuario Varchar(15) )          -- sp_Helptext sp_Cierre_Abre_Mesa        
        
AS BEGIN           
   --- sp_Cierre_Abre_Mesa "PPPPPP"         
   -- MAP 09 NOv. 2009 Control sobre Operaciones anuladas se debe descartar        
   -- MAP 12 Nov. 2009 Desiciones Pendientes debe quedar como Warning, hasta que se pueda fijar con la mesa abierta        
   SET NOCOUNT ON        
        
   declare @HayErrorValidacion Numeric(10)        
   declare @Accion varchar(200)      
   declare @EspecificarFalta  varchar(200)      
   declare @Aux               varchar(200)      
   declare @ForwardMesaCerrada Numeric(1)      
         
   -- En este proceso no habrá validación        
   select @HayErrorValidacion = 0        
   select @EspecificarFalta   = ''        
        
   if ( select CierreMesa from OpcionesGeneral ) = 0         
       select @Accion = 'Cierre'        
   else         
       select @Accion = 'Apertura'        
        
   -- PROD 13028      
   Select @ForwardMesaCerrada = AcSw_CieMeFwd from LnkBac.BacFwdSuda.dbo.Mfac      
   select @EspecificarFalta = case when @ForwardMesaCerrada = 1 and @Accion = 'Apertura'       
                      then 'Abrir Mesa en BacForward ' else '' end       
      
   declare @HayOperacionesPendientes integer        
   select  @HayOperacionesPendientes = 0        
   if  @Accion = 'Cierre'         
   Begin        
          /* select @EspecificarFalta = '' */ -- PROD 13028      
          select @Aux              = ''        
          select  @HayOperacionesPendientes = 1, @EspecificarFalta = @EspecificarFalta + 'Error: Hay Op. PREPARADAS'      
                  from CaEncContrato where CaEstado in (  'N', 'M', 'U','E')      
          select  @HayOperacionesPendientes = 1, @Aux = ' Error: Hay Op. PENDIENTES Control Fin.'         
                  from MoEncContrato where moEstado in ( 'P' )         
                    and MoNumContrato not in ( select MoNumContrato from MoEncContrato where MoTipoTransaccion = 'ANULA' )  -- MAP 09 NOv. 2009        
          select @EspecificarFalta = rtrim( @EspecificarFalta ) + rtrim( @Aux )        
          select @Aux              = ''        
                
          select  @HayOperacionesPendientes = 1, @Aux = 'Error: Faltan Fijaciones ' + convert( varchar(10) , CaFixFecha , 104 )       
		  from caFixing       
                , OpcionesGeneral        
                where CaFixFecha <= fechaproc  and CaFixEstado = ''       
			and CaNumContrato not in (select distinct MoNumContrato from MoEncContrato where MoTipoTransaccion = 'ANTICIPA') --ASVG_20130719 PRD_12567 No se puede fijar operación con Anticipo

          select @EspecificarFalta = rtrim( @EspecificarFalta ) + rtrim( @Aux )        
          select @Aux              = ''        
              
          select distinct  @HayOperacionesPendientes = @HayOperacionesPendientes, @EspecificarFalta = @EspecificarFalta + ' Advertencia: Decisiones de ejercicio Pendientes '  -- MAP 12 Nov. 2009        
               from CaCaja where CaCajEstado = 'P'        
			   
		  select @Aux = ' Operacion sin moneda de compensacion ' 
		  from CbMdbOpc.dbo.CaDetContrato where CaMdaCompensacion=0 and CaModalidad='C'

          select @EspecificarFalta = rtrim( @EspecificarFalta ) + rtrim( @Aux )        
          select @Aux              = ''        

   end        

   if  @HayOperacionesPendientes = 0 and @EspecificarFalta = ''      
   Begin        
      Begin tran        
      Update OpcionesGeneral         
          set cierreMesa    = case when cierreMesa = 0 then 1 else 0 end         
             , findia       = 0         
             , devengo      = 0        
             , contabilidad = 0        
             , iniciodia    = 1   -- MAP 12 Septiembre Se deshace el cierre de dia, esto queda Apagado.        
      IF @@ERROR <> 0        
      Begin        
         select convert( varchar(80) ,  'dbo.sp_Cierre_Abre_Mesa: UPdate OpcionesGeneral ERROR' ) as MsgStatus        
         rollback        
         RETURN 1        
      end         
      /* if @Accion = 'Cierre' -- Se quiere Cerrar        
      Begin        
         declare @ErrorProc int        
         Exec @ErrorProc  = Sp_ImportaDataBacParamSuda        
      End        
      IF @ErrorProc <> 0        
      Begin                 
         select convert( varchar(80) ,  'Faltan Parametros de Cierre' ) as MsgStatus        
         rollback        
         RETURN 1        
      end */ -- Se traspasa al proceso contable     
        
      IF @@ERROR <> 0        
      BEGIN        
         select convert( varchar(80) ,  'dbo.sp_Cierre_Abre_Mesa: ERROR' ) as MsgStatus        
         rollback        
        RETURN 1        
      end         
      ELSE Begin        
         if @HayErrorValidacion = 1 begin        
            select convert( varchar(80) , 'sp_Cierre_Abre_Mesa: ERROR' ) as MsgStatus        
            rollback        
            RETURN 3        
         end        
         else begin        
            commit        
            select convert( varchar(80) , @Accion + ' Mesa OK ' + '.' +  @EspecificarFalta ) as MsgStatus        
            RETURN 0        
         end        
      END        
              
   end        
   else begin        
      select convert( varchar(200) ,  @EspecificarFalta ) as MsgStatus      
   end        
                
END
GO
