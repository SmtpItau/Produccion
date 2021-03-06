USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Retorna_Conyuge]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[Fx_Retorna_Conyuge]
	(	@nRut		numeric(20)
	,	@nAvales	int
	,	@Glosa		varchar(10)
	,   @RegimenConyugal	 varchar(10)
	)	Returns		varchar(8000)
as
begin

	declare @nContador	int
		set @nContador	= 1
/*
	declare @nAvales	int
		set @nAvales	= 2
*/

	declare @cAvales	varchar(8000)
		set @cAvales	= ''


IF @RegimenConyugal = 'NA' 
BEGIN
	while @nAvales	>= @nContador
	begin
		
	
		set		@cAvales	=	@cAvales
							+	(	select	Avales
									from	(	select	Avales	=	ltrim(rtrim( Nombre_Aval )) 
															+	' Rol Unico Tributario N° ' 
															--+	ltrim(rtrim(rut_aval))			+ '-' + ltrim(rtrim( dv_aval ))
															+	(select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(rut_aval,0)))) ), 1), '.00',''), ',','.'))+ '-' + ltrim(rtrim( dv_aval ))
															+	' representada por don(ña) '
															+	ltrim(rtrim(nom_apod_aval_1))
															+	', cédula nacional de identidad N° '
															--+	ltrim(rtrim(rut_apod_aval_1))	+ '-' + ltrim(rtrim( dv_raa_1 ))
															+	(select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(rut_apod_aval_1,0)))) ), 1), '.00',''), ',','.'))	+ '-' + ltrim(rtrim( dv_raa_1 ))
															--+	', y don(ña) '

															+	case when rut_apod_aval_2 <> 0  then 
																			+	', y don(ña) '
																			+ ltrim(rtrim(nom_apod_aval_2))
																			+	', cédula nacional de identidad N° '
																			--+	ltrim(rtrim(rut_apod_aval_2))	+ '-' + ltrim(rtrim( dv_raa_2 ))
																			+	(select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(rut_apod_aval_2,0)))) ), 1), '.00',''), ',','.'))	+ '-' + ltrim(rtrim( dv_raa_2 ))
																	else
																		+ ''
																			--+	', y '
																			--+ ltrim(rtrim(Nombre_Aval))
																			--+	'Rol Unico Tributario N°' 
																			--+	ltrim(rtrim(rut_aval))			+ '-' + ltrim(rtrim( dv_aval ))
																	end
															
															--+	ltrim(rtrim(nom_apod_aval_2))
															---+	', cédula nacional de identidad N° '
															--+	ltrim(rtrim(rut_apod_aval_2))	+ '-' + ltrim(rtrim( dv_raa_2 ))
															+   case when @Glosa = 'Glosa3' then 
																+	', ambos domiciliados en '
																+	ltrim(rtrim(isnull(direccion_aval,'Sin_Info')))
																+	', comuna de '
																+	Com.nombre
																+	', ciudad de '
																+	Ciu.Nombre
																else
																	+ ''
																end
																		
															+	case	when @nAvales	= @nContador then + ', ' 
																		else							  + ', y '
																	end

												,	Id		= ROW_NUMBER () OVER (order by rut_aval)
											from	BacParamSuda.dbo.TBL_AVAL_CLIENTE_DERIVADO 
												,	(	SELECT TOP 1 nombre 
														FROM	bacparamsuda.dbo.comuna comu
																inner join bacparamsuda.dbo.TBL_AVAL_CLIENTE_DERIVADO ac on ac.comuna_aval = comu.codigo_comuna and ac.cod_Cliente = 1 
														WHERE	rut_cliente = @nRut
													)	Com
												,	(	SELECT TOP 1 Nombre = ciu.nombre 
														FROM		bacparamsuda..CIUDAD CIU
																	inner join bacparamsuda..TBL_AVAL_CLIENTE_DERIVADO ac on ac.ciudad_aval = CIU.CODIGO_CIUDAD and ac.cod_Cliente = 1 
														WHERE	rut_cliente = @nRut
													)	Ciu	
											where	rut_cliente		= @nRut
										)	Avales
									where	Id	= @nContador
								)	+ ''
		set @nContador = @nContador + 1
	end

	IF @Glosa = 'Glosa3' 
			set @cAvales = @cAvales + ' en adelante Garante(s), '



END --> DEL IF

