USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINAVP]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_ELIMINAVP]
       (
         @noperacion            NUMERIC(10,0),
         @rutcart               NUMERIC(09,0),
         @mensaje               CHAR(255)       OUTPUT
   )
AS
BEGIN

    DECLARE @x                  INTEGER
    DECLARE @suma               INTEGER
    DECLARE @nnumdocu           NUMERIC(10,0)
    DECLARE @ncorrela           NUMERIC(03,0)
    DECLARE @ctipoper           CHAR(03)
    DECLARE @nnumoper           NUMERIC(10,0)
    DECLARE @nnominal           NUMERIC(19,4)
    DECLARE @nvalcomp           NUMERIC(19,4)
    DECLARE @nvalcomu           NUMERIC(19,4)
    DECLARE @nvptirc            NUMERIC(19,4)
    DECLARE @ncapitalv          NUMERIC(19,4)
    DECLARE @ninteresv          NUMERIC(19,4)
    DECLARE @nreajustv          NUMERIC(19,4)
    DECLARE @nvalvenc           NUMERIC(19,4) --nuevo rt
    DECLARE @ntasaemi           NUMERIC(19,4)
    DECLARE @nprimadesc         NUMERIC(19,4)
    DECLARE @ValMerProporcional	NUMERIC(21,4)
    DECLARE @Sorteo             CHAR(01)
    DECLARE @Tabla              CHAR(01)         
    DECLARE @fecant             DATETIME
    DECLARE @fecproc            DATETIME

    SELECT  @fecant  = acfecante     ,
            @fecproc = acfecproc
    FROM    mdac

    SET @x        = 1
    SET @suma     = 0
    SET @ctipoper = ''
    SET @Tabla    = 1

    CREATE TABLE #TEMP
           (
             registro           INTEGER IDENTITY(1,1) NOT NULL,
             tipoper            CHAR(03)              NOT NULL,
             numdocu            NUMERIC(10,0)         NOT NULL,
             correla            NUMERIC(03,0)         NOT NULL,
             numoper            NUMERIC(10,0)         NOT NULL,
             nominal            NUMERIC(19,4)         NOT NULL,
             valcomp            NUMERIC(19,4)         NOT NULL,
             valcomu            NUMERIC(19,4)         NOT NULL,
             vptirc             NUMERIC(19,4)         NOT NULL,
             capitalv           NUMERIC(19,4)         NOT NULL,
             interesv           NUMERIC(19,4)         NOT NULL,
             reajustv           NUMERIC(19,4)         NOT NULL,
             valvenc            NUMERIC(19,4)         NOT NULL,
             tasaemi            NUMERIC(19,4)         NOT NULL,
             primadesc          NUMERIC(19,4)         NOT NULL,
             Sorteo             CHAR(01)              NOT NULL,
             vmercado			NUMERIC(21,4)		  NOT NULL	
           )

   IF EXISTS(SELECT 1 FROM MDMO WHERE monumoper = @noperacion)
   BEGIN
        SET @Tabla = 1

        INSERT INTO #TEMP
               SELECT motipopero,
                      monumdocuo,
                      mocorrela,
                      monumoper,
                      monominal,
                      movalcomp,
                      movalcomu,
                      movpresen,
                      ISNULL(   movalcomp, 0 ),
                      ISNULL(   mointeres, 0 ),
                      ISNULL(  moreajuste, 0 ),
                      ISNULL(   movalvenc, 0 ),
                      ISNULL( movaltasemi, 0 ),
                      ISNULL(  movpreseni, 0 ),
                      SorteoLchr,
                      ISNULL(ValorMercado_prop, 0)
                 FROM dbo.MDMO
                WHERE monumoper = @noperacion
                  AND motipoper = 'VP'

    END ELSE
    BEGIN
        SET @Tabla = 2

        INSERT INTO #TEMP
               SELECT motipopero,
                      monumdocuo,
                      mocorrelao,
                      monumoper,
                      monominal,
                      movalcomp,
                      movalcomu,
                      movpresen,
                      ISNULL(   movalcomp, 0 ),
                      ISNULL(   mointeres, 0 ),
                      ISNULL(  moreajuste, 0 ),
                      ISNULL(   movalvenc, 0 ),
                      ISNULL( movaltasemi, 0 ),
                      ISNULL(  movpreseni, 0 ),
                      SorteoLchr,
					  ISNULL( ValorMercado_prop, 0)
                 FROM dbo.MDMOPM
				WHERE monumoper = @noperacion
                  AND motipoper = 'VP'

    END

    WHILE (@x = 1)
    BEGIN

        SET @ctipoper = '*'

        SET ROWCOUNT 1 
        SELECT @ctipoper   = ISNULL( tipoper, '*' ),
               @nnumdocu   = numdocu,
               @ncorrela   = correla,
               @nnumoper   = numoper,
               @nnominal   = nominal,
               @nvalcomp   = valcomp,
               @nvalcomu   = valcomu,
               @nvptirc    = vptirc,
               @ncapitalv  = capitalv,
               @ninteresv  = interesv,
               @nreajustv  = reajustv,
               @suma       = registro,
               @nvalvenc   = valvenc,
               @ntasaemi   = tasaemi,
               @nprimadesc = primadesc,
               @Sorteo     = Sorteo,
               @ValMerProporcional = vmercado
          FROM #TEMP
         WHERE registro    > @suma
        SET ROWCOUNT 0 
  
        IF @ctipoper = '*'
        BEGIN
            BREAK

        END

        IF @Sorteo = 'N'
        BEGIN
            UPDATE dbo.MDCP
               SET cpnominal   = cpnominal   + @nnominal,
                   cpvalcomp   = cpvalcomp   + @nvalcomp,
                   cpvalcomu   = cpvalcomu   + @nvalcomu,
                   cpvptirc    = cpvptirc    + @nvptirc,
                   cpcapitalc  = cpcapitalc  + @ncapitalv,
                   cpinteresc  = cpinteresc  + @ninteresv,
                   cpreajustc  = cpreajustc  + @nreajustv,
                   cpvalvenc   = cpvalvenc   + @nvalvenc,
                   cpvaltasemi = cpvaltasemi + @ntasaemi,
                   cpprimadesc = cpprimadesc + @nprimadesc
             WHERE cpnumdocu   = @nnumdocu 
               AND cpcorrela   = @ncorrela

            IF @@ERROR <> 0
            BEGIN
                SET @mensaje = 'No se Pudo Anular Operacion'
                RETURN 1
            END

        END

        UPDATE dbo.MDDI
           SET dinominal  = dinominal  + @nnominal,
               divptirc   = divptirc   + @nvptirc,
               dicapitalc = dicapitalc + @ncapitalv,
               diinteresc = diinteresc + @ninteresv,
               direajustc = direajustc + @nreajustv
         WHERE dinumdocu  = @nnumdocu 
           AND dicorrela  = @ncorrela

        IF @@ERROR <> 0
        BEGIN
            SET @mensaje = 'No se Pudo Anular Operacion'
            RETURN 1

        END

        UPDATE dbo.MDCO 
           SET cocantcortd  = cocantcortd + cvcantcort
          FROM dbo.MDCV
         WHERE conumdocu    = @nnumdocu 
           AND cocorrela    = @ncorrela 
           AND cvnumdocu    = @nnumdocu 
           AND cvcorrela    = @ncorrela 
           AND cvnumoper    = @noperacion 
           AND comtocort    = cvmtocort

        IF @@ERROR <> 0
        BEGIN
            SET @mensaje = 'No se Pudo Anular Operacion'
            RETURN 1

        END

       -- vb+- 04/07/2000
       -- elimino cortes de tabla de cortes vendidos      
       -- ===================================================
        DELETE dbo.MDCV 
         WHERE cvnumdocu = @nnumdocu
           AND cvcorrela = @ncorrela 
           AND cvnumoper = @noperacion 

        IF @@ERROR <> 0
        BEGIN
            SET @mensaje = 'No se Pudo Anular Operacion'
            RETURN 1
        END

    /*========================================================================================================*/  
    /* Elimino la operación de la tabla de pago mañana si la operacion es anulada en el dia (MDMOPM			  */  
	/* +++ VBF  por contingencia 05102018*/
    /*========================================================================================================*/  
	 IF EXISTS (SELECT 1 FROM MDMOPM, MDAC WHERE monumoper  = @noperacion AND monumdocuo = @nnumdocu AND mocorrelao = @ncorrela AND mofecpro=acfecproc )     
	 BEGIN 
		DELETE FROM dbo.mdmopm WHERE monumoper  = @noperacion AND monumdocuo = @nnumdocu AND mocorrelao = @ncorrela 
		IF @@ERROR <> 0  
		BEGIN  
			SET @mensaje = 'No se Pudo Anular Operacion'  
			RETURN 1  
		END  
	END  
	/* --- VBF  por contingencia 05102018*/

		-->		Rebaja Proporcional el Valor de Mercado	
		update	BacTraderSuda.dbo.Valorizacion_Mercado
		set		valor_market		= valor_market  + @ValMerProporcional	--> Valor Mercado
		,		valor_market1		= valor_market1 + @nnominal				--> Valor Nominal
		where	fecha_valorizacion	= (select acfecante from BacTraderSuda.dbo.Mdac with(nolock) )
		and		rmnumdocu			= @nnumdocu
		and		rmcorrela			= @ncorrela
		-->		Rebaja Proporcional el Valor de Mercado

        IF @@ERROR <> 0
        BEGIN
            SET @mensaje = 'No se Pudo Anular Operacion, Fallo Restauración de Valor Mercado para Calculo de Utilidad'
            RETURN 1
        END

        --  ===================================================
        IF @Tabla = 1
        BEGIN
            UPDATE dbo.MDMO
               SET mostatreg  = 'A'
             WHERE monumoper  = @noperacion
               AND monumdocuo = @nnumdocu
               AND mocorrelao = @ncorrela

            IF @@ERROR <> 0
            BEGIN
                SET @mensaje = 'No se Pudo Anular Operacion'
                RETURN 1

            END

            UPDATE dbo.MDMOPM
               SET mostatreg  = 'A' ,
		           --> VB 10/07/2018  mocondpacto= CASE WHEN mofecpro = @fecant THEN 'X' ELSE 'H' END
				   mocondpacto= CASE WHEN mofecpro <= @fecant THEN 'X' ELSE 'H' END
             WHERE monumoper  = @noperacion
               AND monumdocuo = @nnumdocu
               AND mocorrelao = @ncorrela

            IF @@ERROR <> 0
            BEGIN
                SET @mensaje = 'No se Pudo Anular Operacion'
                RETURN 1

            END

        END ELSE
        BEGIN
            UPDATE dbo.MDMOPM
               SET mostatreg  = 'A' ,
		           --> VB 10/07/2018  mocondpacto= CASE WHEN mofecpro = @fecant THEN 'X' ELSE 'H' END
				   mocondpacto= CASE WHEN mofecpro <= @fecant THEN 'X' ELSE 'H' END
             WHERE monumoper  = @noperacion
               AND monumdocuo = @nnumdocu
               AND mocorrelao = @ncorrela

            IF @@ERROR <> 0
            BEGIN
                SET @mensaje = 'No se Pudo Anular Operacion'
                RETURN 1

            END

        END

        EXECUTE SP_LINEAS_AUMENTA 'BTR', @noperacion, @nnumdocu, @ncorrela, @nvalcomp

        IF @@ERROR <> 0
        BEGIN
            SET @mensaje = 'No se Pudo Anular Operacion'
            RETURN 1

        END

    END

    SET @mensaje = 'Operacion Fue Anulada Correctamente'

END
GO
