USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[TRASPASOSORTEOLCHR]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[TRASPASOSORTEOLCHR]
AS
BEGIN

   SELECT monumoper 
   ,      morutcart 
   ,      motipcart 
   ,      monumdocu 
   ,      mocorrela 
   ,      momonemi 
   ,      monominal 
   ,      morutemi 
   ,      mocodigo 
   ,      mofecpro
   ,      moid_libro
   ,     'puntero'  = identity(Int)
   INTO   #Traspaso_St
   FROM   MDMOPM 
   ,      MDAC
   WHERE  mofecpro    = acfecproc
   AND    SorteoLCHR  = 'S'
   AND    mostatreg  <> 'A'   

   declare @iContador    numeric(9)
   ,       @iRegistros   numeric(9)
   declare @nnumoper   	 NUMERIC (10,0) , -- numero de operaci½n de venta
           @nrutcart   	 NUMERIC (09,0) , -- rut de la cartera
           @ntipcart   	 NUMERIC (05,0) , -- codigo del tipo de cartera
           @nnumdocu   	 NUMERIC (10,0) , -- numero del  documento
           @ncorrela   	 NUMERIC (03,0) , -- correlativo de la operaciÂ½n
           @nmonemi    	 NUMERIC (03,0) , -- moneda del emISor
           @nnominal   	 NUMERIC (19,4) , -- nominales vENDidos
           @nrutemi    	 NUMERIC (09,0) , -- rut del emISor
           @ncodigo   	 NUMERIC (05,0) , -- codigo de la familia
           @cfecpro    	 DATETIME       , -- fecha de proces o (v)
           @iEstado      INTEGER        ,
           @cMensaje     VARCHAR(100)   ,
           @moid_libro   INTEGER
 
   select  @iContador    = min(puntero)
   ,       @iRegistros   = max(puntero)
   from    #Traspaso_St
   
   while  @iRegistros >= @iContador
   begin

      select @nnumoper   = monumoper 
      ,      @nrutcart   = morutcart 
      ,      @ntipcart   = motipcart 
      ,      @nnumdocu   = monumdocu 
      ,      @ncorrela   = mocorrela 
      ,      @nmonemi    = momonemi 
      ,      @nnominal   = monominal 
      ,      @nrutemi    = morutemi 
      ,      @ncodigo    = mocodigo 
      ,      @cfecpro    = mofecpro
      ,      @iEstado    = 0
      ,      @cMensaje   = ''
      ,      @moid_libro = moid_libro
      from   #Traspaso_St
      where  puntero     = @iContador
      
      execute Sp_InsertaSorteoLetras
             @nnumoper
      ,      @nrutcart
      ,      @ntipcart
      ,      @nnumdocu
      ,      @ncorrela
      ,      @nmonemi
      ,      @nnominal
      ,      @nrutemi
      ,      @ncodigo
      ,      @cfecpro
      ,      @moid_libro
      ,      @iEstado OUTPUT

      if @iEstado < 0
      begin
         SET @cMensaje = @cMensaje + 'Problemas en Op. ' + convert(char(9),@nnumoper) + char(10)
      end

      set @iContador = (@iContador + 1)

   end

   /*
   -- Agrega Reajustes para Sorteo de Letras
   DECLARE @iMax     NUMERIC(9)
   ,       @iMin     NUMERIC(9)
   ,       @iNumero  NUMERIC(9)
   ,       @iCorrel  NUMERIC(9)
   ,       @Interes  NUMERIC(21,4)
   ,       @Reajuste NUMERIC(21,4)
   ,       @Fecha1   DATETIME
   ,       @Fecha2   DATETIME
   ,       @iNomOrig NUMERIC(21,4)

   SELECT monumdocu
   ,      mocorrela
   ,      monumoper
   ,      mofecvenp AS mofecinip -- mofecinip
   ,      mofecpro  AS mofecvenp -- mofecvenp
   ,      'Puntero' = identity(Int)
   INTO   #TmpSorteo
   FROM   MDMO
   WHERE  SorteoLchr = 'S'
   */
   /*
   UPDATE MDMO
   SET    movpresen = (rsvppresenx * monominal)/rsnominal
   FROM   MDRS
   WHERE  rsfecha    = mofecvenp
   and    rstipoper  = 'DEV'
   and    rsnumdocu  = monumdocu 
   and    rscorrela  = mocorrela 
   and    SorteoLchr = 'S'

   SELECT  @iMax     = 0
   ,       @iMin     = 0

   SELECT  @iMax     = ISNULL(MAX(Puntero),0)
   FROM    #TmpSorteo

   SELECT  @iMin     = ISNULL(MIN(Puntero),0)
   FROM    #TmpSorteo

   WHILE (@iMax >= @iMin AND @iMax > 0)
   BEGIN
      SELECT @iNumero  = 0
      ,      @iCorrel  = 0
      ,      @Interes  = 0.0
      ,      @Reajuste = 0.0
      ,      @Fecha1   = '19000101'
      ,      @Fecha2   = '19000101'
      ,      @iNomOrig = 0.0

      SELECT @iNumero  = monumdocu
      ,      @iCorrel  = mocorrela
      ,      @Fecha1   = mofecinip
      ,      @Fecha2   = mofecvenp
      FROM   #TmpSorteo
      WHERE  Puntero   = @iMin

      SELECT @Reajuste = SUM(rsreajuste + rsinteres )
      ,      @iNomOrig = max(rsnominal)
      FROM   MDRS
      WHERE (rsfecha  >= @Fecha1 and rsfecha = @Fecha2)
        and  rstipoper = 'DEV'
        and  rsnumdocu = @iNumero
        and  rscorrela = @iCorrel
      GROUP BY rsnumdocu , rscorrela

      UPDATE MDMO
         SET movpresen = movpresen + ((ISNULL(@Reajuste,0) * monominal ) / @iNomOrig)
       WHERE monumdocu = @iNumero
         and mocorrela = @iCorrel

      SELECT @iMin = @iMin + 1
   END
   */

END

GO
