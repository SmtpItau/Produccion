USE [BacCamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Retorna_GlosaFinal]    Script Date: 11-05-2022 16:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_Retorna_GlosaFinal]
(
		@Glosa1 as varchar(max)
	 ,  @nRut		numeric(20)
	 ,	@nAvales	int
	 ,	@Glosa		varchar(10)
	,   @RegimenConyugal	 varchar(10)
	,	@NumeraClausula numeric(2) = 0
	
) Returns		varchar(max)
as 
begin

	declare @GlosaTemp	varchar(max)
		set @GlosaTemp	= ''
	declare @GlosaFinal	varchar(max)
		set @GlosaFinal	= ''

declare @Inicio int
declare @Final int
--declare @Glosa1 varchar(4000)
--set @Glosa1 = ( select glosa2 from bacparamsuda..TBL_CLAUSULAS where sistema = 'PCS' AND CODIGO_CLAUSULA = 'RAG4' AND TIPO_CONTRATO = 'ACCE')
--set @Inicio = (select charindex('[[', @Glosa1))--1574
--set @Final = (select charindex(']]', @Glosa1)) --2078
--set @Glosa1 = ( select glosa2 from bacparamsuda..TBL_CLAUSULAS where sistema = 'PCS' AND CODIGO_CLAUSULA = 'RAG4' AND TIPO_CONTRATO = 'ACCE')


set @GlosaTemp = (SELECT REPLACE(
								SUBSTRING(@Glosa1,1,DATALENGTH(@Glosa1))
								, '@CONYUGE'
								, dbo.Fx_Retorna_Conyuge(@nRut, @nAvales, @Glosa, @RegimenConyugal)
								)
								)


set @GlosaTemp = (SELECT REPLACE(
								SUBSTRING(@GlosaTemp,1,DATALENGTH(@GlosaTemp))
								, 'CORPBANCA'
								, (select RazonSocial from bacparamsuda..Contratos_ParametrosGenerales)
								)
								)

if @NumeraClausula = 1
BEGIN
set @GlosaTemp = (SELECT REPLACE(
								SUBSTRING(@GlosaTemp,1,DATALENGTH(@GlosaTemp))
								, '4.-'
								, '3.-'
								)
								)
END
							

DECLARE @TieneCor as numeric(10)
set @TieneCor = charindex('[[', @GlosaTemp)

if @RegimenConyugal <> 'CSDOSC' and @RegimenConyugal <> 'CSDOPG'
begin
	if @TieneCor > 0
	begin
		set @GlosaTemp = (select stuff(@GlosaTemp, charindex('[[', @GlosaTemp),charindex(']]', @GlosaTemp), ''))
	end
	
end
else
begin
	set @GlosaTemp = (select replace(@GlosaTemp, '[[', ' '))
		set @GlosaTemp = (select replace(@GlosaTemp, ']]', ' '))
	--set @GlosaTemp = (select stuff(@GlosaTemp, charindex(']]', @GlosaTemp),charindex(']]', @GlosaTemp), ' '))
end


return @GlosaTemp

end








GO
