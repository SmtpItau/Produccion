USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_Curva]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fx_Curva]
   (
       @Plazo numeric(10)
     , @Fecha datetime
	 , @Curva varchar(50)
   )

RETURNS float
As BEGIN
   -- Para Opciones hay que tomar domestica 'CURVA_CLP_CL'
   -- Para Opciones hay que tomar foránea   'CURVA_USD_CL'

   -- select dbo.fx_Curva( 4, '20151030', 'CURVA_CLP_CL' )
   -- select dbo.fx_Curva( 3, '20151030', 'dom' )
     
   -- retorno
   declare @LinInterpol float
   select  @LinInterpol = 0

   
   declare @CurvaDom varchar(30) = 'CURVA_CLP_CL'
   declare @CurvaFor varchar(30) = 'CURVA_USD_CL'

   declare @Plazo1   numeric(10)
   declare @Plazo2   numeric(10)
   declare @tasa1    float
   declare @tasa2    float 

   set @plazo1 = null
   select @plazo1 = Dias
        , @Tasa1  = ValorBid   
		, @plazo2 = Dias
        , @Tasa2  = ValorBid
		, @LinInterpol = ValorBid
        from BacParamSuda.dbo.Curvas
      where FechaGeneracion = @Fecha and CodigoCurva = @Curva 
	     and Dias = @Plazo
   if @Plazo1 is null --Hay que interpolar
   begin
       select @plazo1 = Dias
        ,     @Tasa1  = ValorBid   
        from BacParamSuda.dbo.Curvas 
      where FechaGeneracion = @Fecha and CodigoCurva = @Curva 
	     and Dias < @Plazo
	    order by Dias  

      select @plazo2 = Dias
        ,     @Tasa2  = ValorBid   
        from BacParamSuda.dbo.Curvas
      where FechaGeneracion = @Fecha and CodigoCurva = @Curva 
	     and Dias > @Plazo
	    order by Dias desc  		
	
	  if @plazo1 is null
	  begin
	      set @tasa1  = @tasa2 
		  set @plazo1 = @plazo2
	  end
	  if @plazo2 is null
	  begin
	      set @tasa2  = @tasa1 
		  set @plazo2 = @plazo1
	  end
      --select '@plazo1', @plazo1, '@tasa1' = @tasa1,  '@Plazo2', @plazo2  , '@tasa2' = @tasa2  
   end 

	if @plazo2 <> @plazo1
       set @LinInterpol = @tasa1 + (@tasa2 - @tasa1) / (@plazo2 - @plazo1) * (@plazo - @plazo1)
	else
	   set @LinInterpol = @tasa1
    return @LinInterpol

END
GO
