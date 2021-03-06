USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_CORRESPONSALES_MONEDA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--SP_RETORNA_CORRESPONSALES_MONEDA 13

CREATE PROCEDURE [dbo].[SP_RETORNA_CORRESPONSALES_MONEDA]

@codigo_moneda as int

as

begin

select	rut_cliente, 
		codigo_cliente, 
		codigo_pais, 
		codigo_plaza, 
		codigo_swift, 
		nombre, 
		codigo_corres, 
		cod_corresponsal 
from	corresponsal 
where	rut_cliente	  = '97023000' 
and		codigo_moneda = @codigo_moneda

end

GO
