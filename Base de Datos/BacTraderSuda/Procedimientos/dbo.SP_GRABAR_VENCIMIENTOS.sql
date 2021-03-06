USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_VENCIMIENTOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_VENCIMIENTOS]
   (
	@cpnumdocu 	numeric(10,0),
	@cpcorrela 	numeric(3,0),
	@cpinstser      varchar(20),
        @cppvpcomp	numeric(19,4),
        @cpvalcomp      numeric(19,4),
	@cpfecven	datetime
   )
AS
begin	
declare @@control_error	int		
set 	@@control_error = 0


		update mdmo 
			set mopvp=@cppvpcomp,
			    movpresen=@cpvalcomp
		where monumoper=@cpnumdocu
		and mocorrela=@cpcorrela
		and moinstser=@cpinstser
		and mofecven=@cpfecven

		set @@control_error = @@error
  




END


GO
