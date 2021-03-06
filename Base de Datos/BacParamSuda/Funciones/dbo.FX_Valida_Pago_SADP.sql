USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FX_Valida_Pago_SADP]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create function [dbo].[FX_Valida_Pago_SADP]

(

	  @nContrato		numeric(10,0)

	, @IdEntidad		int 

	, @IdModulo			int 

	, @Fecha_Operacion  datetime

	

)returns int

as

begin 

declare @OperacionPagada int

	,	@idEstado		 int



	set @idEstado		 = ISNULL((select  isnull(idEstado  , 0)

											  from  db_sadp_filiales.dbo.SADP_DetOperaciones sdo with(nolock)

											 where	sdo.idEntidad		= @IdEntidad 	--> 1- Banco 							 

											 and	sdo.iOPE_Operacion	= @nContrato	--> 5- Swaps	--> 2- BFW

											 and	sdo.dOPE_Fecha		= @Fecha_Operacion 

											 and	sdo.idModulo		= @IdModulo

								), 0)



	set @OperacionPagada = isnull( 

								(CASE WHEN @idEstado = 4 THEN 1

								ELSE 0 END)

							,0)



	return @OperacionPagada

end






GO
