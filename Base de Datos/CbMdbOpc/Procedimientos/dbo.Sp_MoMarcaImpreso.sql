USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MoMarcaImpreso]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- PRUEBA 1, 0
-- PRUEBA 0, 1
-- PRUEBA 0, 0 
-- Sp_MoMarcaImpreso 1

CREATE PROCEDURE [dbo].[Sp_MoMarcaImpreso] ( @MoNumFolio numeric(8) ) 

As Begin
   SET NOCOUNT ON

   declare @HayErrorValidacion Numeric(10)
   
   -- En este proceso no habrá validación
   select @HayErrorValidacion = 0
   
   Begin tran

   declare @hayregistro numeric(1)
   select  @hayregistro = 0
   select  @hayregistro = 1  from MoEncContrato where MoNumFolio = @MoNumFolio
   select  @HayErrorValidacion = ( case when @hayregistro = 0 then 1 else 0 end )

   

   Update MoEncContrato set moImpreso = 'S'  where MoNumFolio = @MoNumFolio

 --  select 1 / 0

   IF @@ERROR <> 0
   BEGIN
      select convert( varchar(80) ,  'Sp_MoMarcaImpreso: ERROR' )
      rollback
      RETURN 1
   end 
   ELSE Begin
      if @HayErrorValidacion = 1 begin
         select convert( varchar(80) , 'Folio No Existe' )
         rollback
         RETURN 3
      end
      else begin
         commit
         select convert( varchar(80) , 'Impreso OK' )
         RETURN 0
      end
   END

End

GO
