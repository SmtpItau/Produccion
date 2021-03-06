USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_IND_LEE_MON]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_IND_LEE_MON] 
(
   @dfecpro	datetime,
   @dfecprox	datetime 
)
as
begin

   set nocount on
    
   create table #TMP(tmcodmon	numeric	(3,0)	,
		      tmdescrip	char	(30)	,
		      tmvalpro	numeric	(18,11)	,
		      tmvalprox	numeric	(18,11) ,
		      tmcodbcch numeric (    5)	 	
		     )

   insert into #TMP 
   		select 	'tmcodmon'	= mncodmon	,
          		'tmdescrip'	= mnglosa	,
			'tmvalpro'	= 0.0		,
  			'tmvalprox'	= 0.0           ,
			'tmcodbcch'     = mncodbanco  

	        from	VIEW_moneda, VIEW_TABLA_GENERAL_DETALLE
		where	mncodmon= TBCODIGO1
		and	tbCATEG = 1109
	

   update #TMP
	set	tmvalpro	= vmvalor                        
	from	VIEW_valor_moneda
	where	vmcodigo=tmcodmon and vmfecha = @dfecpro

   update #TMP
	set	tmvalprox	= vmvalor
	from	VIEW_valor_moneda
	where	vmcodigo=tmcodmon  and vmfecha=@dfecprox

   select * from #TMP

   set nocount off

end

GO
