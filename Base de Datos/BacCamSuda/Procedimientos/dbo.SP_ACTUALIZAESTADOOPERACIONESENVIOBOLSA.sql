USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZAESTADOOPERACIONESENVIOBOLSA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_ACTUALIZAESTADOOPERACIONESENVIOBOLSA](
	@NroOperacion float,
	@Estado	      char
)
AS
BEGIN
	update BacCamSuda..TxOnlineCorredora 
	   set EstadoEnvio = '*', 
               Reserva=''  
         Where Id = @NroOperacion
	   and estado = @Estado
END
GO
