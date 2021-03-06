USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINAVI]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ELIMINAVI]
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
    DECLARE @Sorteo             CHAR(01)
    DECLARE @Tabla              CHAR(01)         
    DECLARE @nnominalp          NUMERIC(19,4)
    DECLARE @nvalcompori        NUMERIC(19,4)

    SET @x        = 1
    SET @suma     = 0
    SET @ctipoper = ''

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
             valcompori         NUMERIC(19,4)         NOT NULL,
             nominalp           NUMERIC(19,4)         NOT NULL,
             valvenc            NUMERIC(19,4)         NOT NULL
           )

    INSERT INTO #TEMP
           SELECT vitipoper,
                  vinumdocu,
                  vicorrela,
                  vinumoper,
                  vinominal,
                  ISNULL(vivalcomp,0),
                  ISNULL(vivalcomu,0),
                  ISNULL(vivptirc,0),
                  ISNULL(vicapitalv,0),
                  ISNULL(viinteresv,0),
                  ISNULL(vireajustv,0),
                  ISNULL(vivcompori,0),
                  ISNULL(vinominalp,0),
                  ISNULL(vivalvenc,0) --- nuevo rt
             FROM dbo.MDVI
            WHERE vinumoper = @noperacion

    WHILE @x=1
    BEGIN
        SET @ctipoper = '*'

        SET rowcount 1
        SELECT @ctipoper     = ISNULL( tipoper, '*' ),
               @nnumdocu     = numdocu,
               @ncorrela     = correla,
               @nnumoper     = numoper,
               @nnominal     = nominal,
               @nvalcomp     = valcomp,
               @nvalcomu     = valcomu,
               @nvptirc      = vptirc,
               @ncapitalv    = capitalv,
               @ninteresv    = interesv,
               @nreajustv    = reajustv,
               @nnominalp    = nominalp,
               @nvalcompori  = valcompori,
               @suma         = registro,
               @nvalvenc     = valvenc    --nuevo rt
          FROM #TEMP
         WHERE registro > @suma
        SET rowcount 0 
  
        IF @ctipoper = '*'
        BEGIN
            BREAK

        END

        IF @ctipoper = 'CP'
        BEGIN
            UPDATE dbo.MDCP
               SET cpnominal  = cpnominal  + @nnominal,
                   cpvalcomp  = cpvalcomp  + @nvalcomp,
                   cpvalcomu  = cpvalcomu  + @nvalcomu,
                   cpvptirc   = cpvptirc   + @nvptirc,
                   cpcapitalc = cpcapitalc + @ncapitalv,
                   cpinteresc = cpinteresc + @ninteresv,
                   cpreajustc = cpreajustc + @nreajustv,
                   cpvcompori = cpvcompori + @nvalcompori,
                   cpvalvenc  = cpvalvenc  + @nvalvenc
             WHERE cpnumdocu  = @nnumdocu
               AND cpcorrela  = @ncorrela 

            IF @@ERROR<>0
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

        IF @@ERROR<>0
        BEGIN
            SET @mensaje = 'No se Pudo Anular Operacion'
            RETURN 1

        END

        DELETE dbo.MDVI
         WHERE vinumdocu = @nnumdocu
           AND vicorrela = @ncorrela
           AND vinumoper = @noperacion

        IF @@ERROR<>0
        BEGIN
            SET @mensaje = 'No se Pudo Anular Operacion'
            RETURN 1

        END

        UPDATE dbo.MDCO
           SET cocantcortd = cocantcortd + MDCV.cvcantcort
          FROM dbo.MDCV
         WHERE conumdocu   = @nnumdocu
           AND cocorrela   = @ncorrela
           AND cvnumdocu   = @nnumdocu
           AND cvcorrela   = @ncorrela
           and cvnumoper   = @noperacion
           AND comtocort   = cvmtocort

        IF @@ERROR<>0
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

        IF @@ERROR<>0
        BEGIN
            SET @mensaje = 'No se Pudo Anular Operacion'
            RETURN 1

        END

        --  ===================================================
        UPDATE dbo.MDMO
           SET mostatreg  = 'A'
         WHERE monumoper  = @noperacion
           AND monumdocu /*monumdocuo*/ = @nnumdocu
           AND mocorrela /*mocorrelao*/ = @ncorrela
   
        IF @@ERROR<>0
        BEGIN
            SET @mensaje = 'No se Pudo Anular Operacion'
            RETURN 1

        END

    END

    SET @mensaje = 'Operacion Fue Anulada Correctamente'
    RETURN 0

END


GO
