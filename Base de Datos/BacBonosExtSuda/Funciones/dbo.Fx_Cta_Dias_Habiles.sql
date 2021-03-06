USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Cta_Dias_Habiles]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[Fx_Cta_Dias_Habiles] (
    @fromDate   date,   --- Start date
    @toDate     date,    --- End date
	@CadenaPaises varchar(100)
)
RETURNS numeric(10)             
AS

BEGIN
	DECLARE @nDia			INTEGER  
	DECLARE @nMonth			INTEGER  
	DECLARE @nAno			INTEGER  
	DECLARE @feriado		NUMERIC(01)  
	DECLARE @cCampo			CHAR(100)
	DECLARE @sabado			INTEGER  
	DECLARE @domingo		INTEGER 
	DECLARE @primerdiasql	INTEGER
	DECLARE @nCou			INTEGER       
	DECLARE @nFin			INTEGER  
	DECLARE @xDia			INTEGER  
	DECLARE @cdia			CHAR(04)  	
	
	SELECT @nDia   = DATEPART(DAY,   @toDate)  
	SELECT @nMonth = DATEPART(MONTH, @toDate)  
	SELECT @nAno   = DATEPART(YEAR , @toDate)  

	
	--+++jcamposd 20170324
	--si la fecha final es dia inhabil se debe considerar ultimo dia habil anterior fecha inhabil solo plaza brasil
	
	IF @CadenaPaises like '%;220;%' OR @CadenaPaises like '%220%'
	BEGIN
	
		SELECT @sabado = 7  
		SELECT @domingo = 1  
  
		SELECT @primerdiasql = CASE @@DATEFIRST WHEN 1 THEN 0 ELSE 1 END   
  
		IF @primerdiasql = 0  
		BEGIN  
			SELECT @sabado = 6  
			SELECT @domingo = 7      
		END  
		
		SELECT @cCampo = (CASE WHEN @nMonth = 1  THEN feene  
                          WHEN @nMonth = 2  THEN fefeb  
                          WHEN @nMonth = 3  THEN femar  
                          WHEN @nMonth = 4  THEN feabr  
                          WHEN @nMonth = 5  THEN femay  
                          WHEN @nMonth = 6  THEN fejun  
                          WHEN @nMonth = 7  THEN fejul  
                          WHEN @nMonth = 8  THEN feago  
                          WHEN @nMonth = 9  THEN fesep  
                          WHEN @nMonth = 10 THEN feoct  
                          WHEN @nMonth = 11 THEN fenov  
                          WHEN @nMonth = 12 THEN fedic  
                     END) FROM BACTraderSuda..VIEW_FERIADO   
         WHERE feano = @nano AND feplaza = 220  
         
		SELECT @nCou = 1  
  
		WHILE ( @nCou < 51 ) BEGIN  

			SELECT @feriado = 0  
  
			SELECT @xDia = CONVERT( INTEGER, SUBSTRING( @cCampo,( (@nCou - 1 ) * 3 ) + 1, 2 ) )  
			SELECT @nFin = DATEPART( dw, @toDate )  
	  
		 IF @nFin = @sabado OR @nFin = @domingo BEGIN  
				SELECT @feriado = -1  
				SET @nCou = 51  
		 END  
	  
		 If @nDia = @xDia  BEGIN  
			SELECT @feriado = -1  
			SET @nCou = 51  
		 END  
	  
		 If @nDia = 0 BEGIN  
			SELECT @feriado = 0  
			BREAK  
		 END  
	  
		 SELECT @nCou = @nCou + 1  
	  
	   END
         
		IF @feriado <0
		BEGIN
			IF DATEPART(WEEKDAY, @toDate) NOT IN (7,1)
			BEGIN
				SET @toDate = DATEADD(DAY,-1,@toDate) 
			END
		END
	
		
		-->REVISAR CONTEO DE DIAS EJEMPLO DESDE 28/12/2016 al 01/01/2017 = 2 días
		DECLARE @FERIADOFINDE CHAR(1) = 'N'  
				,@Hoy INT  
   
				SET @Hoy = (SELECT DATEPART(WEEKDAY, @toDate))  
     
				IF @Hoy in (7, 1) SET @FERIADOFINDE = 'S'  
   
				IF @FERIADOFINDE = 'S'  
				BEGIN    
					WHILE @FERIADOFINDE = 'S'  
					BEGIN  
						SET @Hoy = (SELECT DATEPART(WEEKDAY, @toDate))  
						IF @Hoy in (7, 1)  
						BEGIN  
							SET @toDate = DATEADD(DAY,-1,@toDate) 
						END   
						ELSE  
						BEGIN   
							SET @FERIADOFINDE = 'N'  
						END  
					END  
				END    
	END		
	
	------jcamposd 20170324

     -- Niumero de días hábiles entre la fechadesde inclusive y la fecha hasta exclusive
    declare @fecaux1 datetime
	declare @fecaux2 datetime 
	declare @Cnt     numeric(10)

	set     @Cnt     = 0

    set     @fecaux1 = @fromDate -- dateadd( dd, 1, @fromDate ) 
	while   @fecaux1 < @toDate 
	begin
	   select @fecAux2 = bacparamsuda.dbo.fx_regla_feriados_internacionales( @fecaux1, @CadenaPaises )
	   if @fecAux2 = @fecaux1 -- and @fecaux1 <= @toDate -- día hábil
	   begin
	      set @Cnt = @Cnt + 1
	   end
	   set @fecaux1 = dateadd( dd, 1,  @fecaux1 )
	end
	Return @Cnt 
	-- Return 285  -- 287:BAC  288:868.760  289:868.335 286:869.6093220 285:870.034
END
-- select dbo.Fx_Cta_Dias_Habiles( '20140307', '20170307', ';220;' ) -- 753 754
-- select dbo.Fx_Cta_Dias_Habiles( '20140703', '20170703', ';220;' ) -- 753 754
-- select dbo.Fx_Cta_Dias_Habiles( '20160419', '20160420', ';220;' ) -- 0   1
-- select dbo.Fx_Cta_Dias_Habiles( '20080521', '20100701', ';220;' ) -- 0   1
-- select dbo.Fx_Cta_Dias_Habiles( '20080521', '20140307', ';220;' ) -- 0   1
-- select dbo.Fx_Cta_Dias_Habiles( '20160428', '20160907', ';220;' ) -- 0   1
/*
use bacparamsuda
GO
sp_helptext fx_regla_feriados_internacionales
select * from sysobjects where type in (  'p' ) and crdate <= '20151129' order by crdate desc

sp_Helptext SP_AGREGA_N_DIAS_HABILES
sp_Helptext SP_BUSCA_FERIADO_CHECK

select * from bacparamsuda.dbo.pais where nombre like '%BR%'
select * from bacparamsuda.dbo.TBL_FestivosFijos where FER_ORIGEN_PAIS = 220
*/
GO
