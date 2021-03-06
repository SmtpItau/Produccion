USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COGRABCORTES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_COGRABCORTES]
   (   @nrutcart   NUMERIC(9,0)
   ,   @nnumdocu   NUMERIC(10,0)
   ,   @ncorrela   NUMERIC(5,0)
   ,   @ncantcort  NUMERIC(10,0)
   ,   @nmontcort  NUMERIC(19,4)
   )
as
BEGIN

   SET NOCOUNT ON

   DECLARE @inCodigo   INTEGER
       SET @inCodigo   = ( SELECT cpcodigo FROM MDCP WITH(NOLOCK) WHERE cpnumdocu = @nnumdocu and cpcorrela = @ncorrela )

   IF @inCodigo = 9 OR @inCodigo = 11 OR @inCodigo = 13 OR @inCodigo = 14
   BEGIN
      SET NOCOUNT OFF
      SELECT 'OK'
      RETURN
   END

   INSERT INTO MDCO ( corutcart    ,
                      conumdocu    ,
                      cocorrela    ,
                      cocantcortd  ,
                      cocantcorto  ,
                      comtocort    )
          VALUES   (  @nrutcart    ,
                      @nnumdocu    ,
                      @ncorrela    ,
                      @ncantcort   ,
                      @ncantcort   ,
                      @nmontcort   )

   IF @@ERROR <> 0 
   BEGIN
      SET NOCOUNT OFF
      SELECT 'ERROR_PROC PROBLEMAS EN GRABACION DE CORTES.'
      RETURN -1
   END

   SET NOCOUNT OFF
   SELECT 'OK'
   RETURN
END

GO
