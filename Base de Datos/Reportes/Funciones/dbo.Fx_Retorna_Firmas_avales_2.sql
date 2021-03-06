USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Retorna_Firmas_avales_2]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (4229125, 1, 2)

--SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (4229125, 2)

CREATE function [dbo].[Fx_Retorna_Firmas_avales_2]

(
	@RutEntidad		NUMERIC(12)
	,@ID_1			NUMERIC(2)
	--,@ID_2			NUMERIC(2)

) returns			VARCHAR(8000)



AS
BEGIN
	
	declare @cNomEntidad		varchar(50)
	declare @cNomApoderado		varchar(50)
	declare @cRutApoderado		varchar(15)
	declare @cDVApoderado		varchar(3)
	declare @cDireccion			varchar(50)
	declare @cFono				varchar(25)
	declare @cFax				varchar(25)
	declare @cRutEntidad		varchar(25)
	declare @DVAval				varchar(10)

	declare @cNomEntidad2		varchar(50)
	declare @cNomApoderado2		varchar(50)
	declare @cRutApoderado2		varchar(15)
	declare @cDireccion2		varchar(50)
	declare @cFono2				varchar(25)
	declare @cFax2				varchar(25)
	declare @cRutEntidad2		varchar(25)
	declare @DVAval2			varchar(10)

	set @cNomEntidad		= ''
	set @cNomApoderado		= ''
	set @cRutApoderado		= ''
	set @cDVApoderado		= ''
	set @cDireccion			= ''
	set @cFono				= ''
	set @cFax				= ''
	set @cRutEntidad		= ''
	set @DVAval				= ''

	set @cNomEntidad2		= ''
	set @cNomApoderado2		= ''
	set @cRutApoderado2		= ''
	set @cDireccion2		= ''
	set @cFono2				= ''
	set @cFax2				= ''
	set @cRutEntidad2		= ''
	set @DVAval2			= ''

	declare @cFirma				varchar(8000)
	declare @Num_Aval			numeric(10)

	SET @Num_Aval			= (select count(*) from BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  where rut_cliente = @RutEntidad)



select      @cNomEntidad		= ISNULL(Nombre_Aval,'')
		,	@cNomApoderado		= ISNULL(Nom_Apod_Aval_1,'')
		,	@cRutApoderado		= ISNULL(Rut_Apod_Aval_1,'')
		,	@cDVApoderado		= ISNULL(Dv_RAA_1,'')
		,	@cDireccion			= ISNULL(Direccion_Aval,'')
		,	@cRutEntidad		= ISNULL(Rut_Aval,'')
		,	@DVAval				= ISNULL(DV_Aval,'')
from 
(select		Nombre_Aval
		,	Nom_Apod_Aval_1
		,	Rut_Apod_Aval_1
		,	Dv_RAA_1
		,	Direccion_Aval
		,	Rut_Aval
		,	DV_Aval
		,   Id		= ROW_NUMBER () OVER (order by rut_aval)  from BacParamSuda.dbo.TBL_AVAL_CLIENTE_DERIVADO where Rut_Cliente = @RutEntidad) aval

where Id	 = @ID_1


/*
select      @cNomEntidad2		= ISNULL(Nombre_Aval,'')
		,	@cNomApoderado2		= ISNULL(Nom_Apod_Aval_1,'')
		,	@cRutApoderado2		= ISNULL(Rut_Apod_Aval_1,'')
		,	@cDireccion2		= ISNULL(Direccion_Aval,'')
		,	@cRutEntidad2		= ISNULL(Rut_Aval,'')
		,	@DVAval2			= ISNULL(DV_Aval,'')
from 
(select		Nombre_Aval
		,	Nom_Apod_Aval_1
		,	Rut_Apod_Aval_1
		,	Direccion_Aval
		,	Rut_Aval
		,	DV_Aval
		,   Id		= ROW_NUMBER () OVER (order by rut_aval)  from BacParamSuda.dbo.TBL_AVAL_CLIENTE_DERIVADO where Rut_Cliente = @RutEntidad) aval

where Id	 = @ID_2
*/

