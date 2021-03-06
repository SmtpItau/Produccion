USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_Registro_ingreso_operacion]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[SP_Registro_ingreso_operacion]
		  ( @Aplicacion			varchar(30)
		  , @Pantalla			varchar(50)
		  , @ModuloBac			varchar(10)
		  , @Operacion			numeric(10)
		  , @FechaSys			datetime
		  )

as
begin

   declare @FechaApp	datetime
         

    select @FechaApp    = getdate()

	select @FechaSys    = case when @ModuloBac = 'BFW' then (select acfecproc from bacfwdSuda..mfac)
							   when @ModuloBac = 'BCC' then (select acfecpro from baccamSuda..meac)
							   when @ModuloBac = 'SWP' then (select  fechaproc from bacswapsuda..SwapGeneral)
							   else @FechaSys 
							   end

	insert 
	  into TBL_REGISTRO_INGRESO_OPERACION
	     ( ReAplicacion
		 , RePantalla
		 , ReModuloBac
		 , ReOperacion
		 , ReFechaApp
		 , RefechaSys
		 )
	values
	     ( @Aplicacion
		 , @Pantalla
		 , @ModuloBac
		 , @Operacion
		 , @FechaApp
		 , @FechaSys
		 )


	select 'Ok'

end

GO
