USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_Obtiene_fechaValuta]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_Obtiene_fechaValuta](@fecha datetime, @moneda int, @formaPago int)
as
begin

	declare @plaza				int
	      , @diasFormaPago		int
		  , @feriados			varchar(250)
		  , @dia				int
		  , @diaFeriado			char(2)
	
	 select @plaza = ( select mncodpais 
						 from bacParamSuda..Moneda 
					    where mncodmon = @moneda
					 )
	
	
	 select @diasFormaPago  = ( select diasvalor 
								  from bacParamSuda..Forma_de_Pago 
							     where codigo = @formaPago
							  )
	
	
	 select @dia = 0
	 
	  while @dia < @diasFormaPago
	  begin
	  
		 select @fecha = dateadd(day, 1 ,@fecha )
		 select @diaFeriado = replicate('0', 2 - len( convert(varchar,day(@fecha)) )) + convert(varchar,day(@fecha))
		
		 select @feriados = dbo.fn_ObtieneFeriados(@fecha, @plaza)

		   while charindex( @diaFeriado,@feriados,0) > 0
		   begin
		   
				select @fecha = dateadd(day, 1 ,@fecha )
			    select @feriados = dbo.fn_ObtieneFeriados(@fecha, @plaza)
				select @diaFeriado = replicate('0', 2 - len( convert(varchar,day(@fecha)) )) + convert(varchar,day(@fecha))
				
		   end
	  
	  
		   select @dia = @dia + 1
	  
	  end
	
	
	select @fecha

end
GO
