USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Fin_Dia_Opc]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Fin_Dia_Opc]

As Begin
   -- Sp_Fin_Dia_Opc
   -- MAP 2010 Mayo 07
   -- En el traspaso de submodelo de movimientos histórico se eliminan los historicos copiados 
   -- cierre anterior (el proceso de cierre debe ser idempotente). La condición de este borrado cambió
   -- en el filtro de información.
   -- En el insert se eliminan las condiciones pues del submodelo de movimiento debe ser traspasado
   -- completo al submodelo de movimiento histórico.
   -- Chequeo de fecha de los movimientos para implementar idempotencia del proceso.
   -- Status: borrar Base de datos , abrir y cerrar dias una y otra vez.

   SET NOCOUNT ON

   declare @HayErrorValidacion Numeric(10)
   declare @hayregistro numeric(1)
   declare @fechaproc   datetime
   
   -- En este proceso habrá validación
   select @HayErrorValidacion = 0

   select @HayErrorValidacion = case when contabilidad = 1 then 0 else 1 end 
   from OpcionesGeneral
   
   if @HayErrorValidacion = 1 begin
      select convert( varchar(80) , 'Error: Falta Contabilizar' ) as MsgStatus
      RETURN 3
   end

   Begin tran

   select  @fechaproc = fechaproc from OpcionesGeneral
 
   -- Condición que se dará en desarrollo
   if @fechaproc <> getdate() - ( getdate() - convert( varchar(8) , getdate(), 112 ) )
   Begin
      update MoEncContrato 
		set MoFechaCreacionRegistro = @fechaproc + ( getdate() - convert( varchar(8) , getdate(), 112 ) )

   End  



   delete CaResEncContrato  where CaEncFechaRespaldo    = @fechaproc
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al borrar CaResEncContrato' ) as MsgStatus
      rollback
      RETURN 1
   end 

   delete CaResDetContrato  where CaDetFechaRespaldo    = @fechaproc
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al borrar CaResDetContrato' ) as MsgStatus
      rollback
      RETURN 1
   end 

   delete CaResFixing       where CaFixingFechaRespaldo = @fechaproc
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al borrar CaResFixing' ) as MsgStatus
      rollback
      RETURN 1
   end 

   Delete CaResCaja         where CaCajaFechaRespaldo   = @fechaproc
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al borrar CaResCaja' ) as MsgStatus
      rollback
      RETURN 1
   end 

   insert into CaResEncContrato
   select CaEncFechaRespaldo    = @fechaproc, * from CaEncContrato
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al insertar CaResEncContrato' ) as MsgStatus
      rollback
      RETURN 1
   end 

   insert into CaResDetContrato
   select CaDetFechaRespaldo    = @fechaproc, * from CaDetContrato
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al insertar CaResDetContrato' ) as MsgStatus
      rollback
      RETURN 1
   end 

   insert into CaResFixing
   select CaFixingFechaRespaldo = @fechaproc, * from CaFixing
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al Insertar CaResFixing' ) as MsgStatus
      rollback
      RETURN 1
   end 

   insert into CaResCaja
   select CaCajaFechaRespaldo   = @fechaproc, * from CaCaja

   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al Insertar CaResCaja' ) as MsgStatus
      rollback
      RETURN 1
   end 

   delete MoHisCaja 
   from MoHisCaja Caja, MoEncContrato Enc
   where      Caja.MoNumFolio = Enc.MoNumFolio
--         and  Enc.MoFechaContrato = @fechaproc  -- MAP 2010 Mayo 07
          and datepart( yyyy, Enc.MoFechaCreacionRegistro ) = datepart( yyyy, @fechaproc )  -- MAP 2010 Mayo 07
          and datepart( mm, Enc.MoFechaCreacionRegistro ) = datepart( mm, @fechaproc )    -- MAP 2010 Mayo 07
          and datepart( d, Enc.MoFechaCreacionRegistro ) = datepart( d, @fechaproc )        -- MAP 2010 Mayo 07

   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al borrar MoHisCaja' ) as MsgStatus
      rollback
      RETURN 1
   end 

   insert into MoHisCaja
   select Caja.* from MoCaja Caja  -- , MoEncContrato Enc  -- MAP 2010 Mayo 07
--   where      Caja.MoNumFolio = Enc.MoNumFolio           -- MAP 2010 Mayo 07
--          and  Enc.MoFechaContrato = @fechaproc          -- MAP 2010 Mayo 07

   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al Insertar MoHisCaja' ) as MsgStatus
      rollback
      RETURN 1
   end 

   delete MoHisDetContrato  
   from   MoHisDetContrato Det, MoEncContrato Enc
   where  Det.MoNumFolio = Enc.MoNumFolio
