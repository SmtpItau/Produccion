USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_OpcionesGeneral_Mesa]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_OpcionesGeneral_Mesa]
(@dFecha DATETIME)

As Begin  
   SET NOCOUNT ON  
   
   declare @Mesa Numeric(1)
   declare @HayErrorValidacion Numeric(10)       
   -- En este proceso no habrá validación  
   select @HayErrorValidacion = 1  
     
   declare @hayregistro numeric(1)  
   select  @hayregistro = 0  
   select  @hayregistro = 1, @Mesa = cierreMesa
    from OpcionesGeneral
 
   IF @@ERROR <> 0  
   BEGIN  
      select convert( varchar(80) ,  'Sp_OpcionesGeneral_Mesa: ERROR' )
      , @Mesa as CierreMesa
      rollback  
      RETURN 1  
   end   
   ELSE Begin  
      select  @HayErrorValidacion = ( case when @hayregistro = 0 then 1 else 0 end )  
      if @HayErrorValidacion = 1 begin  
          select convert( varchar(80) , 'Sp_OpcionesGeneral_Mesa: ERROR, Registro vacío' )
          , @Mesa as CierreMesa
         RETURN 3  
      end  
      else begin    
         select convert( varchar(80) , 'OK' )
         , @Mesa as CierreMesa
         RETURN 0  
      end  
   END  

End  

GO
