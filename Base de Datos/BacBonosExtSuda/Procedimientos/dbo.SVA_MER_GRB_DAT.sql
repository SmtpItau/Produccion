USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_MER_GRB_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SVA_MER_GRB_DAT]
(
              @FECHA	DATETIME	,
              @NUMDOCU	CHAR(12)	,
	      @TIR	NUMERIC(9,4)	,
	      @PVP	NUMERIC(19,4)	,
	      @VALMERC	NUMERIC(19,4)	,
	      @sw	numeric(2)	,
              @NewTir	NUMERIC(9,4)	
)
AS
BEGIN
SET NOCOUNT ON

	IF EXISTS(SELECT * FROM TEXT_RSU WHERE RSFECPRO = @FECHA AND RSNUMDOCU = @NUMDOCU )
		
	BEGIN
			if @sw = 9 begin
			

			UPDATE 	TEXT_RSU	
			SET 	RSTIRMERC 	= 	@TIR	,
				RSPVPMERC	=	@PVP	,
				RSVALMERC	= 	@VALMERC,
				sw_tir		= 	1	,
				sw_pvp		= 	0	,
				rstir		=	@NewTir,
				rsDiferenciaMerc = 	@VALMERC - rsvppresen	

				
		
			WHERE 	RSFECPRO  = @FECHA	
			AND	RSNUMDOCU = @NUMDOCU 


		end
		else begin
			
			UPDATE 	TEXT_RSU	
			SET 	RSTIRMERC 	= 	@TIR	,
				RSPVPMERC	=	@PVP	,
				RSVALMERC	= 	@VALMERC,
				sw_tir		= 	0	,
				sw_pvp		= 	1	,
				rstir		=	@NewTir,
				rsDiferenciaMerc = 	@VALMERC - rsvppresen
		
			WHERE 	RSFECPRO  = @FECHA	
			AND	RSNUMDOCU = @NUMDOCU 	
			
		end 

		if @valmerc > 0 begin
			update text_arc_ctl_dri set acsw_tm = 1
		end 	

	END
	ELSE
	BEGIN 
		SELECT 1
	END
	
SET NOCOUNT OFF
END




GO
