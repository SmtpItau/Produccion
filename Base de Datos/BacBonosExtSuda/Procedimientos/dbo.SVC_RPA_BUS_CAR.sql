USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPA_BUS_CAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_RPA_BUS_CAR] 
					(@fecpro		DATETIME)

AS
BEGIN	
	if exists(select * from text_mvt_dri where @fecpro = mofecpro and motipoper IN ('CP','VP')) begin
		SELECT 	monumoper	,--1
			motipoper	,--2
			b.nom_familia	,--3
			''		,--4	
			a.mofecpago	,--5
			''		,--6
			0		,--
			sum(a.monominal),--8
			sum(a.movalcomu),--9
			'cliente' = isnull((SELECT clnombre  FROM VIEW_CLIENTE WHERE a.morutcli = clrut and a.mocodcli = clcodigo ),'NO EXISTE')	,--10
			a.mostatreg 	,--11
			a.confirmacion	--12

		FROM	text_mvt_dri a, text_fml_inm b
		WHERE	mofecpro= @fecpro
		AND	a.cod_familia = b.cod_familia
		AND	motipoper IN ('CP','VP')
		GROUP BY monumoper,motipoper,b.nom_familia,a.mofecpago,a.morutcli,a.mocodcli,a.mostatreg,a.confirmacion
		ORDER 	BY monumoper
	end
	else begin
		select 'NO', 'No hay operaciones para esta fecha'
	end
	
END

GO
