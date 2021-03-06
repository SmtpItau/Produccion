USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INGRESA_OPERACION_COMEX]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INGRESA_OPERACION_COMEX] ( 
		  @cestado  CHAR(1) 	= ''
 		 ,@cusuario CHAR(15) 	= ''
		 ,@nnumoper NUMERIC(10) = ''
		 ,@cperfil  CHAR(6) 	= ''
		)
AS
BEGIN
	
SET NOCOUNT ON
		IF NOT EXISTS (SELECT * FROM TBL_PERFIL_COMEX WHERE nnumoper = @nnumoper)
		INSERT INTO TBL_PERFIL_COMEX (
				 nnumoper
				,cestado
				,cperfil
				,cusuario
		 			      ) 
		VALUES ( 	 @nnumoper
				,@cestado
				,@cperfil
				,@cusuario
			)

	SET NOCOUNT OFF

END

GO