IF @RegimenConyugal = 'CSDOSB' 
BEGIN
		while @nAvales	>= @nContador
		begin
		set		@cAvales	=	@cAvales
							+	(	select	Avales
									from	(	select	Avales	=	'don(ña) ' + LTRIM(RTRIM(NOMBRE_AVAL)) 
																	+ ', ' + ' casado(a) y separado(a) totalmente de bienes, '
																	---+ 'cédula nacional de identidad N° ' + LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL 
																	+ 'cédula nacional de identidad N° '  +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(RUT_AVAL,0)))) ), 1), '.00',''), ',','.')) + '-' + DV_AVAL 

																																
															+	case	when @nAvales	= @nContador then + ', ' 
																		else							  + ', y '
																	end

												,	Id		= ROW_NUMBER () OVER (order by rut_aval)
											from	BacParamSuda.dbo.TBL_AVAL_CLIENTE_DERIVADO 
												,	(	SELECT TOP 1 nombre 
														FROM	bacparamsuda.dbo.comuna comu
																inner join bacparamsuda.dbo.TBL_AVAL_CLIENTE_DERIVADO ac on ac.comuna_aval = comu.codigo_comuna and ac.cod_Cliente = 1 
														WHERE	rut_cliente = @nRut
													)	Com
												,	(	SELECT TOP 1 Nombre = ciu.nombre 
														FROM		bacparamsuda..CIUDAD CIU
																	inner join bacparamsuda..TBL_AVAL_CLIENTE_DERIVADO ac on ac.ciudad_aval = CIU.CODIGO_CIUDAD and ac.cod_Cliente = 1 
														WHERE	rut_cliente = @nRut
													)	Ciu	
											where	rut_cliente		= @nRut
										)	Avales
									where	Id	= @nContador
								)	+ ''
		set @nContador = @nContador + 1
	end

	IF @Glosa = 'Glosa3' 
			set @cAvales = @cAvales + ' en adelante Garante(s), '


			

END

IF @RegimenConyugal = 'CSDOSC' 
BEGIN
		while @nAvales	>= @nContador
		begin
		set		@cAvales	=	@cAvales
							+	(	select	Avales
									from	(	select	Avales	=	'don(ña) ' + LTRIM(RTRIM(Nom_Conyuge_Aval)) 
																	+ ' chileno(a), '
																	+ 'cédula nacional de identidad N° '  +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(RUT_CONYUGE_AVAL,0)))) ), 1), '.00',''), ',','.')) + '-' + DV_RCA 
																	+ ', ' + ' casado(a) bajo el régimen de sociedad conyugal, '
																	+ 'con don(ña) ' + LTRIM(RTRIM(NOMBRE_AVAL)) 
																	+ ' precedentemente individualizado, '
																	+ 'domiciliado(a) en ' +  LTRIM(RTRIM(Direccion_Aval))
																	
																	--+ 'cédula nacional de identidad N° ' + LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL 
																	--+ 'cédula nacional de identidad N° '  +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(RUT_AVAL,0)))) ), 1), '.00',''), ',','.')) + '-' + DV_AVAL 
																	+	case	when @nAvales	= @nContador then 
																				+ ', ' 
																		else							  
																				+ ', y '
																		end

																	,	Id		= ROW_NUMBER () OVER (order by rut_aval)
											from	BacParamSuda.dbo.TBL_AVAL_CLIENTE_DERIVADO 
												,	(	SELECT TOP 1 nombre 
														FROM	bacparamsuda.dbo.comuna comu
																inner join bacparamsuda.dbo.TBL_AVAL_CLIENTE_DERIVADO ac on ac.comuna_aval = comu.codigo_comuna and ac.cod_Cliente = 1 
														WHERE	rut_cliente = @nRut
													)	Com
												,	(	SELECT TOP 1 Nombre = ciu.nombre 
														FROM		bacparamsuda..CIUDAD CIU
																	inner join bacparamsuda..TBL_AVAL_CLIENTE_DERIVADO ac on ac.ciudad_aval = CIU.CODIGO_CIUDAD and ac.cod_Cliente = 1 
														WHERE	rut_cliente = @nRut
													)	Ciu	
											where	rut_cliente		= @nRut
										)	Avales
									where	Id	= @nContador
								)	+ ''
		set @nContador = @nContador + 1
	end

	IF @Glosa = 'Glosa3' 
			set @cAvales = @cAvales + ' en adelante Garante(s), '

END



