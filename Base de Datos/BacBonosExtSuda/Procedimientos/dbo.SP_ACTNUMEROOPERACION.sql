USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTNUMEROOPERACION]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_ACTNUMEROOPERACION] 
(
				  @numOperacion	numeric ( 10 ) 
					)
							
AS
BEGIN

	SET NOCOUNT ON

	update  text_arc_ctl_dri 
	set 	acnumoper = @numOperacion

	IF @@error <> 0 BEGIN

	      SELECT -1,
        	     'Error: al actualizar numero de operacion'

	      SET NOCOUNT OFF         --ADO
	      RETURN

	END
	Select 'OK'

	SET NOCOUNT OFF

END

GO
