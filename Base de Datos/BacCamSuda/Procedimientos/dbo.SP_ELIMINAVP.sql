USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINAVP]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_ELIMINAVP]
    (
    @noperacion numeric (10,0) ,
    @rutcart numeric (09,0) ,
    @mensaje char (255) output
    ) with recompile
as
begin
 declare @x  integer  ,
  @suma  integer  ,
  @nnumdocu  numeric (10,0) ,
  @ncorrela numeric (03,0) ,
  @ctipoper char (03) ,
  @nnumoper       numeric (10,0) ,
  @nnominal       numeric (19,4) ,
  @nvalcomp       numeric (19,4) ,
  @nvalcomu       numeric (19,4) ,
  @nvptirc        numeric (19,4) ,
  @ncapitalv      numeric (19,4) ,
  @ninteresv      numeric (19,4) ,
  @nreajustv      numeric (19,4)
 select @x  = 1 ,
  @suma  = 0 ,
  @ctipoper = ''
 create table #TEMP
   (
   tipoper  char (03) not null ,
   numdocu  numeric (10,0) not null ,
     correla  numeric (03,0) not null ,
   numoper  numeric (10,0) not null ,
   nominal  numeric (19,4) not null ,
   valcomp         numeric (19,4) not null ,
   valcomu         numeric (19,4) not null ,
   vptirc          numeric (19,4) not null ,
   capitalv        numeric (19,4) not null ,
   interesv        numeric (19,4) not null ,
   reajustv        numeric (19,4) not null ,
   registro integer identity(1,1) not null
   )
 insert #TEMP
 select motipopero  ,
  monumdocuo  ,
  mocorrelao  ,
  monumoper  ,
  monominal  ,
  movalcomp  ,
  movalcomu  ,
  movpresen  ,
  isnull(movalcomp,0) ,
  isnull(mointeres,0) ,
  isnull(moreajuste,0)
 from MDMO
 where monumoper=@noperacion and motipoper='VP'
 begin transaction
  while (@x = 1)
  begin
   select @ctipoper = '*'
   set rowcount 1 
   select @ctipoper = isnull(tipoper,'*') ,
    @nnumdocu = numdocu  ,
    @ncorrela       = correla  ,
    @nnumoper       = numoper  ,
    @nnominal = nominal  ,
    @nvalcomp       = valcomp  ,
                         @nvalcomu       = valcomu  ,
    @nvptirc        = vptirc  ,
    @ncapitalv      = capitalv  ,
    @ninteresv      = interesv  ,
    @nreajustv      = reajustv  ,
    @suma  = registro
   from #TEMP
   where registro>@suma
   set rowcount 0 
  
   if @ctipoper='*'
    break
   update MDCP
   set cpnominal = cpnominal + @nnominal  ,
    cpvalcomp = cpvalcomp + @nvalcomp  ,
    cpvalcomu = cpvalcomu + @nvalcomu  ,
    cpvptirc = cpvptirc  + @nvptirc  ,
    cpcapitalc = cpcapitalc  + @ncapitalv ,
    cpinteresc = cpinteresc  + @ninteresv ,
    cpreajustc = cpreajustc  + @nreajustv
   where cpnumdocu=@nnumdocu and cpcorrela=@ncorrela
   if @@error<>0
   begin
    rollback transaction
    select @mensaje = ' no pudo actualizar cartera propia '
    return
   end
   update MDDI
   set dinominal = dinominal  + @nnominal ,
    divptirc = divptirc   + @nvptirc  ,
    dicapitalc = dicapitalc + @ncapitalv ,
    diinteresc = diinteresc + @ninteresv ,
    direajustc = direajustc + @nreajustv
   where dinumdocu=@nnumdocu and dicorrela=@ncorrela
   if @@error<>0
   begin
    rollback transaction
    select @mensaje = ' la disponibilidad no pudo actulizarse, la operaciÃ³n no fue anulada '
    return
   end
   update MDCO
   set cocantcortd = cocantcortd + cvcantcort
   from MDCV
   where conumdocu=@nnumdocu and cocorrela=@ncorrela and cvnumdocu=@nnumdocu and
    cvcorrela=@ncorrela and cvnumoper=@noperacion and comtocort=cvmtocort
   if @@error<>0
   begin
    rollback transaction
    select @mensaje = ' los cortes no pudo actulizarse, la operaciÃ³n no fue anulada '
    return
   end   
       -- vb+- 04/07/2000
       -- elimino cortes de tabla de cortes vendidos      
       -- ===================================================
   delete from MDCV 
   where cvnumdocu=@nnumdocu and cvcorrela=@ncorrela 
   and     cvnumoper=@noperacion 
   if @@error<>0
   begin
    rollback transaction
    select @mensaje = ' no se actualizo correctamente cortes vendidos, la operaciÃ³n no fue anulada '
    return
   end   
      --  ===================================================
   update MDMO
   set mostatreg = 'A'
   where monumoper=@noperacion and monumdocuo=@nnumdocu and mocorrelao=@ncorrela
   
   if @@error<>0
   begin
    rollback transaction
    select @mensaje = ' hubo error al actualizar el movimiento '
    return
   end
   EXECUTE Sp_Lineas_Aumenta 'BTR', @noperacion, @nnumdocu, @ncorrela, @nvalcomp
  end
  select @mensaje = ' operaciÃ³n anulada correctamente '
 commit transaction
end

GO