/*
if @cNomEntidad <> '' and @ID_2 <> 0
begin
SET @cFirma = (select ltrim(rtrim(convert(varchar(80),'FIADOR, CODEUDOR SOLIDARIO Y AVALISTA'))	
						+ REPLICATE(' ', 80 - DATALENGTH(ltrim(rtrim('FIADOR, CODEUDOR SOLIDARIO Y AVALISTA')) )) )							
						+ LTRIM(RTRIM('FIADOR, CODEUDOR SOLIDARIO Y AVALISTA')) + char(10)
						
						+ ltrim(rtrim(convert(varchar(80), 'pp.       : '	+	 @cNomEntidad))						
						+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM('pp.       : ' +	 @cNomEntidad)) )) )							
						+ LTRIM(RTRIM('pp.       : ' +	 @cNomEntidad2))		+  char(10)
						
						+ ltrim(rtrim(convert(varchar(80), 'Nombre    : '	+	@cNomApoderado))								
						+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM('Nombre    : '	+	@cNomApoderado)) )) )							
						+ LTRIM(RTRIM('Nombre    : ' +	@cNomApoderado2))		+  char(10)
						
						+ ltrim(rtrim(convert(varchar(80), 'C.N.I.N.  : '	+	@cRutApoderado))										
						+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM('C.N.I.N.  : '		+	@cRutApoderado)) )) )							
						+ LTRIM(RTRIM('C.N.I.N.  : ' +	@cRutApoderado2))		+  char(10)
						
						+ ltrim(rtrim(convert(varchar(80), 'Domicilio : '	+	@cDireccion))					
						+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM('Domicilio : '	+	@cDireccion)) )) ) 
						+ LTRIM(RTRIM('Domicilio : ' +	@cDireccion2))			+  char(10)
						
						+ ltrim(rtrim(convert(varchar(80), 'Teléfono  : '	+	' '))							
						+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM('Teléfono  : '	+	' ')) )) ) 
						+ LTRIM(RTRIM('Teléfono  : '	+	' ')) + char(10)
						
						+ ltrim(rtrim(convert(varchar(80), 'Fax       : '	+	' '))							
						+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM('Fax       : '	+	' ')) )) ) 
						+ LTRIM(RTRIM('Fax       : '	+	' ')) + char(10)
						
						+ ltrim(rtrim(convert(varchar(80), 'RUT       : '	+	@cRutEntidad + '-' + @DVAval)) 
						+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM('RUT       : '	+	@cRutEntidad + '-' + @DVAval)) )) ) 
						+ LTRIM(RTRIM('RUT       : '	+	@cRutEntidad2 + '-' + @DVAval2)) +  char(10)
						)
	--print @cFirma
--end else
--begin
	--SET @cFirma = 'Sin Firma'

end
*/

if @cNomEntidad <> '' ---and @ID_2 = 0
begin
SET @cFirma =  /*(select ltrim(rtrim(convert(varchar(80),'FIADOR, CODEUDOR SOLIDARIO Y AVALISTA'))	
						+ REPLICATE(' ', 80 - DATALENGTH(ltrim(rtrim('FIADOR, CODEUDOR SOLIDARIO Y AVALISTA')) )) )							
						--+ LTRIM(RTRIM('FIADOR, CODEUDOR SOLIDARIO Y AVALISTA')) 
						+ char(10)
						*/
				(select 
						+ ltrim(rtrim(convert(varchar(80), @cNomEntidad))						
						+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM(@cNomEntidad)) )) )							
						--+ LTRIM(RTRIM('pp.       : ' +	 @cNomEntidad2))		
						+  char(10)

						--+ ltrim(rtrim(convert(varchar(80), @cRutEntidad + '-' + @DVAval)) 
						+ ltrim(rtrim(convert(varchar(80), (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(char(20),@cRutEntidad))) ), 1), '.00', ''), ',','.')) + '-' + @DVAval)) 
						--+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM(@cRutEntidad + '-' + @DVAval)))  ) ) 
						+ REPLICATE(' ', 80 - DATALENGTH((select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(char(20),@cRutEntidad))) ), 1), '.00', ''), ',','.')) + '-' + @DVAval)))  
						--+ LTRIM(RTRIM('RUT       : '	+	@cRutEntidad2 + '-' + @DVAval2)) 
						+  char(10)
						
						+ ltrim(rtrim(convert(varchar(80), @cNomApoderado))								
						+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM(@cNomApoderado)) )) )							
						--+ LTRIM(RTRIM('Nombre    : ' +	@cNomApoderado2))		
						+  char(10)
						
						--+ ltrim(rtrim(convert(varchar(80), 	@cRutApoderado))										
						--+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM(@cRutApoderado)) )) )	
						
						+ ltrim(rtrim(convert(varchar(80), (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(char(20),@cRutApoderado))) ), 1), '.00', ''), ',','.')) + '-' + @cDVApoderado)) 	
							+ REPLICATE(' ', 80 - DATALENGTH((select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(char(20),@cRutApoderado))) ), 1), '.00', ''), ',','.')) + '-' + @cDVApoderado)))  
						--+ ltrim(rtrim(convert(varchar(80), 	''))										
						--+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM('')) )) )						
						--+ LTRIM(RTRIM('C.N.I.N.  : ' +	@cRutApoderado2))		
						+  char(10)
						
							
						+ ltrim(rtrim(convert(varchar(80), ' '))							
						+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM(' ')) )) ) 
						--+ LTRIM(RTRIM('Teléfono  : '	+	' ')) 
						+ char(10)

						+ ltrim(rtrim(convert(varchar(80), @cDireccion))					
						+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM(@cDireccion)) )) ) 
						--+ LTRIM(RTRIM('Domicilio : ' +	@cDireccion2))			
						+  char(10)
						
						--+ ltrim(rtrim(convert(varchar(80), ' '))							
						--+ REPLICATE(' ', 80 - DATALENGTH(LTRIM(RTRIM(' ')) )) ) 
						----+ LTRIM(RTRIM('Fax       : '	+	' ')) 
						--+ char(10)
						


						)


end

	RETURN @cFirma
END


GO
