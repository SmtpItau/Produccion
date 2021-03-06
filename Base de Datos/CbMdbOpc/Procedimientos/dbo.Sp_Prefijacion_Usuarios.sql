USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Prefijacion_Usuarios]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Prefijacion_Usuarios](@usuario Varchar(15) output) 
--Sp_Prefijacion_Usuarios "Lguerra"
--select * from pre_fijacion
--Drop procedure Sp_Prefijacion_Usuarios
As Begin  
   SET NOCOUNT ON  
   

   declare @HayErrorValidacion Numeric(10)       
   -- En este proceso no habrá validación  
   select @HayErrorValidacion = 1  
     
   declare @hayregistro numeric(1)  
   select  @hayregistro = 0  
   select  @hayregistro = 1, @usuario = usuario
    from PRE_FIJACION Where @usuario <> usuario
 
   IF @@ERROR <> 0  
   BEGIN  
      select convert( varchar(80) ,  'Sp_Prefijacion_Usuarios: ERROR' )
      rollback  
      RETURN 1  
   end   
   ELSE Begin  
      select  @HayErrorValidacion = ( case when @hayregistro = 0 then 1 else 0 end )  
      if @HayErrorValidacion = 1 begin  
          select convert( varchar(80) , '' ) as result
          RETURN 3  
      end  
      else begin    
         select convert( varchar(80) , 'OK' ) as result
         , @usuario as usuario
         RETURN 0  
      end  
   END  

End

GO
