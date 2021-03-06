USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtieneMovimientosParaTraspasoTuring]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_ObtieneMovimientosParaTraspasoTuring]
		  ( @dfFechaMovimiento		datetime
		  , @dcSistema				char(3)
		  )
as
begin

	set nocount on

	select @dfFechaMovimiento = (select acfecpro from meac)
	


	create table #tmpCampos
			   ( dcSistema			varchar(3)
			   , dcCampo			varchar(250)
			   , dcCampoTabla		varchar(250)
			   , dgValor			varchar(250)
			   , indice				int identity
			   )

	create table #tmpRetorno
			   ( dcValorCampo		varchar(60) )
			   
	create table #tmpMovimientos
			   ( dnOperacion		int
			   , dfOperacion		datetime
			   , dcProducto			varchar(10)
			   , dcMoneda			varchar(3)
			   , dcMonedaConversion varchar(3)
			   , dcModalidad		char
			   , indice				int identity
			   )

	create table #tmpRetornoXML
			   ( dgXml				varchar(8000) 
			   )
			   
	create table #tmpDetalle
			   ( dnFila				int
			   , dgXml				varchar(255)
			   )
			   

	declare @sql				varchar(1000)
	 	  , @i					int
	 	  , @j					int
	 	  , @x					int
		  , @filas				int
		  , @filasMov			int
		  , @filasCampos		int
		  , @dcCampoTabla		varchar(250)
		  , @dgValor			varchar(255)
		  , @dnOperacion		int
		  , @dfOperacion		datetime
		  , @dcProducto			varchar(10)
  	      , @dcMoneda			varchar(3)
		  , @dcMonedaConversion varchar(3)
		  , @dcModalidad		char
		  , @xml				varchar(8000)
		  
	
	
	/*
	Obtención de Operaciones generadas mediantes BacMonitor
	*/
	
	-- SPOT
	if @dcSistema = 'BCC'
	begin

		insert 
		  into #tmpMovimientos
		select top 1
			   monumope
			 , mofech
			 , motipmer
  	         , case when mocodmon <> 'USD' then 'MX' else mocodmon end
		     , mocodcnv
		     , ''
		  from bacCamSuda..memo
		 where ( monumope in(select NumOpeMemo
							 from baccamsuda.dbo.tbl_StdChartered_Spot_Fwd 
							where PureDealType = 2
							  and fecha = @dfFechaMovimiento
						  )
			  or moterm in('BOLSA','DATATEC','COMEX')
			   )
		   and mofech = @dfFechaMovimiento
		   and not exists ( select 1 
							  from dbo.tbXMLOperacion
							 where dcSistema   = @dcSistema 
							   and dnOperacion = monumope
							   and swEnviada   = 'S'
					      )

  
					      	
	end
	 
	-- FORWARD
	if @dcSistema = 'BFW'
	begin

		insert 
		  into #tmpMovimientos
		select top 1
			   monumoper
			 , mofecha
			 , convert(varchar,mocodpos1)
  	         , case when dbo.fn_ObtieneMnemoMoneda(mocodmon1) <> 'USD' then 'MX' else dbo.fn_ObtieneMnemoMoneda(mocodmon1) end
		     , dbo.fn_ObtieneMnemoMoneda(mocodmon2)
		     , motipmoda
		  from bacFwdSuda..mfmo
		 where monumoper in(select NumOpeMemo
				 			  from baccamsuda.dbo.tbl_StdChartered_Spot_Fwd 
							 where PureDealType = 4
							   and fecha = @dfFechaMovimiento
						  )			   
		   and mofecha = @dfFechaMovimiento
		   and not exists ( select 1 
							  from dbo.tbXMLOperacion 
							 where dcSistema   = @dcSistema 
							   and dnOperacion = monumoper
							   and swEnviada   = 'S'
							   
					      )
		   
	
	end

	
	/*
	Fin Obtención
	*/

	
	
	/*
	Creación de XML
	*/
	
	select @x = 1
	     , @filasMov = ( select count(1) from #tmpMovimientos )
	
	while @x <= @filasMov
	begin	

		 select @dnOperacion		= dnOperacion
		      , @dfOperacion		= dfOperacion
		      , @dcProducto			= dcProducto
  			  , @dcMoneda			= dcMoneda
			  , @dcMonedaConversion = dcMonedaConversion
			  , @dcModalidad		= dcModalidad
		   from #tmpMovimientos
		  where indice = @x
		
		
		/*
		Asignación de Valores a tabla de Campos para Xml
		*/
		
  	   truncate table #tmpCampos
		 
		 insert 
		   into #tmpCampos
		 select * 
		   from tbXMLCampo
		  where dcSistema = @dcSistema

		 select @j = 1
			  , @filasCampos = (select count(1) from #tmpCampos)	      

		  while @j <= @filasCampos
		  begin
		
			  select @dcCampoTabla = dcCampoTabla		
			  	   , @dgValor		 = dgValor
			    from #tmpCampos
			   where indice = @j


				  if @dcCampoTabla <> ''
				  begin
			    
					  if @dcSistema = 'BCC'
						  select @sql = 'select ' + @dcCampoTabla + ' from bacCamSuda..memo where monumope = ' + convert(varchar,@dnOperacion) + ' and mofech = ''' + convert(varchar,@dfOperacion,112) + ''''

					  if @dcSistema = 'BFW'
						  select @sql = 'select ' + @dcCampoTabla + ' from bacFwdSuda..mfmo where monumoper = ' + convert(varchar,@dnOperacion) + ' and mofecha = ''' + convert(varchar,@dfOperacion,112) + ''''
						  
					  insert into #tmpRetorno exec (@sql)
					
					
					  update #tmpCampos
					     set dgValor = ltrim(rtrim(ltrim(rtrim(dgValor)) + ' ' + (select dcValorCampo from #tmpRetorno))) 
					   where indice = @j

					 
					  delete #tmpRetorno
						
				  end
		
			  select @j = @j+1
		
			  
		
		  end
		  

		  
		/*
		Fin Asignación de Valores
		*/
		
		 
		
		  select @i = 1
		       , @xml = ''
		       , @dgValor = ''
			   , @filas = (select count(1)
 							 from tbXMLTuring	a
						    where a.dcSistema		  = @dcSistema 
							  and a.dcProducto		  = @dcProducto
							  and a.dcMoneda		  = @dcMoneda
							  and a.dcMonedaConversion = @dcMonedaConversion		     
							  and a.dcModalidad		  = @dcModalidad
			               )


		  while @i <= @filas
		  begin

			  select @dgValor = dgValor
			    from #tmpCampos
			   where dcCampo = ( select dcCampo
										from tbXMLTuring	a
									   where a.dcSistema		  = @dcSistema 
										 and a.dcProducto		  = @dcProducto
										 and a.dcMoneda			  = @dcMoneda
										 and a.dcMonedaConversion = @dcMonedaConversion		     
										 and a.dcModalidad		  = @dcModalidad
										 and a.dnIndice			  = @i			   
			                         )

			  select @xml = replace(dcTag, '></','>' + replace(@dgValor,'.',',') + '</')    --+ '\n'
				from tbXMLTuring	a
			   where a.dcSistema		  = @dcSistema 
				 and a.dcProducto		  = @dcProducto
				 and a.dcMoneda			  = @dcMoneda
				 and a.dcMonedaConversion = @dcMonedaConversion		     
				 and a.dcModalidad		  = @dcModalidad
				 and a.dnIndice			  = @i
   			   order 
   				  by dnIndice
   				  
   				  
			  insert 
			    into #tmpDetalle   				  
			  values( @i
			        , @xml
			        )
				

			  select @i = @i +1
			  
		  end
		  
		  	
		  --insert into #tmpRetornoXML values(@xml)
		  
		      if not exists(select 1 
						      from dbo.tbXMLOperacion
						     where dcSistema   = @dcSistema
						       and dnOperacion = @dnOperacion
						   )
			  begin 

				  insert 
					into dbo.tbXMLOperacion
				  values
					   ( @dcSistema
					   , @dfOperacion
					   , @dnOperacion
					   --, @xml
					   , 'N'
					   )
					   
					   
			      insert 
			        into dbo.tbXMLOperacionDetalle
			      select @dcSistema
			           , @dfOperacion
					   , @dnOperacion
					   , dnFila
					   , dgXml
				    from #tmpDetalle
		
		
			  end
		
		
		
		  select @x = @x + 1
		
	end
  
	/*
	Fin Creación
	*/
  
	if not exists( select 1 from #tmpDetalle )
		select 'Sin Movimientos'
	else	
		select dgXml
		  from #tmpDetalle
  

  
end
GO
