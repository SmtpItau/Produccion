USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_ANU_VNT_PPA_IM]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVA_ANU_VNT_PPA_IM]
    (
          @nOperacion numeric (10,0) 
          
    )
/*

JBH, 02-11-2009, Anulación de Ventas Intramesas

*/
AS
BEGIN
	SET NOCOUNT ON
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
         	@nvalvenc numeric (19,4), --nuevo rt
 	@mensaje	Char(255),
         	@Fechahoy     datetime,
         	@Fecha     datetime

 	select 	@x        = 1 ,
        	@suma     = 0 ,
        	@ctipoper = ''

	SELECT @Fechahoy     =  acfecproc 
	FROM TEXT_ARC_CTL_DRI

 	create table #TEMP
	(
       	tipoper char (03) not null ,
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
        mofecpago      datetime      
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
        isnull(movalvenc,0) ,
        mofecpago
 from MOV_ticketbonext
 where monumoper=@noperacion and motipoper='VP'

 BEGIN TRANSACTION

	WHILE (@x = 1)
  	BEGIN
   		SELECT @ctipoper = '*'
   		SET ROWCOUNT 1 
		SELECT @ctipoper = isnull(tipoper,'*') ,
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
	        	@nvalvenc = valvenc   ,
                	@Fecha    = mofecpago                
		FROM #TEMP
	   	WHERE registro>@suma

	   	SET rowcount 0 
  
	   	IF @ctipoper='*'
	    		BREAK
            
      		IF @Fecha = @Fechahoy 
		BEGIN
	   		UPDATE CAR_ticketbonext
	   		SET cpnominal  = cpnominal   + @nnominal  ,
	   	    	cpvalcomp  = cpvalcomp   + @nvalcomp  ,
	       		cpvalcomu  = cpvalcomu   + @nvalcomu  ,
	       		cpvptirc   = cpvptirc    + @nvptirc   ,
	       		cpcapital = cpcapital  + @ncapitalv ,
	       		cpinteres = cpinteres  + @ninteresv ,
	       		cpreajust = cpreajust  + @nreajustv ,
			cpvalvenc  = cpvalvenc   + @nvalvenc,
	       		cpprincipal = (cpnominal   + @nnominal) * (cppvpcomp/100)  	 
	   		WHERE cpnumdocu=@nnumdocu AND cpcorrelativo = 1

			IF @@error<>0
			BEGIN
				rollback transaction
	    			SELECT  '1', 'No se Pudo Anular Operacion'
			RETURN
   		END

      	END 
	ELSE 
	BEGIN
   		UPDATE CAR_ticketbonext
	   	SET cpnomi_vta = cpnomi_vta -  @nnominal  
	   	WHERE cpnumdocu=@nnumdocu AND cpcorrelativo = 1

      	END 

   
       -- vb+- 04/07/2000
       -- elimino cortes de tabla de cortes vendidos      
       -- ===================================================
      --  ===================================================

	UPDATE MOV_ticketbonext
	SET mostatreg = 'A'
   	WHERE monumoper=@noperacion AND monumdocu=@nnumdocu AND mocorrelativo=@ncorrela

   	IF @@error<>0
 	BEGIN
	    	ROLLBACK TRANSACTION
	    	SELECT  @mensaje = 'No se Pudo Anular Operacion'
	    	RETURN
   	END
	  
  END

  SELECT '0', 'Operacion Fue Anulada Correctamente'

 COMMIT TRANSACTION

SET NOCOUNT OFF

end

GO
