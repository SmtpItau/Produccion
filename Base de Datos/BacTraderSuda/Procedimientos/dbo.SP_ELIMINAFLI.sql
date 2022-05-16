USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINAFLI]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINAFLI]
                            (
                               @noperacion	numeric (10,0)  ,
                               @rutcart 	numeric (09,0)  ,
			       @tipo       	char(1) = ''	,
                               @mensaje 	char (255) output
                            )
as
begin
 declare @x             integer  ,
        @suma           integer  ,
        @nnumdocu       numeric (10,0) ,
        @ncorrela       numeric (03,0) ,
        @ctipoper       char (03) ,
        @nnumoper       numeric (10,0) ,
        @nnominal       numeric (19,4) ,
        @nvalcomp       numeric (19,4) ,
        @nvalcomu       numeric (19,4) ,
        @nvptirc        numeric (19,4) ,
        @ncapitalv      numeric (19,4) ,
        @ninteresv      numeric (19,4) ,
        @nreajustv      numeric (19,4) ,
        @nnominalp      numeric (19,4) ,
        @nvalcompori    numeric (19,4) ,
        @nvalvenc NUMERIC (19,4) -- nuevo rpt 
 select @x  = 1  ,
        @suma  = 0  ,
        @ctipoper = '' 

 create table #TEMP
    (
          tipoper     char(3)  not null ,
          numdocu     numeric (10,0)  not null ,
          correla     numeric (03,0)  not null ,
          numoper     numeric (10,0)  not null ,
          nominal     numeric (19,4)  not null ,
          valcomp     numeric (19,4)  not null ,
          valcomu     numeric (19,4)  not null ,
          vptirc      numeric (19,4)  not null ,
          capitalv    numeric (19,4)  not null ,
          interesv    numeric (19,4)  not null ,
          reajustv    numeric (19,4)  not null ,
          valcompori  numeric (19,4)  not null ,
          nominalp    numeric (19,4)  not null ,
          registro    integer identity(1,1) not null,
          valvenc     numeric (19,4) not null --nuevo rt
    )

set nocount on

 insert #TEMP
 select vitipoper  ,
        vinumdocu  ,
        vicorrela  ,
        vinumoper  ,
        vinominal  ,
        isnull(vivalcomp,0) ,
        isnull(vivalcomu,0) ,
        isnull(vivptirc,0) ,
        isnull(vicapitalv,0) ,
        isnull(viinteresv,0) ,
        isnull(vireajustv,0) ,
        isnull(vivcompori,0) ,
        isnull(vinominalp,0) ,
        isnull(vivalvenc,0) --- nuevo rt
 from MDVI
 where vinumoper=@noperacion

  while @x=1
  begin
   select @ctipoper='*'
   set rowcount 1
   select    @ctipoper     = isnull(tipoper,'*') ,
             @nnumdocu     = numdocu  ,
             @ncorrela     = correla  ,
             @nnumoper     = numoper  ,
             @nnominal     = nominal  ,
             @nvalcomp     = valcomp  ,
             @nvalcomu     = valcomu  ,
             @nvptirc      = vptirc  ,
             @ncapitalv    = capitalv  ,
             @ninteresv    = interesv  ,
             @nreajustv    = reajustv  ,
             @nnominalp    = nominalp  ,
             @nvalcompori  = valcompori  ,
             @suma         = registro  ,
             @nvalvenc     = valvenc    --nuevo rt
   from #TEMP
   where registro>@suma
 
   set rowcount 0 
  
   if @ctipoper='*' break

  if @ctipoper='CP'
   begin
   update MDCP
    set cpnominal  = cpnominal  + @nnominal  ,
        cpvalcomp  = cpvalcomp  + @nvalcomp  ,
        cpvalcomu  = cpvalcomu  + @nvalcomu  ,
        cpvptirc   = cpvptirc   + @nvptirc  ,
        cpcapitalc = cpcapitalc + @ncapitalv ,
        cpinteresc = cpinteresc + @ninteresv ,
        cpreajustc = cpreajustc + @nreajustv ,
        cpvcompori = cpvcompori + @nvalcompori,
        cpvalvenc  = cpvalvenc  + @nvalvenc
    where  cpnumdocu=@nnumdocu and cpcorrela=@ncorrela 
    if @@error<>0
    begin
     SELECT  @mensaje = 'No se Pudo Anular Operacion'
     return 1
    end         
   end
   update MDDI
   set dinominal  = dinominal  + @nnominal ,
       divptirc   = divptirc   + @nvptirc  ,
       dicapitalc = dicapitalc + @ncapitalv ,
       diinteresc = diinteresc + @ninteresv ,
       direajustc = direajustc + @nreajustv
   where dinumdocu=@nnumdocu and dicorrela=@ncorrela

   if @@error<>0
   begin    
    SELECT  @mensaje = 'No se Pudo Anular Operacion'
    return 1
   end         

   delete from MDVI where vinumdocu=@nnumdocu and vicorrela=@ncorrela and vinumoper=@noperacion
   if @@error<>0
   begin
    SELECT  @mensaje = 'No se Pudo Anular Operacion'
    return 1
   end         
   update MDCO
   set cocantcortd = cocantcortd + MDCV.cvcantcort
   from MDCV
   where conumdocu=@nnumdocu and cocorrela=@ncorrela and MDCV.cvnumdocu=@nnumdocu and MDCV.cvcorrela=@ncorrela and
    MDCV.cvnumoper=@noperacion and comtocort=MDCV.cvmtocort
   if @@error<>0
   begin
    SELECT  @mensaje = 'No se Pudo Anular Operacion'
    return 1
   end
    
       -- vb+- 04/07/2000
       -- elimino cortes de tabla de cortes vendidos      
       -- ===================================================

   delete from MDCV 
   where cvnumdocu     = @nnumdocu and cvcorrela=@ncorrela 
         and cvnumoper = @noperacion 
   if @@error<>0
   begin
    SELECT  @mensaje = 'No se Pudo Anular Operacion'
    return 1
   end   
      --  ===================================================

	IF @Tipo = 'M' 	BEGIN
		DELETE mdmo
        	WHERE monumoper   = @nOperacion     AND
                      monumdocuo  = @nNumdocu       AND
                      mocorrelao  = @nCorrela
        END 
        IF @Tipo = 'A' 	BEGIN
             UPDATE mdmo
             SET   mostatreg = 'A',
                   mohora    = CONVERT( CHAR(08), GETDATE(), 114)
             WHERE monumoper   = @nOperacion     AND
                   monumdocuo  = @nNumdocu       AND
                   mocorrelao  = @nCorrela
       END
      /*=========================================================================================*/
      /*=========================================================================================*/
      IF @@error <> 0 BEGIN
         SELECT @Mensaje = 'Hubo error al actualizar el Movimiento'
         RETURN 1
      END
 end

  SELECT @mensaje = 'Operacion Fue Anulada Correctamente'
  RETURN 0   

set nocount off
end


GO
