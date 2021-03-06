USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIA_DECISION]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CAMBIA_DECISION]	(	@NumContrato numeric(8)   
										,	@NumComponente numeric(6)   
										,	@CajFolio      numeric(8)  
										,	@Usuario Varchar(15) 
										,	@Estado Varchar(1) )   
  
AS BEGIN     
   
   SET NOCOUNT ON  
/**********************************************************  
Estado Ejercido a No Ejercido. E -> N.   
Será posible solamente si el registro de caja no ha sido   
generado al motor de Pagos de BAC ya que deberán ser eliminados   
al hacer que la opción quede no ejercida. Además la opción   
debe tener modalidad “Entrega Fisica”.  
Estado No Ejercido a Pendiente. N -> P.   
Solo cambiará el estado.  
Estado Ejercido a estado Pendiente. E -> P.   
Será posible solamente si el registro de caja no ha sido   
generado al motor de Pagos de BAC ya que deberán ser   
eliminados al hacer que la opción quede no ejercida.  
***********************************************************/  
-- MAP 04 Nov. 2009 Cambios Decision para comp. es para todos los componentes  
--                  Cambios Decision para Entrega fisica es para un solo comp.  
--                  Con los lnkServer tal como están no se puede mantener   
--                  integridad referencial  
-- Pruebas internas  
  
  
   declare @EstAnt             VarChar(1)  
   declare @msg                VarChar(80)  
   declare @FchCon             datetime  
   declare @EstadoMotor        VarChar(1)  
   declare @CaCajModalidad     varchar(1)  
   declare @CaVinculacion      Varchar(12)  
   declare @nregs              numeric(3)  
   declare @ncont              numeric(3)  
   declare @MotorBAC           Varchar(1)  
   declare @EstaSpot           Varchar(1)  
   declare @Er                 Varchar(2)  
   declare @proceso            datetime  
  
  
	select	@EstAnt = ' '  
	select	@EstAnt = CaCajEstado    
	FROM	CaCaja cc
	WHERE	cc.CaNumContrato	=	@NumContrato
	AND		cc.CaNumEstructura	=	@NumComponente
	AND		cc.CaCajFolio		=	@CajFolio

	if @EstAnt = 'E' and @Estado = 'E' begin  
	   select @msg = Convert( varchar(80) ,  'Estado ya aplicado' )   
	   Goto FinSinCambios  
	end  
  
  
  
   select @proceso = fechaproc   
     From Opcionesgeneral  
   
   select @msg    = ' '  
  
   select   CaCajEstado    
          , CaCajModalidad  
          , CaVinculacion   
          , Caj.CaNumContrato  
          , Caj.CaNumEstructura  
          , registrocorrelativo = identity(INT)  
   into #Componentes  
   from CaCaja Caj, CaDetContrato Det      
   where Caj.CaNumContrato = @NumContrato  
      AND @NumComponente in ( 0, Caj.CaNumEstructura )  
      and Det.CaNumContrato   = Caj.CaNumContrato  
      and Det.CaNumEstructura = Caj.CaNumEstructura  
  
   SELECT  @nregs       = MAX(registrocorrelativo),  
           @ncont       = MIN(registrocorrelativo)  
      FROM #Componentes  
  
   WHILE @ncont <= @nregs   
   begin  
      select @msg    = ' '  
      select @EstAnt = ' '  
      select   @EstAnt = CaCajEstado    
          ,    @CaCajModalidad = CaCajModalidad  
          ,    @CaVinculacion  = CaVinculacion from #Componentes      
      where RegistroCorrelativo = @ncont  
      if @@rowcount = 0 begin  
        select @msg = Convert( varchar(80) ,  'Caja No Existe' )   
        Goto FinSinCambios  
      end  
      if @CaCajModalidad = 'C' begin  
         select @MotorBAC = 'P'  -- Si no hay registro en Motor es como pendiente  
         select @MotorBAC = estado_envio from bacparamsuda.dbo.VIEW_MOTOR 
         where sistema = 'OPT'   
               and fecha = @proceso  
               and numero_operacion = @NumContrato  
         if @MotorBAC = 'E' and @EstAnt = 'E'   
         begin  
            select @msg = Convert( varchar(80) ,  'Error ya Enviado en Motor de Pagos' )   
            Goto FinSinCambios  
         end   
      end  
      else  -- Entrega Fisica  
      begin  
         if @EstAnt = 'E'  and @Estado <> 'E'  
         begin  
            select @EstaSpot = 'N'  
            select @EstaSpot = 'S'    
               from lnkBac.BacCamSuda.dbo.TBVencimientosForward  
               where moTerm = 'OPCIONES'  
                 and monumfut = ( @NumContrato * 10 + @NumComponente )  
            if @EstaSpot = 'S'  
               delete lnkBac.BacCamSuda.dbo.TBVencimientosForward  
               where moTerm = 'OPCIONES'  
                 and monumfut = ( @NumContrato * 10 + @NumComponente )  
            else  
            begin  
               select @msg = Convert( varchar(80) ,  'Error ya se cargo Op.de Cambios' )   
               Goto FinSinCambios  
            end  
         end  
         else   
         begin  
            if @EstAnt = 'E' and @Estado = 'E' begin  
               select @msg = Convert( varchar(80) ,  'Estado ya aplicado' )   
               Goto FinSinCambios  
            end  
         end  
      end  
      select @ncont = @ncont + 1  
   end -- While  
   if @Estado = 'E' Begin  
      if @CaCajModalidad = 'E' and @EstAnt <> 'E'  
      begin  
        declare @cierremesa CHAR(01)  
  
        select @cierremesa = SUBSTRING(ACLOGDIG,6,1) from lnkBac.BacCamSuda.dbo.meac  
  
        if (@cierremesa = '1')  
        BEGIN  
               select @msg = Convert( varchar(80) ,  'La mesa de Cambios ya fue cerrada' )   
               Goto FinSinCambios  
        END  
  
         delete OpcEntFis where usuario = @Usuario  
         exec Sp_Genera_EntregaFisica @NumContrato    
                                   ,  @NumComponente    
                                   ,  @CajFolio        
                                   ,  @Usuario         
           
         select @Er  = Estado   
              , @msg = Mensaje from OpcEntFis where usuario = @Usuario  
         if @Er = 'ER'  
         begin  
               select @msg = Convert( varchar(80) ,  @Msg )   
               Goto FinSinCambios  
         end   
      end  
   end  
  
   if @CaCajModalidad = 'E' begin  
      Update CaCaja   
        Set CaCajEstado = @Estado  
        where CaNumContrato = @NumContrato  
        and CaNumEstructura = @NumComponente  
        and CaCajFolio      = @CajFolio  
      IF @@ERROR <> 0  
      BEGIN  
         select @Msg = @msg + convert( varchar(80) ,  'Sp_Cambia_Desicion: ERROR' )   
         Goto FinConRollBack              
      END  
   end  
   else  
   begin -- Actualiza todos los componentes  
      Update CaCaja   
        Set CaCajEstado = @Estado   --select * from cacaja  
        where CaNumContrato = @NumContrato          
      IF @@ERROR <> 0  
      BEGIN  
         select @Msg = @msg + convert( varchar(80) ,  'Sp_Cambia_Desicion: ERROR' )   
         Goto FinConRollBack              
      END  
   end  
     
   select @msg = @msg + Convert( varchar(80) ,  ' Flujo en Estado ' + @Estado + ' Exitosamente' )   
   Goto FinConCommit              
  
FinSinCambios:  
    select 'Estado'        = Convert( varchar(2) , 'ER' )  
         , 'Mensaje'       = Convert( varchar(80) , @Msg )  
         , 'NumContrato'   = @NumContrato  
         , 'NumComponente' = @NumComponente  
         , 'FolioCaja'     = @CajFolio  
    return(1)  
  
FinConRollBack:  
    select 'Estado'        = Convert( varchar(2) , 'ER' )  
         , 'Mensaje'       = Convert( varchar(80) , @Msg )  
         , 'NumContrato'   = @NumContrato  
         , 'NumComponente' = @NumComponente  
         , 'FolioCaja'     = @CajFolio  
    -- rollback MAP 04 Nov. 2009  
    return(1)  
  
FinConCommit:  
    select 'Estado'        = Convert( varchar(2) , 'OK' )  
         , 'Mensaje'       = Convert( varchar(80) , @Msg )  
         , 'NumContrato'   = @NumContrato  
         , 'NumComponente' = @NumComponente  
         , 'FolioCaja'     = @CajFolio  
    -- Commit MAP 04 Nov. 2009  
    return(1)  
          
END  

GO
