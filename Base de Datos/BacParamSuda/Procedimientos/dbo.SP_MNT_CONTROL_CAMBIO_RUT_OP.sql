USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_CONTROL_CAMBIO_RUT_OP]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_MNT_CONTROL_CAMBIO_RUT_OP]
   (
			@iTab					integer   
	   ,    @Sistema				char(3)		 	
	   ,    @CodMotivo				CHAR(1) = ''
	   ,	@NroOperacion			numeric(7,0)
	   ,    @FechaModifica			datetime
	   ,	@RutOriginal			numeric(9,0)
	   ,	@CodClienteOriginal		numeric(9,0)
	   ,	@RutNuevo				numeric(9,0)
	   ,	@CodClienteNuevo		numeric(9,0)
   )
AS
BEGIN

   /*REGISTRO DE UNA NUEVA PREPARACION DE OPERACIONES */
	IF @iTab = 0
	BEGIN
		INSERT INTO TBL_CONTROL_CAMBIO_RUT_OP(ID_SISTEMA,COD_MOTIVO,NRO_OPERACION,FECHA_MODIFICA,RUT_ORIGINAL,COD_CLIENTE_ORIGINAL,RUT_NUEVO,COD_CLIENTE_NUEVO)
				VALUES( @Sistema,@CodMotivo,@NroOperacion,@FechaModifica,@RutOriginal,@CodClienteOriginal,@RutNuevo,@CodClienteNuevo)
	END

END

GO
