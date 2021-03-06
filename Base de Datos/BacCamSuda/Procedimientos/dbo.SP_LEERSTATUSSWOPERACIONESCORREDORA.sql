USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERSTATUSSWOPERACIONESCORREDORA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_LEERSTATUSSWOPERACIONESCORREDORA]
AS
BEGIN

	if Exists ( select 1  from memo  where motipmer = 'CCBB' and  mofech = (select ACFECPRO from meac )  and moestatus != '' )
	Begin
		if Exists( select 1  from memo  where motipmer = 'CCBB' and monumfut   = 0 and morutcli  != 97023000 and moestatus != 'A' and  MOFECH = ( select ACFECPRO from meac ) )
			select 0, 'Existen operaciones CCBB sin netear.'
		Else
			select 1, 'No existen operaciones CCBB para hoy.'

	End 
	Else
		select 1, 'No existen operaciones CCBB para hoy.'

END 



GO
