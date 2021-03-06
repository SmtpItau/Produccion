USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_ANU_VNT_PPA]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVA_ANU_VNT_PPA]
    (
          @noperacion numeric (10,0) 
          
    )
AS
BEGIN

set nocount on

 DECLARE @x           integer  ,
         @suma        integer  ,
         @nnumdocu    numeric (10,0) ,
         @ncorrela    numeric (03,0) ,
         @ctipoper    char (03) ,
         @nnumoper    numeric (10,0) ,
         @nnominal    numeric (19,4) ,
         @nvalcomp    numeric (19,4) ,
         @nvalcomu    numeric (19,4) ,
         @nvptirc     numeric (19,4) ,
         @ncapitalv   numeric (19,4) ,
         @ninteresv   numeric (19,4) ,
         @nreajustv   numeric (19,4) ,
         @nvalvenc	  numeric (19,4), --nuevo rt
		 @mensaje	  Char(255),
         @Fechahoy    datetime,
         @Fecha       datetime
 DECLARE @ValMerProporcional	NUMERIC(21,4)	--> AFS

 select @x        = 1 ,
        @suma     = 0 ,
        @ctipoper = ''


	SELECT @Fechahoy     =  acfecproc 
	 FROM TEXT_ARC_CTL_DRI


 create table #TEMP
   (
         tipoper        char (03) not null ,
         numdocu        numeric (10,0) not null ,
         correla        numeric (03,0) not null ,
         numoper        numeric (10,0) not null ,
         nominal        numeric (19,4) not null ,
         valcomp        numeric (19,4) not null ,
         valcomu        numeric (19,4) not null ,
         vptirc         numeric (19,4) not null ,
         capitalv       numeric (19,4) not null ,
         interesv       numeric (19,4) not null ,
         reajustv       numeric (19,4) not null ,
         registro       integer identity(1,1) not null,
         valvenc        numeric (19,4) not null, --nuevo rt
         mofecpago      datetime,
         vmercado		numeric(21,4)	--> AFS
   )


 insert #TEMP
 select motipoper  ,
        monumdocu  ,
        mocorrelativo  ,
        monumoper  ,
        monominal  ,
        movalcomp  ,
        movalcomu  ,
        movpresen  ,
        isnull(movalcomp,0) ,
        isnull(mointeres,0) ,
        isnull(moreajuste,0),
        isnull(movalvenc,0) ,--nuevo rt
        mofecpago,
        isnull(ValorMercado_prop,0)		--> AFS
 from text_mvt_dri
 where monumoper=@noperacion and motipoper='VP'

 begin transaction

  while (@x = 1)
  begin
   	select @ctipoper = '*'
   	set rowcount 1 
	   select @ctipoper = isnull(tipoper,'*') ,
        	  @nnumdocu = numdocu  ,
	          @ncorrela = correla  ,
	          @nnumoper = numoper  ,
	          @nnominal = nominal  ,
	          @nvalcomp = valcomp  ,
	          @nvalcomu = valcomu  ,
	          @nvptirc  = vptirc  ,
	          @ncapitalv= capitalv  ,
	          @ninteresv= interesv  ,
	          @nreajustv= reajustv  ,
	          @suma     = registro  ,
	          @nvalvenc = valvenc   ,-- nuevo rt
			  @Fecha    = mofecpago ,
			  @ValMerProporcional	= vmercado --> AFS
	   from #TEMP
	   where registro>@suma
	   set rowcount 0 

	   if @ctipoper='*'
	    break

      IF @Fecha = @Fechahoy 
      BEGIN
	   UPDATE text_ctr_inv
	   SET cpnominal	= cpnominal		+ @nnominal  ,
	       cpvalcomp	= cpvalcomp		+ @nvalcomp  ,
	       cpvalcomu	= cpvalcomu		+ @nvalcomu  ,
		   cpvptirc		= cpvptirc		+ @nvptirc   ,
	       cpcapital	= cpcapital		+ @ncapitalv ,
	       cpinteres	= cpinteres		+ @ninteresv ,
	       cpreajust	= cpreajust		+ @nreajustv ,
	       cpvalvenc    = cpvalvenc		+ @nvalvenc,  --nuevo rt
	       cpprincipal  = (cpnominal	+ @nnominal) * (cppvpcomp/100)
	    ,  cpvalmerc	= cpvalmerc		+ @ValMerProporcional	--> AFS
	   WHERE cpnumdocu=@nnumdocu and cpcorrelativo = 1
-- select * from text_ctr_inv

	IF @@error<>0
	BEGIN
		rollback transaction
	    	SELECT  '1', 'No se Pudo Anular Operacion'
		return
   	END

      END ELSE BEGIN

   	   UPDATE text_ctr_inv
	   SET cpnomi_vta = cpnomi_vta -  @nnominal  
	   WHERE cpnumdocu=@nnumdocu and cpcorrelativo = 1

      END 

   
       -- vb+- 04/07/2000
       -- elimino cortes de tabla de cortes vendidos      
       -- ===================================================
      --  ===================================================

	UPDATE text_mvt_dri
	SET mostatreg = 'A'
   	WHERE monumoper=@noperacion and monumdocu=@nnumdocu and mocorrelativo=@ncorrela

	UPDATE text_ctr_cpr
	SET mostatreg = 'A'
   	WHERE monumoper=@noperacion and monumdocu=@nnumdocu and mocorrelativo=@ncorrela


   	IF @@error<>0
   		BEGIN
	    	ROLLBACK TRANSACTION
	    	SELECT  @mensaje = 'No se Pudo Anular Operacion'
	    	RETURN
   	END
	   --EXECUTE SP_LINEAS_AUMENTA 'BTR', @NOPERACION, @NNUMDOCU, @NCORRELA, @NVALCOMP
  END

	SELECT '0', 'Operacion Fue Anulada Correctamente'

	COMMIT TRANSACTION

	SET NOCOUNT OFF

END

GO
