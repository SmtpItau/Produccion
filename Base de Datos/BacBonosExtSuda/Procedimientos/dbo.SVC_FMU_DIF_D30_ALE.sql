USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_FMU_DIF_D30_ALE]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_FMU_DIF_D30_ALE] (
			@fecini		DATETIME,
			@fecvto		DATETIME )

AS BEGIN

declare @DIFDIAS	INTEGER
        IF DATEPART(day,@fecvto)=31	and  DATEPART(day,@fecini)=31	
             SELECT @DIFDIAS = 0
        ELSe 
	if DATEPART(day,@fecvto)=31	
            SELECT @DIFDIAS = (  30 - DATEPART(day,@fecini)  )
	ELSE
	if DATEPART(day,@fecini)=31	
            SELECT @DIFDIAS = DATEPART(day,@fecvto) - 30 
	ELSE
            SELECT @DIFDIAS = DATEPART(day,@fecvto) - DATEPART(day,@fecini)


select @DIFDIAS
select (( DATEPART(year,@fecvto)- DATEPART(year,@fecini))* 360)+(( DATEPART(month,@fecvto) - DATEPART(month,@fecini))*30) 
	SELECT @DIFDIAS = (( DATEPART(year,@fecvto)- DATEPART(year,@fecini))* 360)+(( DATEPART(month,@fecvto) - DATEPART(month,@fecini))*30) + @DIFDIAS

	SELECT @DIFDIAS 
END


--   dias := if(day(fecvto)=31,30,day(fecvto))-if(day(fecini)=31,30,day(fecini))
--   dias := ((year(fecvto)-year(fecini))*360)+((month(fecvto)-month(fecini))*30)+dias
/*

declare @fecini	DATETIME,
	@fecvto	DATETIME,
	@DIFDIAS NUMERIC(09)

select @fecini	='20010915',
	@fecvto	='20011231'


				EXECUTE sp_invext_calular_dif_dia_30 @fecini, @fecvto, @DIFDIAS OUTPUT

select @DIFDIAS
*/

GO
