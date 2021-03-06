USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FX_FeriadoFijoGringoTraducidoAFecha]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE FUNCTION [dbo].[FX_FeriadoFijoGringoTraducidoAFecha] (@Ano            NUMERIC(4), --  ejemplo 2015, 2014
													  @cFechaFija     VARCHAR(5)) --  ejemplo "1L09", "0101", "2J03" -- los meses con cifras no nombres

RETURNS DATETIME
AS
BEGIN

	/* Ejemplos de uso
	tercer lunes de Febrero: 
	select  dbo.FX_FeriadoFijoGringoTraducidoAFecha( 2020, '3L-02' )
	ultimo lunes de mayo    : 
	select  dbo.FX_FeriadoFijoGringoTraducidoAFecha( 2018, 'UL-05' )
	cuarto jueves de noviembre 
	select  dbo.FX_FeriadoFijoGringoTraducidoAFecha( 2026, '4J-11' )
	primer lunes de septiembre
	select  dbo.FX_FeriadoFijoGringoTraducidoAFecha( 2029, '1L-09' )
	Martes despues de primer lunes de noviembre
	select  dbo.FX_FeriadoFijoGringoTraducidoAFecha( 2029, 'LM-11' )
	select  dbo.FX_FeriadoFijoGringoTraducidoAFecha( 2015, 'LM-11' )
	select  dbo.FX_FeriadoFijoGringoTraducidoAFecha( 2016, 'LM-11' )
	select  dbo.FX_FeriadoFijoGringoTraducidoAFecha( 2017, 'LM-11' )
	*/
	
	DECLARE @FechaParaAno DATETIME
	DECLARE @fecha DATETIME 
	,@DIASEMANA INT,
			@FERIADO DATETIME
	
	/* Algoritmo */
	
	DECLARE @Mes NUMERIC(2)
	SELECT @Mes = CONVERT(NUMERIC(2), SUBSTRING(@cFechaFija, 4, 2)) 
	IF @Mes NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
	    GOTO ERROR
	
	DECLARE @EspecificaDiaSem VARCHAR(1)
	SELECT @EspecificaDiaSem = SUBSTRING(@cFechaFija, 2, 1)
	IF @EspecificaDiaSem NOT IN ('L', 'J', 'M' /* Dia Eleccion 'LM-11' */ )
	    GOTO ERROR  
	
	DECLARE @OrdDia VARCHAR(2) -- 1 Primer Lunes, 2 Segundo Lunea, 3 Tercer Lunes, 4 Cuarto Lunes
	SELECT @OrdDia = SUBSTRING(@cFechaFija, 1, 1)
	IF @OrdDia NOT IN ('1', '2', '3', '4', 'U', 'L'  /* Dia Eleccion 'LM-11' */ )
	    GOTO ERROR
	
	IF @OrdDia = 'L' /* Calcular Primer Lunes del Mes para retornar el día siguiente */
	Begin
	    set @cFechaFija = '1L' + '-' + case when @Mes >= 10 then convert( varchar(2), @Mes ) else 
		                                                   '0' + convert( varchar(1), @Mes ) end
		set @fechaParaAno = dateadd( day,  1, dbo.FX_FeriadoFijoGringoTraducidoAFecha( @Ano , @cFechaFija ) )
		-- set @fechaParaAno = convert( datetime , '19691225' )
	end
	Else 
	Begin
		IF @OrdDia <> 'U'
		BEGIN
			SELECT @fecha = CONVERT(DATETIME,CONVERT(VARCHAR(8), @Ano * 10000 + @Mes * 100 + 01))

			IF @EspecificaDiaSem='J'
			BEGIN
	    	
	    		SET @DIASEMANA = (SELECT DATEPART(WEEKDAY, @fecha))
	
				IF @DIASEMANA IN (2,3,4,5)
				BEGIN				
				
					IF @DIASEMANA=2
						SET @FERIADO = DATEADD(DAY,3,@fecha)			
				
					IF @DIASEMANA=3
						SET @FERIADO = DATEADD(DAY,2,@fecha)
		
					if @DIASEMANA= 4
						SET @FERIADO = DATEADD(DAY,1,@fecha)
		
					if @DIASEMANA= 5 
						SET @FERIADO = @fecha
			
					SELECT @FechaParaAno = DATEADD(wk,CONVERT(INT,@OrdDia)-1,@FERIADO)
						
				END
				ELSE
				BEGIN
				/* Se buscar un dia para encontrar la cantidad de semanas entera desde 1900-01-01 */
				SELECT @FechaParaAno = DATEADD(dd,0 + CASE WHEN @EspecificaDiaSem = 'L' THEN 0
								     			   WHEN @EspecificaDiaSem = 'J' THEN 3
											  END,
									   DATEADD(wk,DATEDIFF(wk, 0, DATEADD(dd, 6 - DATEPART(DAY, @fecha), @fecha)) - 1 + @OrdDia,0))
				
				END
			END	 
			ELSE
			BEGIN   
				/* Se buscar un dia para encontrar la cantidad de semanas entera desde 1900-01-01 */
				SELECT @FechaParaAno = DATEADD(dd,0 + CASE WHEN @EspecificaDiaSem = 'L' THEN 0
								     			   WHEN @EspecificaDiaSem = 'J' THEN 3
											  END,
									   DATEADD(wk,DATEDIFF(wk, 0, DATEADD(dd, 6 - DATEPART(DAY, @fecha), @fecha)) - 1 + @OrdDia,0))
			END
		END
		ELSE
		BEGIN
		
			/* Se calculará el primer lunes o Jueves del proximo mes haciendo llamada recursiva y se restará 7 días */
	    
			DECLARE @cMes VARCHAR(2)
			IF @Mes = 12
			BEGIN
				SELECT @Mes = 1
				SELECT @ano = @Ano + 1
			END
			ELSE
				SELECT @Mes = @Mes + 1
	    
			IF @Mes < 10
				SELECT @cMes = '0' + CONVERT(VARCHAR(1), @Mes)
			ELSE
				SELECT @cMes = CONVERT(VARCHAR(2), @Mes)      
	    
			SELECT @cFechaFija = '1' + SUBSTRING(@cFechaFija, 2, 1) + @cMes
	    
			SELECT @FechaParaAno = CONVERT(DATETIME, DATEADD(dd, -7,dbo.FX_FeriadoFijoGringoTraducidoAFecha(@Ano, @cFechaFija)))  -- Restar 7 diás al primer lunes del prox. mes
		END 
	
		--DIA DEL VETERANO--------------
		/*
		IF @cFechaFija = '1111'
		BEGIN
			 DECLARE @Hoy INT
			 SET @Hoy = (SELECT DATEPART(WEEKDAY, @fechaParaAno))
			 IF @Hoy in (1)
			 BEGIN
		 		 SET @fechaParaAno = DATEADD(DAY,1,@fechaParaAno)	
			 END 
			 ELSE IF  @Hoy in (7)
			 BEGIN
				SET @fechaParaAno = DATEADD(DAY,-1,@fechaParaAno)	
			 END
		 	
		END
		--------------------
		*/
	end
	RETURN(@fechaParaAno)
	
	ERROR:
	RETURN(CONVERT(DATETIME, '19000101'))
	
END

GO
