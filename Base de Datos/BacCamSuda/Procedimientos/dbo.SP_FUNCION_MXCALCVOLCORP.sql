USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNCION_MXCALCVOLCORP]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNCION_MXCALCVOLCORP](
                                            @vol_motipope  CHAR(1)   ,
      @vol_moticam   NUMERIC(19,4)  ,
      @vol_moussme   NUMERIC(19,4)  ,
      @vol_momonmo NUMERIC(19,4)  ,
      @vol_mocodmon  CHAR(3)   ,
      @vol_mocodcnv  CHAR(3)   ,
      @vol_motctra   NUMERIC(19,4)  ,
      @cp_totco     NUMERIC(19,4) OUTPUT ,
      @cp_totve     NUMERIC(19,4) OUTPUT ,
      @cp_totcop    NUMERIC(19,2) OUTPUT ,
      @cp_totvep    NUMERIC(19,2) OUTPUT ,
      @cp_pmeco     NUMERIC(15,4) OUTPUT ,
      @cp_pmeve     NUMERIC(15,4) OUTPUT ,
      @cp_pmecoci   NUMERIC(15,4) OUTPUT ,
      @cp_pmeveci   NUMERIC(15,4) OUTPUT
      )
AS
BEGIN
SET NOCOUNT ON
 
    DECLARE @Dolar30     NUMERIC(19,4)
    SELECT @cp_totco   = cp_totco   ,
           @cp_totve   = cp_totve   ,
           @cp_totcop  = cp_totcop  ,
           @cp_totvep  = cp_totvep  ,
           @cp_pmeco   = cp_pmeco   ,
           @cp_pmeve   = cp_pmeve   ,
           @cp_pmecoci = cp_pmecoci ,
           @cp_pmeveci = cp_pmeveci 
      FROM MEAC
   EXECUTE Sp_Funcion_MxMtoUsd30 @vol_mocodmon,@vol_momonmo,@Dolar30 OUTPUT
 
   IF @vol_motipope = 'C'
      BEGIN
         SELECT @cp_totco   = @cp_totco + @vol_moussme
         SELECT @cp_totcop  = @cp_totcop + ROUND( @vol_moussme * @vol_moticam , 0 )
  EXECUTE sp_div  @cp_totcop , @cp_totco , @cp_pmeco   OUTPUT
  EXECUTE sp_div  @cp_totcop , @cp_totco , @cp_pmecoci OUTPUT
      END
   ELSE      
      BEGIN
         SELECT @cp_totve   = @cp_totve + @vol_moussme
         SELECT @cp_totvep  = @cp_totvep + ROUND( @vol_moussme * @vol_moticam , 0 )
  EXECUTE sp_div  @cp_totvep , @cp_totve , @cp_pmeve   OUTPUT
  EXECUTE sp_div  @cp_totvep , @cp_totve , @cp_pmeveci OUTPUT
      END
   IF @vol_mocodmon <> 'USD'
      BEGIN
         IF @vol_motipope = 'C'
            BEGIN
               SELECT @cp_totve   = @cp_totve + ISNULL(@Dolar30,0)
               SELECT @cp_totvep  = @cp_totvep + ROUND( ISNULL(@Dolar30,0) * @vol_moticam , 0 )
  EXECUTE sp_div  @cp_totvep , @cp_totve , @cp_pmeve   OUTPUT
  EXECUTE sp_div  @cp_totvep , @cp_totve , @cp_pmeveci OUTPUT
            END
         ELSE      
            BEGIN
               SELECT @cp_totco   = @cp_totco + ISNULL(@Dolar30,0)
               SELECT @cp_totcop  = @cp_totcop + ROUND( ISNULL(@Dolar30,0) * @vol_moticam , 0 )
  EXECUTE sp_div  @cp_totcop , @cp_totco , @cp_pmeco   OUTPUT
  EXECUTE sp_div  @cp_totcop , @cp_totco , @cp_pmecoci OUTPUT
            END
         IF @vol_mocodcnv = 'CLP'
            BEGIN
               IF @vol_motipope = 'C'
                  BEGIN
                     SELECT @cp_totco   = @cp_totco + @vol_moussme
                     SELECT @cp_totcop  = @cp_totcop + ROUND( @vol_moussme * @vol_motctra , 0 )
   EXECUTE sp_div  @cp_totcop , @cp_totco , @cp_pmeco   OUTPUT
   EXECUTE sp_div  @cp_totcop , @cp_totco , @cp_pmecoci OUTPUT
                  END
               ELSE      
                  BEGIN
                     SELECT @cp_totve   = @cp_totve + @vol_moussme
                     SELECT @cp_totvep  = @cp_totvep + ROUND( @vol_moussme * @vol_motctra , 0 )
   EXECUTE sp_div  @cp_totvep , @cp_totve , @cp_pmeve   OUTPUT
   EXECUTE sp_div  @cp_totvep , @cp_totve , @cp_pmeveci OUTPUT
                  END
             
          END
      END
SELECT @cp_pmeve   = ROUND( @cp_pmeve   , 4 )
SELECT @cp_pmeveci = ROUND( @cp_pmeveci , 4 )
SET NOCOUNT OFF
   
End

GO
