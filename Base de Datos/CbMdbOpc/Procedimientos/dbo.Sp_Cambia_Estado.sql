USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Cambia_Estado]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Sp_Cambia_Estado] ( @NumContrato numeric(10) , @Usuario Varchar(15) , @Estado Varchar(1) )   
  
AS BEGIN     
     
   SET NOCOUNT ON  
  
   declare @EstAnt             VarChar(1)  
   declare @msg                VarChar(80)  
   declare @FchCon             datetime  
   declare @HayVcto            Varchar(1)  
   declare @Proceso            datetime  
   declare @Estructura         varchar(10)  
   declare @TipoTransaccion    varchar(17)  
   declare @cierreMesa         numeric(1)  
   -- Sp_Cambia_Estado 780 , 'ADMINISTRA', 'N'  
   -- Sp_Cambia_Estado 5822, 'ADMINISTRA', 'N'  -- Preparando anticipo
   select @cierreMesa = 0  
  
  
   select @EstAnt = ' '  
   select  @EstAnt = CaEstado  
         , @FchCon = CaFechaContrato   
         , @Estructura = CaCodEstructura    
           from CaEncContrato where CaNumContrato = @NumContrato    
   if @@rowcount = 0 begin  
      select Convert( varchar(80) ,  'Contrato No Existe' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
      return(1)  
   end  
  

   select  @Proceso = fechaproc   
         , @cierreMesa = cierreMesa from opcionesgeneral  
   if @@rowcount = 0 begin  
      select Convert( varchar(80) ,  'No se pudo leer fecha Proceso' ) as Mensaje , @NumContrato as Contrato, @FchCon as FechaContrato  
      return(1)  
   end     

   /* Mnavarro 20160327  */
   /* Ya no */
   declare @bloqueoAnticipo numeric(1)
   set @bloqueoAnticipo = ( select convert( numeric(1), max(tbvalor) ) from BacParamSuda.dbo.TABLA_GENERAL_DETALLE where tbcateg = 28 )
   if  @Estado = 'N' and @Estructura in (8) and @bloqueoAnticipo = 1
   Begin
      select Convert( varchar(80) ,  'Error: F. Americano solo se EJERCE' ) as Mensaje , @NumContrato as Contrato, @FchCon as FechaContrato  
      return(1)  
   End
  
  
   if @EstAnt = 'C' begin -- and @Estado <> 'U' begin
      select Convert( varchar(80) ,  'Error: Es Cotización' ) as Mensaje , @NumContrato as Contrato, @FchCon as FechaContrato  
      return(1)  
   end  
  
  
  
   if @cierreMesa = 1 begin  
      select Convert( varchar(80) ,  'Error: Mesa Cerrada' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
      return(1)  
   end    
  
   if @EstAnt = @Estado Begin  
      select Convert( varchar(80) ,  'Contrato Ya Preparado' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
      return(1)  
   end  
  
  
  
   if @Estado = 'U'  begin -- Prepara anulación , solo en la fecha de proceso  
      if @FchCon <> @Proceso begin  
         select Convert( varchar(80) ,  'Error: Contrato no es del dia' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
         return(1)   
      end  
   end  
  
   if @Estado = 'M'  begin -- Prepara Modificacion , otra fecha   
      if @FchCon = @Proceso begin  
         select Convert( varchar(80) ,  'Error: Contrato es del dia' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
         return(1)   
      end  
  
      select @HayVcto = ''  
      select @HayVcto = 'S' from CaDetContrato where   CaNumContrato = @NumCOntrato   
                                                    and (    CaFechaFijacion = @Proceso                  
                                                          or CaFechaVcto = @Proceso  
                                                          or CaFechaPagoEjer = @Proceso )  
      if @HayVcto = 'S' begin  
         select Convert( varchar(80) ,  'Error: Contrato con Vcto.' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
         return(1)   
      end  
  
   end  
  
   if @Estado = 'N'  begin -- Prepara anticipo , solo en la fecha de proceso  
      if @FchCon = @Proceso begin  
         select Convert( varchar(80) ,  'Error: Contrato  es del dia' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
         return(1)   
      end  
  
      select @HayVcto = ''  
      select @HayVcto = 'S' from CaDetContrato where   CaNumContrato = @NumCOntrato   
                                                    and (    CaFechaFijacion = @Proceso                  
                                                          or CaFechaVcto = @Proceso  
                                                          or CaFechaPagoEjer = @Proceso )  
      if @HayVcto = 'S' begin  
         select Convert( varchar(80) ,  'Error: Contrato con Vcto.' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
         return(1)   
      end  
   
  /*  
       if @Estructura <> '0' begin  
         select Convert( varchar(80) ,  'Temporalmente no se anticipan estructuras' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
         return(1)   
      end  
  */  
      if    @TipoTransaccion = 'ANTICIPA'   
      begin  
         select Convert( varchar(80) ,  'Error: Contrato ya Anticipado' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
         return(1)   
      end   
  
      if @TipoTransaccion = 'MODIFICA'  
      begin  
         select Convert( varchar(80) ,  'Error: Contrato ya Modificado' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
         return(1)   
      end   
  
  
   end  
     
   BEGIN TRAN  
   Update CaEncContrato   
          set CaEstado    = @Estado where CaNumContrato = @NumCOntrato  
   IF @@ERROR <> 0  
      BEGIN  
         select convert( varchar(80) ,  'Sp_Cambia_Estado: ERROR' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
         rollback  
         RETURN(2)  
      END  
   ELSE  
      BEGIN  
         commit  
         select convert( varchar(80) ,  'Preparado OK' ) as Mensaje, @NumContrato as Contrato, @FchCon as FechaContrato  
         RETURN(0)           
      END  
  
  
          
END  

-- Altereado en producción 27 Marzo 2016

GO
