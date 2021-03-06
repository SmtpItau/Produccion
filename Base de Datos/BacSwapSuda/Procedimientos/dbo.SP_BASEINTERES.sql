USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BASEINTERES]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BASEINTERES]( 
                                 @Base        INTEGER ,
                                 @fecInicial DATETIME ,
                                 @fecFinal   DATETIME ,
				                 @CodPeriodo  INTEGER ,
                                 @Tasa          FLOAT ,
                                 @fInteres          FLOAT OUTPUT )

WITH RECOMPILE
AS
BEGIN


/*
 declare @factor float
 exec SP_BASEINTERES 4, '20160729', '20170731' , 1, 2.5, @factor output
 select @factor
 */
set nocount on
select @fInteres = 0.0
DECLARE @ValorBase INTEGER , --NUMERIC(4),
	@ValorDias NUMERIC(4),
	@TipoBase  CHAR(4),
	@TipoDias  CHAR(4) ,
	@pp FLOAT	

	SELECT @pp =0.0

	SELECT 	@TipoBase = Base ,
		@TipoDias = Dias
	FROM	BASE  
	WHERE Codigo       = @Base

	IF @TipoBase =  'A'  
		BEGIN
			SELECT @ValorBase = 365
		END
	ELSE
		BEGIN
			SELECT @ValorBase = convert(Integer, @TipoBase ) * 1.
		END 
	
	--IF  @TipoDias =  'P' /* Europeo */  or  @TipoDias =  'PA' /* Americano */
    if charindex( 'P' , @TipoDias ) <> 0
		BEGIN
	    create table #T( Valor Float )
		insert into #T
		EXEC dbo.SP_DIFDIAS30	 @fecInicial,    
						@fecFinal ,						
						@TipoDias
        select @ValorDias = Valor from #T
		END
	ELSE
		BEGIN
			SELECT @ValorDias =  DATEDIFF( day, @fecInicial, @fecFinal)
		END

	select @fInteres = convert(integer,@ValorDias)  / (@ValorBase * 1.)

	SELECT @fInteres = (@fInteres * @Tasa) / 100.

   set nocount off
END 

GO
