USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Ini_Dia_Opc]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Ini_Dia_Opc](  @FechaApertura datetime , @FechaSigApertura datetime ,  @Usuario varchar(15) )
As Begin
   SET NOCOUNT ON

   BEGIN TRAN

   declare @FechaAnterior datetime
   select @FechaAnterior = fechaproc from opcionesgeneral TABLOCK 

   if @FechaAnterior = @FechaApertura 
   begin
      select convert( varchar(80) , 'Dia YA FUE Abierto OK' ) as Mensaje
      rollback
      return(0)      
   end

   -- Copiar lo vencido de Caja
   insert into CaVenCaja
   select * from cacaja where CaCajFecPago < @FechaApertura

   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Ini_Dia_Opc: Problemas al Insertar CaVenCaja' )
      rollback
      RETURN 1
   end
   -- Eliminar lo vencido de Caja
   delete cacaja where CaCajFecPago < @FechaApertura
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) ,'dbo.Sp_Ini_Dia_Opc: Problemas al Eliminar CaCaja' )
      rollback
      RETURN 1
   end

   -- Copiar los Fixing Obsoletos
   insert into CaVenFixing
   select Fix.*  from 
   CaFixing Fix , CaDetContrato Det
   where Fix.CaNumCOntrato = Det.CaNumCOntrato
      and Fix.CaNumEstructura = Det.CaNumEstructura
      and CaFechaPagoEjer < @FechaApertura
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) ,'dbo.Sp_Ini_Dia_Opc: Problemas al Insertar CaVenFixing' )
      rollback
      RETURN 1
   end

   -- Eliminar los Fixing Obsoletos
   delete CaFixing
   from CaFixing Fix , CaDetContrato Det
   where Fix.CaNumCOntrato = Det.CaNumCOntrato
      and Fix.CaNumEstructura = Det.CaNumEstructura
      and CaFechaPagoEjer < @FechaApertura
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Ini_Dia_Opc: Problemas al Eliminar CaFixing' )
      rollback
      RETURN 1
   end

   -- Copiar los Detalles Vencidos
   Insert into CaVenDetContrato
   select * from  CaDetContrato Det
      where Det.CaFechaPagoEjer < @FechaApertura
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Ini_Dia_Opc: Problemas al insertar CaVenDetContrato' )
      rollback
      RETURN 1
   end
   -- Eliminar los Detalles Vencidos
   delete CaDetContrato
      where CaFechaPagoEjer < @FechaApertura
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Ini_Dia_Opc: Problemas al Eliminar CaDetContrato' )
      rollback
      RETURN 1
   end
   -- Copiar los Encabezado con todos sus 
   -- Detalles vencidos.
   insert into CaVenEncContrato
   select * from CaEncContrato Enc
        where Enc.CaNumContrato not in
               -- Contratos con detalle vigente 
              ( select Det.CaNumContrato 
                from CaDetContrato Det where Det.CaFechaPagoEjer >= @FechaApertura )
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Ini_Dia_Opc: Problemas al insertar CaVenContrato' )
      rollback
      RETURN 1
   end
   -- Elimina los encabezados con todos sus
   -- Detalles vencidos
   delete CaEncContrato where CaNumContrato not in
               -- Contratos con detalle vigente 
              ( select Det.CaNumContrato 
                from CaDetContrato Det where Det.CaFechaPagoEjer >= @FechaApertura )
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Ini_Dia_Opc: Problemas al Eliminar CaEncContrato' )
      rollback
      RETURN 1
   end
   Update OpcionesGeneral  --select * from OpcionesGeneral
          set    fechaant =  @FechaAnterior
               , fechaproc = @FechaApertura
               , fechaprox = @FechaSigApertura
               , iniciodia = 1
               , CargaParamSudaCierre = 0
               , contabilidad = 0
               , devengo = 0
               , Fijacion = 0
               , findia = 0
               , CierreMesa = 1        -- Se dejará la mesa cerrada para que nada entre
                   -- hasta que Back-Office de el vamos 

   IF @@ERROR <> 0 
 Begin
      select convert( varchar(80) , 'dbo.Sp_Ini_Dia_Opc: Problemas al Actualizar OpcionesGeneral' )
      rollback
      RETURN 1
   end

   -- Solo se borran los contratos que ya cumplieron
   -- su fecha de curse.

   Delete	 MoDetContrato
   from MoDetContrato Det, MoEncContrato Enc
   where Det.MoNumFolio = Enc.MoNumFolio 
   and   MoFechaContrato < @FechaApertura
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Ini_Dia_Opc: Problemas al Eliminar MoDetContrato' )
      rollback
     RETURN 1
   end

   Delete	 MoFixing
   from MoFixing Fix , MoEncContrato Enc
   where Fix.MoNumFolio = Enc.MoNumFolio 
   and   MoFechaContrato < @FechaApertura
 
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Ini_Dia_Opc: Problemas al Eliminar MoFixing' )
      rollback
      RETURN 1
   end

   Delete	 MoCaja
   from MoCaja Caja , MoEncContrato Enc
   where Caja.MoNumFolio = Enc.MoNumFolio 
   and   MoFechaContrato < @FechaApertura
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Ini_Dia_Opc: Problemas al Eliminar MoCaja' )
      rollback
      RETURN 1
   end

   Delete	 MoEncContrato
   where MoFechaContrato < @FechaApertura
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Ini_Dia_Opc: Problemas al Eliminar MoEncContrato' )
      rollback
      RETURN 1
   end


   -- POR HACER Captura de Error Potencial del proceso
   -- Exec dbo.Sp_Aplica_Contratos_del_Dia @FechaApertura
   -- pendiente: CONTROL DE ERROR

   commit
    select convert( varchar(80) , 'Dia Abierto OK' ) as Mensaje
   return(0)
End
GO
