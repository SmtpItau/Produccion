USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOADTIPOPERACIONTICKET]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LOADTIPOPERACIONTICKET]
AS
	SELECT tbcodigo1, tbglosa
	  FROM bacparamsuda.dbo.tabla_general_detalle
	 WHERE tbcateg =8605;
	


GO
