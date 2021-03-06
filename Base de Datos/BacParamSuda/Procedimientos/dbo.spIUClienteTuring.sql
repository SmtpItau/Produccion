USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[spIUClienteTuring]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[spIUClienteTuring]
		  ( @rut			int
		  , @codigoCliente	int
		  )
as
begin

	if not exists( select 1 
				     from ClienteTuring
				    where Rut = @rut
				      and CodigoCliente = @codigoCliente
			     )
	begin

		
		insert into dbo.ClienteTuring
		select 'DetailCustomerID'                            = isnull((select max(DetailCustomerID) from clienteTuring ),0) +1
			 , 'CustomerID'                                  = case when exists(select 1 from clienteTuring where Rut = c.clRut ) then 
																																		   ( select top 1 CustomerID
																																			   from clienteTuring
																																			  where Rut = c.clRut
																																		   )
																															      else
																																		   isnull((select max(CustomerID) from clienteTuring ),0) +1
																															      end
																																			
			 , 'Secuencia'									 = isnull((select max(Secuencia) from clienteTuring where Rut = c.clRut ),0) +1
															   
			 , 'Rut'									     = c.ClRut
			 , 'Codigocliente'							     = c.clcodigo
			 , 'Mnemotecnico'								 = ( select top 1 replace(replace(replace(ltrim(rtrim(Cliente.clnombre)),' ',''),'''',''),'ñ','n')
																   from Cliente
																  where Cliente.clRut = c.clRut
																   )
			 , 'Descripcion'								 = clNombre
			 , 'locationID'									 = 1
			 , 'StatusID'									 = 1
			 , 'CreatorUserID'								 = 0
			 , 'CreatorDate'								 = ( select top 1 Clfecingr
																   from cliente 
																  where cliente.clrut = c.clrut
															   )
															   
		  FROM Cliente c
		 where c.clRut = @rut
		   and c.clcodigo = @codigoCliente
	
	end
	else
	begin
	
		update ClienteTuring
		   set descripcion = b.clNombre
		  from ClienteTuring a
		     , Cliente		 b
		 where a.Rut = b.clRut
		   and a.codigoCliente = b.clcodigo
		   and b.clRut = @rut
		   and b.clcodigo = @codigoCliente
	
	end
	

end
GO
