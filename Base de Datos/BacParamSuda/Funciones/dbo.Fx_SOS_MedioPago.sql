USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_SOS_MedioPago]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fx_SOS_MedioPago]
	(	@iMedioPago	int	)
		returns		char(1)
as
begin

	declare @cRetorno	char(1)
			/*
		set @cRetorno	= case	when @iMedioPago in(100,222,144)									then '0'	--> Efectivo
								when @iMedioPago in(123,2,3,141)									then '1'	--> Efectivo / Documentos Mismo Banco
								when @iMedioPago in(11,12,13,14,60,61,128,129,130,131,134,135,136)	then 'E'	--> Pago Electronico
								when @iMedioPago in(132,133,137,138,139)							then '7'	--> Deposito DCV
								when @iMedioPago in(5, 8, 102)										then '6'	--> Vale Vista / Cheq. Fiscales
								when @iMedioPago in(6,7,103, 104, 105,106,122,124,125)				then 'F'	--> Cuenta Corriente
								when @iMedioPago in(142)											then '8'	-->	Documentos Sobre NY
								when @iMedioPago in(15,16,17)										then 'D'	--> Tercero Otro banco
								when @iMedioPago in(143)											then 'G'	--> Caja
								when @iMedioPago in(0)												then '0'
							end
			*/

		-->	(Maial del 18-07-2014 11:16 Mario Gonzalez
		set @cRetorno	= case	when @iMedioPago in(123, 15, 16, 143, 20, 144, 140, 19) then 'L'	--> Transferencia 
								when @iMedioPago in(17, 103, 104, 8, 105, 106, 134, 135, 136, 124, 125, 122, 137, 138, 139, 132, 133, 128, 129, 130, 12, 13, 14, 11, 131) then 'M'	--> Cuenta Contable
								else 'N' --> Definido el 21-07-2014 por Roberto Fuentes
							end
		-->	(Maial del 18-07-2014 11:16 Mario Gonzalez

	return @cRetorno
	
end

GO