--         and Enc.MoFechaContrato = @fechaproc                                             -- MAP 2010 Mayo 07
          and datepart( yyyy, Enc.MoFechaCreacionRegistro ) = datepart( yyyy, @fechaproc )  -- MAP 2010 Mayo 07
          and datepart( mm, Enc.MoFechaCreacionRegistro ) = datepart( mm, @fechaproc )      -- MAP 2010 Mayo 07
          and datepart( d, Enc.MoFechaCreacionRegistro ) = datepart( d, @fechaproc )        -- MAP 2010 Mayo 07

   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al borrar MoHisDetContrato' ) as MsgStatus
      rollback 
      RETURN 1
   end 

   insert into MoHisDetContrato
   select Det.* from MoDetContrato Det -- , MoEncContrato Enc -- MAP 2010 Mayo 07 
--   where      Det.MoNumFolio = Enc.MoNumFolio               -- MAP 2010 Mayo 07
--         and  Enc.MoFechaContrato = @fechaproc              -- MAP 2010 Mayo 07


   IF @@ERROR <> 0 
   Begin
select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al insertar MoHisDetContrato' ) as MsgStatus
      rollback
      RETURN 1
   end 

   delete MoHisFixing       
   from   MoHisFixing Fix , MoEncContrato Enc                   
   where  Fix.MoNumFolio = Enc.MoNumFolio
--         and Enc.MoFechaContrato = @fechaproc                                             -- MAP 2010 Mayo 07
          and datepart( yyyy, Enc.MoFechaCreacionRegistro ) = datepart( yyyy, @fechaproc )  -- MAP 2010 Mayo 07
          and datepart( mm, Enc.MoFechaCreacionRegistro ) = datepart( mm, @fechaproc )      -- MAP 2010 Mayo 07
          and datepart( d, Enc.MoFechaCreacionRegistro ) = datepart( d, @fechaproc )        -- MAP 2010 Mayo 07

   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al borrar MoHisFixing' ) as MsgStatus
      rollback
      RETURN 1
   end 


   insert into MoHisFixing
   select Fix.* from MoFixing Fix -- , MoEncContrato Enc                                    -- MAP 2010 Mayo 07
--   where      Fix.MoNumFolio = Enc.MoNumFolio                                             -- MAP 2010 Mayo 07
--         and  Enc.MoFechaContrato = @fechaproc                                            -- MAP 2010 Mayo 07

   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al insertar MoHisFixing' ) as MsgStatus
      rollback
      RETURN 1
   end 

   delete MoHisEncContrato  
   --    where MoFechaContrato = @fechaproc                                                 -- MAP 2010 Mayo 07
        where datepart( yyyy, MoFechaCreacionRegistro ) = datepart( yyyy, @fechaproc )  -- MAP 2010 Mayo 07
          and datepart( mm, MoFechaCreacionRegistro ) = datepart( mm, @fechaproc )      -- MAP 2010 Mayo 07
          and datepart( d,  MoFechaCreacionRegistro ) = datepart( d, @fechaproc )        -- MAP 2010 Mayo 07

   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al borrar MoHisEncContrato' ) as MsgStatus
      rollback
      RETURN 1
   end 

   insert into MoHisEncContrato
   select Enc.* from MoEncContrato Enc 
   -- where      Enc.MoFechaContrato = @fechaproc                                            -- MAP 2010 Mayo 07
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al insertar MoEncContrato' ) as MsgStatus
      rollback
      RETURN 1
   end 

   Update OpcionesGeneral 
      set  findia = 1  
         , iniciodia = 0
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al Actualiza OpcionesGeneral' ) as MsgStatus
      rollback
      RETURN 1
   end 

   delete OpcionesResgeneral
       where fechaproc = @fechaproc
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al Borrar OpcionesRESGeneral' ) as MsgStatus
      rollback
      RETURN 1
   end 


   insert into OpcionesResGeneral
   select * from OpcionesGeneral 
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_Fin_Dia_Opc: Problemas al insertar OpcionesRESGeneral' ) as MsgStatus
      rollback
      RETURN 1
   end 


   commit
   select convert( varchar(80) , 'Dia Cerrado OK' ) as MsgStatus
   RETURN 0
   

End

/*
select distinct CaEncFechaRespaldo, * from caResENcContrato
select distinct CaDetFechaRespaldo, * from CaResDetContrato
select distinct CaFixingFechaRespaldo, *  from CaResFixing
Select distinct CaCajaFechaRespaldo, * from CaResCaja


select * from moEncContrato
select * from moDetContrato
select * from moFixing
select * from moCaja

select * from moHisEncContrato
select * from moHisDetContrato
select * from moHisFixing
select * from moHisCaja

*/

GO
