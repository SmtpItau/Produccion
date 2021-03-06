USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_OpcionesGeneral_Fechas]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_OpcionesGeneral_Fechas]
 (   @fechaproc datetime output
   , @fechaant datetime  output
   , @fechaprox datetime output
   , @iniciodia int output   
  )

/* Ejem´plo de ejecución desde SQL Server u otro Store Procedure
    declare  @fechaproc datetime
    declare  @fechaAnt  datetime
    declare  @fechaprox datetime  
  exec Sp_OpcionesGeneral_Fechas  @fechaproc output , @fechaAnt output  ,  @fechaprox output
  select '(output)'
         , '@fechaproc', @fechaproc as fecha1 
         ,  '@fechaAnt', @fechaAnt as fecha2
         ,  '@fechaprox',  @fechaprox as fecha3
*/
As Begin  
   SET NOCOUNT ON  
   

   declare @HayErrorValidacion Numeric(10)       
   -- En este proceso no habrá validación  
   select @HayErrorValidacion = 1  
   
   declare @cierreMesa  char(1)
   declare @hayregistro numeric(1)  
   declare @findia int
   select  @hayregistro = 0  

   select  @hayregistro = 1
          , @fechaproc = fechaproc
          , @fechaant = fechaant
          , @fechaprox = fechaprox
          , @iniciodia = iniciodia
          , @cierreMesa = CierreMesa
          , @findia = findia 
    from OpcionesGeneral
 
   IF @@ERROR <> 0  
   BEGIN  
      select 'Status' = convert( varchar(80) ,  'Sp_OpcionesGeneral_Fechas: ERROR' )
      , @fechaproc as fechaproc, @fechaant as fechaant, @fechaprox as fechaprox, @iniciodia as iniciodia, @cierreMesa as CierreMesa, @findia as findia
      rollback  
      RETURN 1  
   end   
   ELSE Begin  
      select  @HayErrorValidacion = ( case when @hayregistro = 0 then 1 else 0 end )  
      if @HayErrorValidacion = 1 begin  
          select 'Status' = convert( varchar(80) , 'Sp_OpcionesGeneral_Fechas: ERROR, Registro vacío' )
          , @fechaproc as fechaproc, @fechaant as fechaant, @fechaprox as fechaprox, @iniciodia as iniciodia, @cierreMesa as CierreMesa, @findia as findia
         RETURN 3  
      end  
      else begin    
         select 'Status' = convert( varchar(80) , 'OK' )
         , @fechaproc as fechaproc, @fechaant as fechaant, @fechaprox as fechaprox, @iniciodia as iniciodia, @cierreMesa as CierreMesa, @findia as findia
         RETURN 0  
      end  
   END  

End  

GO