IF @RegimenConyugal = 'CSDOPG' 
BEGIN
		while @nAvales	>= @nContador
		begin
		set		@cAvales	=	@cAvales
							+	(	select	Avales
									from	(	select	Avales	=	'don(ña) ' + LTRIM(RTRIM(Nom_Conyuge_Aval)) 
																	+ ', chileno(a),'
																	+ ' cédula nacional de identidad N° '  +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(RUT_CONYUGE_AVAL,0)))) ), 1), '.00',''), ',','.')) + '-' + DV_RCA 
																	+ ' casado(a) bajo el régimen de participación en los gananciales con doñ(a) ' + LTRIM(RTRIM(NOMBRE_AVAL))  
																	+ ' precedentemente individualizado,'
																	+ ' domiciliado(a) en ' +  LTRIM(RTRIM(Direccion_Aval))

																	--+ ', ' + ' casado(a) bajo el régimen de participación en los gananciales, '
																	
																	--+ 'cédula nacional de identidad N° '  +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(RUT_AVAL,0)))) ), 1), '.00',''), ',','.')) + '-' + DV_AVAL 
																	+	case	when @nAvales	= @nContador then 
																				+ ', ' 
																		else							  
																				+ ', y '
																		end

																	,	Id		= ROW_NUMBER () OVER (order by rut_aval)
											from	BacParamSuda.dbo.TBL_AVAL_CLIENTE_DERIVADO 
												,	(	SELECT TOP 1 nombre 
														FROM	bacparamsuda.dbo.comuna comu
																inner join bacparamsuda.dbo.TBL_AVAL_CLIENTE_DERIVADO ac on ac.comuna_aval = comu.codigo_comuna and ac.cod_Cliente = 1 
														WHERE	rut_cliente = @nRut
													)	Com
												,	(	SELECT TOP 1 Nombre = ciu.nombre 
														FROM		bacparamsuda..CIUDAD CIU
																	inner join bacparamsuda..TBL_AVAL_CLIENTE_DERIVADO ac on ac.ciudad_aval = CIU.CODIGO_CIUDAD and ac.cod_Cliente = 1 
														WHERE	rut_cliente = @nRut
													)	Ciu	
											where	rut_cliente		= @nRut
										)	Avales
									where	Id	= @nContador
								)	+ ''
		set @nContador = @nContador + 1
	end

	IF @Glosa = 'Glosa3' 
			set @cAvales = @cAvales + ' en adelante Garante(s), '

END


IF @RegimenConyugal = 'STRO' 
BEGIN
		while @nAvales	>= @nContador
		begin
		set		@cAvales	=	@cAvales
							+	(	select	Avales
									from	(	select	Avales	=	'don(ña) ' + LTRIM(RTRIM(NOMBRE_AVAL)) 
																	+ ', ' + ' soltero, '
																	--+ 'cédula nacional de identidad N° ' + LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL 
																	+ 'cédula nacional de identidad N° '  +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(RUT_AVAL,0)))) ), 1), '.00',''), ',','.')) + '-' + DV_AVAL 
																	+	case	when @nAvales	= @nContador then 
																				+ ', ' 
																		else							  
																				+ ', y '
																		end

																	,	Id		= ROW_NUMBER () OVER (order by rut_aval)
											from	BacParamSuda.dbo.TBL_AVAL_CLIENTE_DERIVADO 
												,	(	SELECT TOP 1 nombre 
														FROM	bacparamsuda.dbo.comuna comu
																inner join bacparamsuda.dbo.TBL_AVAL_CLIENTE_DERIVADO ac on ac.comuna_aval = comu.codigo_comuna and ac.cod_Cliente = 1 
														WHERE	rut_cliente = @nRut
													)	Com
												,	(	SELECT TOP 1 Nombre = ciu.nombre 
														FROM		bacparamsuda..CIUDAD CIU
																	inner join bacparamsuda..TBL_AVAL_CLIENTE_DERIVADO ac on ac.ciudad_aval = CIU.CODIGO_CIUDAD and ac.cod_Cliente = 1 
														WHERE	rut_cliente = @nRut
													)	Ciu	
											where	rut_cliente		= @nRut
										)	Avales
									where	Id	= @nContador
								)	+ ''
		set @nContador = @nContador + 1
	end

	IF @Glosa = 'Glosa3' 
			set @cAvales = @cAvales + ' en adelante Garante(s), '

END



	return @cAvales --> SE BE DEJAR

END


--select * from BacParamSuda.dbo.TBL_AVAL_CLIENTE_DERIVADO where rut_cliente = 4229125

--select * from BacParamSuda.dbo.TBL_AVAL_CLIENTE_DERIVADO where rut_cliente = 76005008

--SELECT * FROM BacParamSuda.dbo.TBL_AVAL_CLIENTE_DERIVADO where rut_cliente = 4229125


GO
