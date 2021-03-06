USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CO51]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CO51 '20211129'
CREATE PROC [dbo].[CO51] (@dFechaProceso	DateTime=Null)
as
begin
SET NOCOUNT ON

--declare @dFechaProceso	DateTime
--set @dFechaProceso	='20220329'



if @dFechaProceso is null  
begin   
 set @dFechaProceso = (select acfecproc from bactradersuda..mdac)  
end  

Declare @CO51_SALIDA Table ( REG_SALIDA  Varchar(130))  

Declare @CO51 table(
			ctry			CHAR(3)			--		1
,			intf_dt			CHAR(8)			--		2
,			src_id 			CHAR(14)		--		3
,			cem	 			VARCHAR(3)		--		4
,			con_no	 		CHAR(20)		--		5
,			ident_cli	 	CHAR(12)		--		6
,			rel_typ			CHAR(2)			--		7
,			prod	 		CHAR(16)		--		8
,			reln_pct	 	NUMERIC(6,3)	--		9
,			val_lim_per	 	NUMERIC(14)		--		10
)

INSERT INTO @CO51
SELECT 
		'CL '														AS			ctry												--		1	
,		LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))					as			intf_dt												--		2	
,		'CO51' + SPACE(10)											as			src_id												--		3	
,		'001'														as			cem													--		4
,		ltrim(rtrim(CAST(rs.rsnumdocu AS VARCHAR(8)) +  ltrim(rtrim(rs.rscorrelativo)) + CAST( rs.rsnumoper AS VARCHAR(8)))) AS			con_no	--		5
,		right(replicate('0',12)+convert(varchar(10),clrut)+cldv,12) as			Ident_cli											--		6
,		'00'														as			rel_typ												--		7
,		'MD01' + SPACE(12)															as			prod												--		8
,		0															AS			reln_pct											--		9
,		0															AS			val_lim_per											--		10

FROM		
			BacBonosExtSuda..text_rsu rs	with(nolock)
inner JOIN	BacParamSuda.dbo.Cliente    C	with(nolock) ON  c.clrut    = rs.rsrutcli  AND  c.clcodigo = rs.rscodcli  
--left  Join BacParamSuda.dbo.Emisor Emi			with(nolock) On	Emi.emrut		= rs.rsrutemis
WHERE rsfecpro=@dFechaProceso	AND rscartera='333'
AND		rstipoper = 'DEV'
AND rsnominal    != 0 

Declare @TipoSalida bit = 0
Declare @Pie_Archivo Varchar(20) = ''
Declare @iCantidadRegistros int = 0

set @iCantidadRegistros = (select count(1) from @CO51)
set @Pie_Archivo		= '99'+LTRIM(RTRIM(CONVERT(CHAR(10),getdate(),112)))+REPLICATE('0', 10 - len(LTRIM(RTRIM(@iCantidadRegistros))))+RTRIM(RTRIM(@iCantidadRegistros))

if @TipoSalida != 0
	SELECT 
				  ctry																				--		1																							
				, intf_dt																			--		2																				
				, src_id																			--		3																				
				, cem																				--		4	
				, left(con_no+space(20), 20)	 AS con_no																			--		5	
				, Ident_cli																			--		6	
				, rel_typ																			--		7																			
				, prod																				--		8																																		
				, right(replicate(0,6)+convert(varchar(6),convert(numeric(6),abs(reln_pct*1000))),6) reln_pct
				, right(replicate(0,14)+convert(varchar(14),convert(numeric(14),abs(val_lim_per))),14) val_lim_per
	
	FROM @CO51 	order by con_no , ident_cli ,cem , prod , rel_typ
else
	begin
		insert into @CO51_SALIDA
		select 
				  ctry																				--		1																							
				+ intf_dt																			--		2																				
				+ src_id																			--		3																				
				+ cem																				--		4	
				+ left(con_no+space(20), 20)														--		5	
				+ Ident_cli																			--		6	
				+ rel_typ																			--		7																			
				+ prod																				--		8																																		
				+ right(replicate(0,6)+convert(varchar(6),convert(numeric(6),abs(reln_pct*1000))),6)
				+ right(replicate(0,14)+convert(varchar(14),convert(numeric(14),abs(val_lim_per))),14)
				from @CO51 
				order by con_no , ident_cli ,cem , prod , rel_typ
		
--		insert into @CO51_SALIDA
--		select @Pie_Archivo

		select * from @CO51_SALIDA
	end 


end
GO
