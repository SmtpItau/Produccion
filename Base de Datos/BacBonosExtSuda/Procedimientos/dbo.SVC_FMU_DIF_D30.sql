USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_FMU_DIF_D30]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SVC_FMU_DIF_D30] (
			@fecini		DATETIME,
			@fecvto		DATETIME,
			@DIFDIAS	INTEGER	OUTPUT,
			@Tipo       Varchar(2) = 'P' -- 'P' => Método Europeo 'PA' => Americano
			)
AS 
	BEGIN
		SELECT @DIFDIAS = dbo.Fx_SVC_FMU_DIF_D30( @fecini, @fecvto, @Tipo ) 
        END
GO
