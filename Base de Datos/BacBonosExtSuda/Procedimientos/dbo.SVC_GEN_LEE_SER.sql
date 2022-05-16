USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_GEN_LEE_SER]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_GEN_LEE_SER]
AS
BEGIN
	SELECT cod_familia,
	       cod_nemo,
	       fecha_vcto	
	FROM TEXT_SER
	ORDER BY cod_nemo 
END

GO
