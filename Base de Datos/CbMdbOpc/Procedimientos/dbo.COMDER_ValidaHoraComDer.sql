USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[COMDER_ValidaHoraComDer]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[COMDER_ValidaHoraComDer]

AS 
BEGIN

SET NOCOUNT ON

	declare @HoraServidor numeric(5)-- char(5) 
	declare @HoraComDer  numeric(5) --char(5) 
	declare @MinutoComder  numeric(5) --char(5) 
	declare @MinutoServidor  numeric(5) --char(5)

	
	select @HoraServidor = convert(char(2),DATEPART(hour, getdate()))
	select @MinutoServidor = convert(char(2),DATEPART(minute, getdate()))
	set @HoraComDer = (select convert(char(2),nHoraLimite) from COMDER_ControlHorario where iId = 1)
	set @MinutoComder = (select convert(char(2),nMinutoLimite) from COMDER_ControlHorario where iId = 1)



	IF @HoraComDer > @HoraServidor 
	begin
		Select 'True'
		return
	end
	IF @HoraComDer = @HoraServidor and @MinutoComDer >= @MinutoServidor 
	begin
		Select 'True'
	end
	else
	begin
		Select 'False'
	end


END

GO
