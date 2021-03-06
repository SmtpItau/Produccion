USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FNFORMADEPAGOMX]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FNFORMADEPAGOMX](@codmon		varchar(5),
                                        @codcnv		varchar(5)
                                        ) returns varchar(5)
as
begin--Comienza funcion 

Declare @msj varchar(50)
	set @msj  = ''

/*****************Aplica cuando ambas monedas son extrajeras moneda extraj**************************/
 if @codmon <> 'CLP' and @codmon <> 'UF' and  @codcnv <> 'CLP' and @codcnv <> 'UF'
	BEGIN
        select @msj ='MX'
	end
 
/*****************Aplica cuando monedas de pago es MX/CLP******************************************/
 if @codmon = 'CLP' or @codmon = 'UF' and  @codcnv = 'CLP' or @codcnv = 'UF'   
    BEGIN
        select @msj ='MN'
	end

 return  @msj  	
end --termina funcion

GO
