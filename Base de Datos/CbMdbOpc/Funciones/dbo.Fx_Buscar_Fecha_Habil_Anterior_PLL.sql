USE [CbMdbOpc]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Buscar_Fecha_Habil_Anterior_PLL]    Script Date: 16-05-2022 10:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--*******************************************************************
--***				GENERADOR DE INTERFAZ MUREX FWD							***
--*** SQL_INTERFAZ_MUREX_FWD-ND-ARBITRAJE ND MDAS DIRECTAS_nn.sql ***

--Producto			= Forward
--Monedas			= CLP/USD
--Tipo Liquidación = Estandar


--***** SE NECESITA CREAR UNA FUNTION TEMPORAL *****
--***** SE ELIMINARÁ AL FINAL DE LA CONSULTA ***
CREATE function [dbo].[Fx_Buscar_Fecha_Habil_Anterior_PLL]
 ( @dFecha  datetime    
 , @nDias  int    
 , @nPlaza  int    
 ) returns  Datetime    
AS    
BEGIN   
 -->  Define Fecha Retorno  
 declare @dFechaFinal datetime  
	set @dFechaFinal = @dFecha  
 -->  Define Fecha Retorno  
  
 -->  Valida Días Habiles  
	set @nDias = case when @nDias < 0 then -1 else @nDias end  
   
 if @nDias = 0  
 begin  
	return @dFechaFinal  
 end  
 -->  Valida Días Habiles  
  
 -->  Determina Si Cuando Parar el Ciclo  
 declare @bFeriado  char(1)  
	set @bFeriado  = 'S'  
  
 -->  Cadena de Dias en tabla Feriados para la Plaza y el Año  
 declare @cCadenaDias char(50)  
	set @cCadenaDias = ''  
  
 -->  Dia de.....  
 declare @cDia   char(2)  
	set @cDia   = '00'  
  
 -->  Para el Conteo de Días  
 declare @nContador int  
	set @nContador = 0  
  
  
 -->  Ciclo de Feriados  
 while @bFeriado = 'S'  
 begin  
  
	-->  Determina nueva fecha  
	set @dFechaFinal = DateAdd( Day, -1, @dFechaFinal) --> DateAdd( day, @nDias, @dFechaFinal)  

	-->  Saca el día en formato de tabla de Feriados  
	set @cDia   = case when datepart( day, @dFechaFinal ) < 9 then '0' + ltrim(rtrim( datepart( day, @dFechaFinal ) ))  
							else ltrim(rtrim( datepart( day, @dFechaFinal ) ))  
						end  
  
	-->  Lee la cadena de dias feriados en el mes  
	select @cCadenaDias = case when month( @dFechaFinal ) = 1 then FeEne  
										when month( @dFechaFinal ) = 2 then FeFeb  
										when month( @dFechaFinal ) = 3 then FeMar  
										when month( @dFechaFinal ) = 4 then FeAbr  
										when month( @dFechaFinal ) = 5 then FeMay  
										when month( @dFechaFinal ) = 6 then FeJun  
										when month( @dFechaFinal ) = 7 then FeJul  
										when month( @dFechaFinal ) = 8 then FeAgo  
										when month( @dFechaFinal ) = 9 then FeSep  
										when month( @dFechaFinal ) = 10 then FeOct  
										when month( @dFechaFinal ) = 11 then FeNov  
										when month( @dFechaFinal ) = 12 then FeDic  
									end  
	from BacParamSuda.dbo.Feriado with(nolock)  
	where FeAno   = DatePart( year, @dFechaFinal)  
	and  FePlaza   = @nPlaza  
  
  --PRINT DatePart(weekday, @dFechaFinal)
  -->  Determina si el dia es habil o feriado Si el retorno es Cero, es habil (DatePart(weekday, Fecha)) = 1 = Sabado; 7 = Domingo  
	if (DatePart(weekday, @dFechaFinal) >= 2 AND DatePart(weekday, @dFechaFinal) <= 6) AND charindex(@cDia, @cCadenaDias) = 0
	begin  
		--> Conteo de Días  
		set @nContador = @nContador + 1  

		--> Si el conteo es igual a la Cantidad de Días (Dias Valor del Medio de Pago)... es la fecha de.  
		if  @nContador = @nDias  
			set @bFeriado = 'N' --> select 'Habil'  
		end else  
	begin  
		set @bFeriado = 'S'  --> select 'Feriado'  
	end  
 end  
   
 return @dFechaFinal  
 --SELECT @dFechaFinal  
END  
GO
