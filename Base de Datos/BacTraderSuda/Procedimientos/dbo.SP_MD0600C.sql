USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0600C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MD0600C]
                           (     @modcal     INTEGER          ,
    @dfeccal    DATETIME         ,
    @ncodigo    INTEGER          ,
    @cmascara   CHAR(12)         ,     
    @nmonemi    INTEGER          ,
    @dfecemi    DATETIME         ,
    @dfecven    DATETIME         ,
    @ftasemi    FLOAT            ,
    @fbasemi    FLOAT            ,
    @ftasest    FLOAT            ,
    @fnominal   FLOAT    OUTPUT  ,
    @ftir       FLOAT    OUTPUT  ,
    @fpvp       FLOAT    OUTPUT  ,
    @fmt        FLOAT    OUTPUT  ,
    @fmtum      FLOAT    OUTPUT  ,
    @fmt_cien   FLOAT    OUTPUT  ,
    @fvan       FLOAT    OUTPUT  ,
    @fvpar      FLOAT    OUTPUT  ,
    @nnumucup   INTEGER  OUTPUT  ,
    @dfecucup   DATETIME OUTPUT  ,
    @fintucup   FLOAT    OUTPUT  ,
    @famoucup   FLOAT    OUTPUT  ,
    @fsalucup   FLOAT    OUTPUT  ,
    @nnumpcup   INTEGER  OUTPUT  ,
    @dfecpcup   DATETIME OUTPUT  ,
    @fintpcup   FLOAT    OUTPUT  ,
    @famopcup   FLOAT    OUTPUT  ,
    @fsalpcup   INTEGER  OUTPUT  ,
                                @fdurat     FLOAT    OUTPUT  ,
                                @fconvx     FLOAT    OUTPUT  ,
                                @fdurmo     FLOAT    OUTPUT  )
as
begin
  declare @ntera     numeric(08,04)
-- busqueda en de serie en MDSE
--/////////////////////////////
  set rowcount 1
  select @ntera=-1.0
  set rowcount 0
	if substring(rtrim(@cmascara),1,6) = 'FMUTUO'
	begin
		if @modcal = 1
        	begin
			set @fmt = @fnominal * @fpvp
                        IF @nmonemi = 999
                           set @fmt = ROUND(@fmt, 4)
		end
   	        else
		begin
                     if @fnominal = 0
                     begin
			set @fnominal = @fmt / @fpvp
                     end
                     else
                     begin
			set @fpvp = @fmt / @fnominal
                     end
		end
	end
end



GO
