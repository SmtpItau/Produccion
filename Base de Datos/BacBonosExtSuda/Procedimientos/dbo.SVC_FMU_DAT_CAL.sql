USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_FMU_DAT_CAL]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_FMU_DAT_CAL] 
(
   @tipo NUMERIC (1)
)
AS 
BEGIN

	SELECT * FROM text_var_frm WHERE tipo = @tipo ORDER BY orden

END


GO
