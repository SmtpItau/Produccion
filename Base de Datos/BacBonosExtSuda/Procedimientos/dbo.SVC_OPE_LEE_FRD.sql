USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_OPE_LEE_FRD]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_OPE_LEE_FRD] 
(   
        @nAno   NUMERIC(4) 	,
        @cPlaza NUMERIC(3) 	,
	@MES	NUMERIC(2)	
)
AS
BEGIN
     	SET NOCOUNT ON
	declare @feriados varchar(60)

	SELECT	 @feriados = 
	
	CASE @MES
		WHEN 	1 	THEN (SELECT feene FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) 
		WHEN 	2 	THEN (SELECT fefeb FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) 
		WHEN 	3 	THEN (SELECT femar FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) 
		WHEN 	4 	THEN (SELECT feabr FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) 
		WHEN 	5 	THEN (SELECT femay FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) 
		WHEN 	6 	THEN (SELECT fejun FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) 
		WHEN 	7 	THEN (SELECT fejul FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) 
		WHEN 	8 	THEN (SELECT feago FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) 
		WHEN 	9 	THEN (SELECT fesep FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) 
		WHEN 	10	THEN (SELECT feoct FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) 
		WHEN 	11	THEN (SELECT fenov FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) 
		WHEN 	12	THEN (SELECT fedic FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) END

if (select count(*) FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza ) > 0 begin
	select feano , feplaza, 'feriados ' = isnull(@feriados,' ') FROM  VIEW_FERIADO WHERE feano = @nano AND feplaza =  @cPlaza 
end
else begin
	select 1
end 

END

GO
