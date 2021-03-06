USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_CTL_BUS_CAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_CTL_BUS_CAR]
( 
    @fecpro	datetime	
)


as
begin
	set nocount on
	if exists(select * from text_rsu where rscartera = 333 and cod_familia = 2000 and rsfecpro = @fecpro) begin
		select  rsnumdocu	,--1
			cod_familia	,--2
			id_instrum	,--3
			rsfecemis	,--4
			rsfecvcto	,--5
			rstir		,--6
			rsnominal	,--7
			rsvalcomu	,--8
			ISNULL((select clnombre from VIEW_CLIENTE where clrut = rsrutcli and rscodcli = clcodigo),' '),--9
			(select count(*) from text_rsu where rscartera = '333'and cod_familia = 2000 and rsfecpro = @fecpro)--10
		from 	text_rsu
		where	rscartera = 333
		and 	cod_familia = 2000
		and	rsfecpro = @fecpro
		order by rsnumdocu
	end
	else begin
		select 'NO', 'No exixten datos para la fecha ' + convert(char(10), @fecpro,103)
	end 
	set nocount off

end


GO
