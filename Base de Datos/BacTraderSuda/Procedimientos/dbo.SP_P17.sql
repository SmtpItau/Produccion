USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_P17]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_P17]
       (
        @DFECPRO DATETIME
       )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @NCONTADOR   INTEGER
   DECLARE @X           INTEGER
   DECLARE @CINSTSER    CHAR(12)
   DECLARE @CNOMPRO     CHAR(40)
   DECLARE @CRUTPRO     CHAR(15)
   DECLARE @NRUT        NUMERIC(09,0)
   DECLARE @NRUTESTADO  NUMERIC(09,0)
   DECLARE @NRUTTGR     NUMERIC(09,0)
   DECLARE @NRUTEMIS    NUMERIC(09,0)
   DECLARE @NTASEMIS    NUMERIC(09,4)
   DECLARE @NMONEMIS    NUMERIC(03,0)
   DECLARE @CTIPOEMI    CHAR(01)
   DECLARE @LLAVE       CHAR(22)
   DECLARE @CINST       CHAR(06)
   DECLARE @PRODUCTO    NUMERIC(04,0)
   DECLARE @COM_INV     NUMERIC(05,0)
   DECLARE @NRUTCART    NUMERIC(09,0)
   DECLARE @NNUMDOCU    NUMERIC(07,0)
   DECLARE @NNUMOPER    NUMERIC(07,0)
   DECLARE @NCORRELA    NUMERIC(03,0)
   DECLARE @CSERIADO    CHAR(01)
   DECLARE @CMASCARA    CHAR(12)
   DECLARE @CCART_SBIF  CHAR(01)
   DECLARE @NCODIGO     NUMERIC(03,0)
   DECLARE @NNOMINAL    NUMERIC(19,4)
   DECLARE @NVALCOMU    NUMERIC(19,4)
   DECLARE @NVALPAR     NUMERIC(19,8)
   DECLARE @NNOMI       NUMERIC(19,4)
   DECLARE @NVPRESEN    NUMERIC(19,0)
   DECLARE @NVALMER     NUMERIC(19,0)
   DECLARE @NPARNOM     NUMERIC(19,0)

   SELECT      @NRUT    = ACRUTPROP,
               @CNOMPRO = ACNOMPROP,
               @CRUTPRO = LTRIM( RTRIM( CONVERT( VARCHAR(10), ACRUTPROP ) ) ) + '-' + ACDIGPROP
          FROM MDAC

   SELECT @NRUTESTADO = 97030000
   SELECT @NRUTTGR    = 60805000

   SELECT      'LLAVE'   = CONVERT(      CHAR(22), '' ),
               'VPRESEN' = CONVERT( NUMERIC(17,0),  0 ),
               'VALPRES' = CONVERT( NUMERIC(17,0),  0 ),
               'PARNOM'  = CONVERT( NUMERIC(17,0),  0 ),
               'INST'    = CONVERT(      CHAR(20), '' )
          INTO #TEMPO

   DELETE #TEMPO

   --*********************************************--
   --**  C A R T E R A   I N V E R S I O N E S  **--
   --*********************************************--
   SELECT       @NCONTADOR = COUNT(*) 
          FROM  MDCP, MDRS
          WHERE CPNOMINAL  > 0           AND
                CPRUTCART  > 0           AND
               (RSFECHA    = @DFECPRO    AND 
                RSCARTERA  = '111'       AND
                RSTIPOPER  = 'DEV'       AND
                RSNUMDOCU  = CPNUMDOCU   AND
                RSCORRELA  = CPCORRELA)  AND
                CPCODIGO  <> 98

   SELECT @X  = 1

   WHILE @X <= @NCONTADOR BEGIN

      SELECT @CINSTSER = '*'

      SET ROWCOUNT @X
      SELECT       @CINSTSER    = CPINSTSER,
                   @NRUTCART    = CPRUTCART,
                   @NNUMDOCU    = CPNUMDOCU,
                   @NCORRELA    = CPCORRELA,
                   @CSERIADO    = CPSERIADO,
                   @CMASCARA    = CPMASCARA,
                   @NCODIGO     = CPCODIGO,
                   @NNOMINAL    = CPNOMINAL,
                   @NVALPAR     = RSVPCOMP,
                   @NVPRESEN    = RSVPPRESENX,
                   @CCART_SBIF  = A.CODIGO_CARTERASUPER,
                   @NRUTEMIS    = 0,
                   @NTASEMIS    = 0.0,
                   @NVALMER     = 0,
                   @NPARNOM     = 0,
                   @CTIPOEMI    = ''
             FROM  MDCP A, MDRS B
             WHERE CPNOMINAL    > 0          AND
                   CPRUTCART    > 0          AND
                  (RSFECHA      = @DFECPRO   AND
                   RSCARTERA    = '111'      AND
                   RSTIPOPER    = 'DEV'      AND
                   RSNUMDOCU    = CPNUMDOCU  AND
                   RSCORRELA    = CPCORRELA) AND
                   CPCODIGO    <> 98
      SET ROWCOUNT 0

      SELECT @X = @X + 1

      IF @CSERIADO = 'S' BEGIN
         SELECT       @NRUTEMIS = SERUTEMI,
                      @NTASEMIS = SETASEMI,
                      @NMONEMIS = SEMONEMI
                FROM  VIEW_SERIE
                WHERE @CMASCARA=SEMASCARA

      END ELSE BEGIN
         SELECT       @NRUTEMIS = NSRUTEMI,
                      @NMONEMIS = NSMONEMI
                FROM  VIEW_NOSERIE
                WHERE NSRUTCART = @NRUTCART AND
                      NSNUMDOCU = @NNUMDOCU AND
                      NSCORRELA = @NCORRELA

      END

      SELECT @CTIPOEMI = EMTIPO FROM VIEW_EMISOR WHERE EMRUT=@NRUTEMIS

      IF @NCODIGO=15 BEGIN
         SELECT @PRODUCTO = CASE WHEN @NRUTEMIS=@NRUT         THEN 1735
                                 WHEN @CTIPOEMI='1'           THEN 1735
                                                              ELSE 1725
                            END,
                @COM_INV  = CASE WHEN @NRUTEMIS = @NRUT        THEN 22102
                                 WHEN @NRUTEMIS = @NRUTESTADO  THEN 21402
                                 WHEN @CTIPOEMI = '2'          THEN 22104
                                                               ELSE 22999
                            END

      END ELSE IF @NCODIGO=20 BEGIN
         SELECT @PRODUCTO = CASE WHEN @NRUTEMIS = @NRUT        THEN 1735
                                                               ELSE 1725
                            END ,
                @COM_INV  = CASE WHEN @NRUTEMIS = @NRUT        THEN 22101
                                 WHEN @NRUTEMIS = @NRUTESTADO  THEN 21401
                                                               ELSE 22103
                            END

      END ELSE BEGIN
         SELECT @PRODUCTO = CASE WHEN @NCODIGO =   4           THEN 1705  --PRC
                                 WHEN @NCODIGO =  31           THEN 1705  --PRD
                                 WHEN @NCODIGO =  33           THEN 1705  --BCU
                                 WHEN @NCODIGO =  34           THEN 1705  --BCP
                                 WHEN @NCODIGO =  35           THEN 1705  --BCD
                                 WHEN @NCODIGO =   7           THEN 1705  --PRBC
                                 WHEN @NCODIGO =   6           THEN 1705  --PDBC
                                 WHEN @NCODIGO =   5           THEN 1705  --PTF
                                 WHEN @NCODIGO =   2           THEN 1705  --PCDUF
                                 WHEN @NCODIGO =   1           THEN 1705  --PCDUS$
                                 WHEN @NCODIGO =  21           THEN 1705  --PPBC
                                 WHEN @NCODIGO =   3           THEN 1705  --PDP
                                 WHEN @NCODIGO =  11           THEN 1725  --DPR
                                 WHEN @NCODIGO =   9           THEN 1725  --DPF
                                 WHEN @NCODIGO =  12           THEN 1705  --DPD
                                 WHEN @NCODIGO = 888           THEN 1705  --BR
                                 WHEN @NCODIGO =   8           THEN 1705  --PRT
                                 WHEN @NCODIGO =  16           THEN 1705  --CERO UF
                                 WHEN @NCODIGO =  17           THEN 1705  --ZERO DO
                                 WHEN @NCODIGO = 300           THEN 1705  --CERO UF
                                 WHEN @NCODIGO = 301           THEN 1705  --CERO DO
                                                               ELSE 0
                            END ,
                @COM_INV  = CASE WHEN @NCODIGO =   4           THEN 21110  --PRC
                                 WHEN @NCODIGO =  31           THEN 21122  --PRD
                                 WHEN @NCODIGO =  33           THEN 21126  --BCU
                                 WHEN @NCODIGO =  34           THEN 21125  --BCP
                                 WHEN @NCODIGO =  35           THEN 21127  --BCD
                                 WHEN @NCODIGO =   7           THEN 21102  --PRBC
                                 WHEN @NCODIGO =   6           THEN 21101  --PDBC
                                 WHEN @NCODIGO =   5           THEN 21108  --PTF
                                 WHEN @NCODIGO =   2           THEN 21121  --PCDUF
                                 WHEN @NCODIGO =   1           THEN 21120  --PCDUS$
                                 WHEN @NCODIGO =  21           THEN 21104  --PPBC
                                 WHEN @NCODIGO =   3           THEN 21107  --PDP
			         WHEN @NCODIGO =  11           THEN 22111  --DPR
                                 WHEN @NCODIGO =   9           THEN 22111  --DPF
                                 WHEN @NCODIGO =  12           THEN 22111  --DPD
                                 WHEN @NCODIGO = 888           THEN 11109  --BR
                                 WHEN @NCODIGO =   8           THEN 11102  --PRT
                                 WHEN @NCODIGO =  16           THEN 21123  --CERO UF
                                 WHEN @NCODIGO =  17           THEN 21124  --ZERO DO
                                 WHEN @NCODIGO = 300           THEN 21123  --CERO UF
                                 WHEN @NCODIGO = 301           THEN 21124  --CERO DO
                                                               ELSE 0
                            END
      END

      SELECT       @NVALMER = VALOR_MERCADO 
             FROM  VALORIZACION_MERCADO 
             WHERE (FECHA_VALORIZACION = @DFECPRO       AND
                    ID_SISTEMA         = 'BTR'          AND
                    TIPO_OPERACION     = 'CP'           AND
                    @NNUMDOCU          = RMNUMDOCU      AND
                    @NNUMDOCU          = RMNUMOPER      AND
                    @NCORRELA          = RMCORRELA)

      IF @NVALMER = 0 BEGIN
         SELECT @NVALMER = @NVPRESEN

      END

      IF @NTASEMIS > 0 BEGIN
         SELECT @NNOMI = @NNOMINAL

         IF @NMONEMIS <> 999 BEGIN
            SELECT       @NPARNOM = ( ROUND(@NVALPAR,4) / 100.0 ) * @NNOMI * VMVALOR 
                   FROM  VIEW_VALOR_MONEDA 
                   WHERE VMCODIGO = @NMONEMIS          AND
                         VMFECHA  = @DFECPRO

         END ELSE BEGIN
            SELECT @NPARNOM = ( ROUND(@NVALPAR,4) / 100.0 ) * @NNOMI

         END

      END ELSE IF @NTASEMIS = 0 AND (SELECT INREFNOMI FROM VIEW_INSTRUMENTO WHERE INCODIGO = @NCODIGO) = 'V' BEGIN
         SELECT @NNOMI = @NNOMINAL

         IF @NMONEMIS <> 999 BEGIN
            SELECT @NPARNOM = @NNOMI * VMVALOR FROM VIEW_VALOR_MONEDA WHERE VMCODIGO = @NMONEMIS AND VMFECHA = @DFECPRO

         END ELSE BEGIN
            SELECT @NPARNOM = @NNOMI

         END

      END ELSE BEGIN
         SELECT @NPARNOM = @NVPRESEN

      END

      SELECT @LLAVE = '2P17' + SUBSTRING( CONVERT( CHAR(8), @DFECPRO, 112 ), 3, 6 ) +
                      CONVERT( CHAR(04), @PRODUCTO ) + CONVERT( CHAR(03), @NMONEMIS ) + CONVERT( CHAR(5), @COM_INV )

      SELECT @CINST = INSERIE FROM VIEW_INSTRUMENTO WHERE INCODIGO = @NCODIGO

      INSERT INTO #TEMPO
             VALUES (
                        @LLAVE,
                        @NVPRESEN,
                        @NVALMER,
                        @NPARNOM,
                        @CINST
                    )

   END

   --***********************************************--
   --**  C A R T E R A   I N T E R M E D I A D A  **--
   --***********************************************--
   SELECT       @NCONTADOR = COUNT(*) 
          FROM  MDVI, MDCP, MDRS 
          WHERE VITIPOPER  = 'CP'          AND
                CPNUMDOCU  = VINUMDOCU     AND
                CPCORRELA  = VICORRELA     AND
                VIRUTCLI  <> 97029000      AND
               (RSFECHA    = @DFECPRO      AND
                RSCARTERA  = '114'         AND
                RSTIPOPER  = 'DEV'         AND
                RSNUMDOCU  = VINUMDOCU     AND
                RSNUMOPER  = VINUMOPER     AND
                VICORRELA  = CPCORRELA)

   SELECT @X  = 1

   WHILE @X <= @NCONTADOR BEGIN

      SELECT @CINSTSER = '*'
      SET ROWCOUNT @X
      SELECT       @CINSTSER  = VIINSTSER,
                   @NRUTCART  = VIRUTCART,
                   @NNUMDOCU  = VINUMDOCU,
                   @NNUMOPER  = VINUMOPER,
                   @NCORRELA  = VICORRELA,
                   @CSERIADO  = VISERIADO,
                   @CMASCARA  = VIMASCARA,
		   @NCODIGO   = VICODIGO,
                   @NNOMINAL  = VINOMINAL,
                   @NVALPAR   = RSVPCOMP,
                   @NVPRESEN  = RSVPPRESENX,
                   @NRUTEMIS  = 0,
                   @NTASEMIS  = 0.0,
                   @NVALMER   = 0,
                   @NPARNOM   = 0,
                   @CTIPOEMI  = ''
             FROM  MDVI, MDCP, MDRS
             WHERE VITIPOPER  = 'CP'        AND
                   CPNUMDOCU  = VINUMDOCU   AND
                   CPCORRELA  = VICORRELA   AND
                   VIRUTCLI  <> 97029000    AND
                  (RSFECHA    = @DFECPRO    AND
                   RSCARTERA  = '114'       AND
                   RSTIPOPER  = 'DEV'       AND 
                   RSNUMDOCU  = VINUMDOCU   AND 
                   RSNUMOPER  = VINUMOPER   AND 
                   VICORRELA  = CPCORRELA)
      SET ROWCOUNT 0

      IF @CINSTSER = '*' BEGIN
         BREAK

      END

      SELECT @X = @X + 1

      IF @CSERIADO = 'S' BEGIN
         SELECT       @NRUTEMIS = SERUTEMI,
                      @NTASEMIS = SETASEMI,
                      @NMONEMIS = SEMONEMI
                FROM  VIEW_SERIE
                WHERE @CMASCARA = SEMASCARA

      END ELSE BEGIN
         SELECT       @NRUTEMIS = NSRUTEMI,
                      @NMONEMIS = NSMONEMI
                FROM  VIEW_NOSERIE
                WHERE NSRUTCART = @NRUTCART    AND
                      NSNUMDOCU = @NNUMDOCU    AND
                      NSCORRELA = @NCORRELA

      END

      SELECT @CTIPOEMI = EMTIPO FROM VIEW_EMISOR WHERE EMRUT = @NRUTEMIS

      IF @NCODIGO = 15 BEGIN
         SELECT @COM_INV = CASE WHEN @NRUTEMIS = @NRUT       THEN 22102
                                WHEN @NRUTEMIS = @NRUTESTADO THEN 21402
                                WHEN @CTIPOEMI = '2'         THEN 22104
                                                             ELSE 22999
                           END

      END ELSE IF @NCODIGO = 20 BEGIN
         SELECT @COM_INV = CASE WHEN @NRUTEMIS=@NRUT         THEN 22101
                                WHEN @NRUTEMIS=@NRUTESTADO   THEN 21401
                                                             ELSE 22103
                           END

      END ELSE BEGIN
         SELECT @COM_INV = CASE WHEN @NCODIGO =   4          THEN 21110  --PRC
                                WHEN @NCODIGO =  31          THEN 21122  --PRD
                                WHEN @NCODIGO =  33          THEN 21126  --BCU
                                WHEN @NCODIGO =  34          THEN 21125  --BCP
                                WHEN @NCODIGO =  35          THEN 21127  --BCD
                                WHEN @NCODIGO =   7          THEN 21102  --PRBC
                                WHEN @NCODIGO =   6          THEN 21101  --PDBC
                                WHEN @NCODIGO =   5          THEN 21108  --PTF
                                WHEN @NCODIGO =   2          THEN 21121  --PCDUF
                                WHEN @NCODIGO =   1          THEN 21120  --PCDUS$
                                WHEN @NCODIGO =  21          THEN 21104  --PPBC
                                WHEN @NCODIGO =   3          THEN 21107  --PDP
                                WHEN @NCODIGO =  11          THEN 22111  --DPR
                                WHEN @NCODIGO =   9          THEN 22111  --DPF
                                WHEN @NCODIGO =  12          THEN 22111  --DPD
                                WHEN @NCODIGO = 888          THEN 11109  --BR
                                WHEN @NCODIGO =   8          THEN 11102  --PRT
                                WHEN @NCODIGO =  16          THEN 21123  --CERO UF
                                WHEN @NCODIGO =  17          THEN 21124  --CERO DO
                                WHEN @NCODIGO = 300          THEN 21123  --CERO UF
                                WHEN @NCODIGO = 301          THEN 21124  --CERO DO
                                                             ELSE 0
                           END
      END

      SELECT @PRODUCTO = 1740

      SELECT       @NVALMER = VALOR_MERCADO 
             FROM  VALORIZACION_MERCADO 
             WHERE (FECHA_VALORIZACION = @DFECPRO    AND
                    ID_SISTEMA         = 'BTR'       AND
                    TIPO_OPERACION     = 'VI'        AND
                    @NNUMDOCU          = RMNUMDOCU   AND
                    @NNUMDOCU          = RMNUMOPER   AND
                    @NCORRELA          = RMCORRELA)

      IF @NVALMER = 0 BEGIN
         SELECT @NVALMER = @NVPRESEN

      END

      IF @NTASEMIS > 0 BEGIN
         SELECT @NNOMI = @NNOMINAL

         IF @NMONEMIS <> 999 BEGIN
            SELECT       @NPARNOM = ( ROUND(@NVALPAR,4) / 100.0 ) * @NNOMI * VMVALOR 
                   FROM  VIEW_VALOR_MONEDA 
                   WHERE VMCODIGO=@NMONEMIS AND VMFECHA=@DFECPRO

         END ELSE BEGIN
            SELECT @NPARNOM = ( ROUND(@NVALPAR,4) / 100.0 ) * @NNOMI

         END

      END ELSE IF @NTASEMIS=0 AND (SELECT INREFNOMI FROM VIEW_INSTRUMENTO 
                                          WHERE INCODIGO=@NCODIGO ) = 'V' BEGIN
         SELECT @NNOMI = @NNOMINAL

         IF @NMONEMIS <> 999 BEGIN
            SELECT       @NPARNOM = @NNOMI * VMVALOR 
                   FROM  VIEW_VALOR_MONEDA
                   WHERE VMCODIGO=@NMONEMIS AND VMFECHA=@DFECPRO

         END ELSE BEGIN
            SELECT @NPARNOM = @NNOMI

         END

      END ELSE BEGIN
         SELECT @NPARNOM = @NVPRESEN

      END

      SELECT @LLAVE = '2P17' + SUBSTRING( CONVERT( CHAR(08), @DFECPRO, 112 ), 3, 6 ) +
                      CONVERT( CHAR(04), @PRODUCTO ) + CONVERT( CHAR(03), @NMONEMIS ) +
                      CONVERT( CHAR(05), @COM_INV )

      SELECT @CINST = INSERIE FROM VIEW_INSTRUMENTO WHERE INCODIGO=@NCODIGO

      INSERT INTO #TEMPO
             VALUES (
                     @LLAVE,
                     @NVPRESEN,
                     @NVALMER,
                     @NPARNOM,
                     @CINST
                    )

   END

   --*********************************--
   --**  C A R T E R A   R E P O S  **--
   --*********************************--
   SELECT       @NCONTADOR = COUNT(*) 
          FROM  MDVI, MDCP, MDRS 
          WHERE VITIPOPER  = 'CP'          AND
                CPNUMDOCU  = VINUMDOCU     AND
                CPCORRELA  = VICORRELA     AND
                VIRUTCLI   = 97029000      AND
               (RSFECHA    = @DFECPRO      AND
                RSCARTERA  = '114'         AND
                RSTIPOPER  = 'DEV'         AND
                RSNUMDOCU  = VINUMDOCU     AND
                RSNUMOPER  = VINUMOPER     AND
                VICORRELA  = CPCORRELA)

   SELECT @X  = 1

   WHILE @X <= @NCONTADOR BEGIN

      SELECT @CINSTSER = '*'
      SET ROWCOUNT @X
      SELECT       @CINSTSER = VIINSTSER,
                   @NRUTCART = VIRUTCART,
                   @NNUMDOCU = VINUMDOCU,
                   @NNUMOPER = VINUMOPER,
                   @NCORRELA = VICORRELA,
                   @CSERIADO = VISERIADO,
                   @CMASCARA = VIMASCARA,
                   @NCODIGO  = VICODIGO,
                   @NNOMINAL = VINOMINAL,
                   @NVALPAR  = RSVPCOMP,
                   @NVPRESEN = RSVPPRESENX,
                   @NRUTEMIS = 0,
                   @NTASEMIS = 0.0,
                   @CTIPOEMI = ''
             FROM  MDVI, MDCP, MDRS
             WHERE VITIPOPER = 'CP'          AND
                   CPNUMDOCU = VINUMDOCU     AND
                   CPCORRELA = VICORRELA     AND
                   VIRUTCLI  = 97029000      AND
                  (RSFECHA   = @DFECPRO      AND
                   RSCARTERA = '114'         AND
                   RSTIPOPER = 'DEV'         AND
                   RSNUMDOCU = VINUMDOCU     AND
                   RSNUMOPER = VINUMOPER     AND
                   VICORRELA = CPCORRELA)
      SET ROWCOUNT 0

      IF @CINSTSER = '*' BEGIN
         BREAK

      END

    IF @CSERIADO = 'S' BEGIN
         SELECT       @NRUTEMIS = SERUTEMI,
                      @NTASEMIS = SETASEMI,
                      @NMONEMIS = SEMONEMI
                FROM  VIEW_SERIE
                WHERE @CMASCARA = SEMASCARA

      END ELSE BEGIN
         SELECT       @NRUTEMIS = NSRUTEMI ,
                      @NMONEMIS = NSMONEMI
                FROM  VIEW_NOSERIE
                WHERE NSRUTCART = @NRUTCART       AND
                      NSNUMDOCU = @NNUMDOCU       AND
                      NSCORRELA = @NCORRELA

      END

      SELECT @CTIPOEMI = EMTIPO FROM VIEW_EMISOR WHERE EMRUT=@NRUTEMIS

      IF @NCODIGO = 15 BEGIN
         SELECT @PRODUCTO = CASE WHEN @NRUTEMIS = @NRUT       THEN 1735
                                 WHEN @CTIPOEMI = '1'         THEN 1735
                                                              ELSE 1725
                            END,
                @COM_INV  = CASE WHEN @NRUTEMIS = @NRUT       THEN 22102
                                 WHEN @NRUTEMIS = @NRUTESTADO THEN 21402
                                 WHEN @CTIPOEMI = '2'         THEN 22104
                                                              ELSE 22999
                            END

      END ELSE IF @NCODIGO = 20 BEGIN
         SELECT @PRODUCTO = CASE WHEN @NRUTEMIS = @NRUT       THEN 1735
                                                              ELSE 1725
                            END,
                @COM_INV  = CASE WHEN @NRUTEMIS = @NRUT       THEN 22101
                                 WHEN @NRUTEMIS = @NRUTESTADO THEN 21401
                                                              ELSE 22103
                            END
      END ELSE
         SELECT @PRODUCTO = CASE WHEN @NCODIGO =   4          THEN 1705  --PRC
                                 WHEN @NCODIGO =  31          THEN 1705  --PRD
                                 WHEN @NCODIGO =  33          THEN 1705  --BCU
                                 WHEN @NCODIGO =  34          THEN 1705  --BCP
                                 WHEN @NCODIGO =  35          THEN 1705  --BCD
                                 WHEN @NCODIGO =   7          THEN 1705  --PRBC
                                 WHEN @NCODIGO =   6          THEN 1705  --PDBC
                                 WHEN @NCODIGO =   5          THEN 1705  --PTF
                                 WHEN @NCODIGO =   2          THEN 1705  --PCDUF
                                 WHEN @NCODIGO =   1          THEN 1705  --PCDUS$
                                 WHEN @NCODIGO =  21          THEN 1705  --PPBC
                                 WHEN @NCODIGO =   3          THEN 1705  --PDP
                                 WHEN @NCODIGO =  11          THEN 1725  --DPR
                                 WHEN @NCODIGO =   9          THEN 1725  --DPF
                                 WHEN @NCODIGO =  12          THEN 1705  --DPD
                                 WHEN @NCODIGO = 888          THEN 1705  --BR
                                 WHEN @NCODIGO =   8          THEN 1705  --PRT
                                 WHEN @NCODIGO =  16          THEN 1705  --CERO UF
                                 WHEN @NCODIGO =  17          THEN 1705  --CERO DO
                                 WHEN @NCODIGO = 300          THEN 1705  --CERO UF
                                 WHEN @NCODIGO = 301          THEN 1705  --CERO DO
                                                              ELSE 0
                            END,
                @COM_INV  = CASE WHEN @NCODIGO =   4          THEN 21110  --PRC
                                 WHEN @NCODIGO =  31          THEN 21122  --PRD
                                 WHEN @NCODIGO =  33          THEN 21126  --BCU
                                 WHEN @NCODIGO =  34          THEN 21125  --BCP
                                 WHEN @NCODIGO =  35          THEN 21127  --BCD
                                 WHEN @NCODIGO =   7          THEN 21102  --PRBC
                                 WHEN @NCODIGO =   6          THEN 21101  --PDBC
                                 WHEN @NCODIGO =   5          THEN 21108  --PTF
                                 WHEN @NCODIGO =   2          THEN 21121  --PCDUF
                                 WHEN @NCODIGO =   1          THEN 21120  --PCDUS$
                                 WHEN @NCODIGO =  21          THEN 21104  --PPBC
                                 WHEN @NCODIGO =   3          THEN 21107  --PDP
                                 WHEN @NCODIGO =  11          THEN 22111  --DPR
                                 WHEN @NCODIGO =   9          THEN 22111  --DPF
                                 WHEN @NCODIGO =  12          THEN 22111  --DPD
                                 WHEN @NCODIGO = 888          THEN 11109  --BR
                                 WHEN @NCODIGO =   8          THEN 11102  --PRT
                                 WHEN @NCODIGO =  16          THEN 21123  --CERO UF
                                 WHEN @NCODIGO =  17          THEN 21124  --CERO DO
                                 WHEN @NCODIGO = 300          THEN 21123  --CERO UF
                                 WHEN @NCODIGO = 301          THEN 21124  --CERO DO
                                                              ELSE 0
                            END

      SELECT @NVALMER = 0
      SELECT @NPARNOM = 0

      SELECT       @NVALMER            = VALOR_MERCADO 
             FROM  VALORIZACION_MERCADO
             WHERE (FECHA_VALORIZACION = @DFECPRO       AND
                    ID_SISTEMA         = 'BTR'          AND
                    TIPO_OPERACION     = 'VI'           AND
                    @NNUMDOCU          = RMNUMDOCU      AND 
                    @NNUMDOCU          = RMNUMOPER      AND 
                    @NCORRELA          = RMCORRELA)

      IF @NVALMER = 0 BEGIN
         SELECT @NVALMER = @NVPRESEN

      END

      IF @NTASEMIS > 0 BEGIN
         SELECT @NNOMI = @NNOMINAL

         IF @NMONEMIS <> 999 BEGIN
            SELECT       @NPARNOM = ( ROUND(@NVALPAR,4) / 100.0 ) * @NNOMI * VMVALOR 
                   FROM  VIEW_VALOR_MONEDA
                   WHERE VMCODIGO = @NMONEMIS AND
                         VMFECHA  = @DFECPRO
         END ELSE BEGIN
            SELECT @NPARNOM = ( ROUND(@NVALPAR,4) / 100.0 ) * @NNOMI

         END

      END ELSE IF @NTASEMIS = 0 AND (SELECT INREFNOMI FROM VIEW_INSTRUMENTO 
                                            WHERE INCODIGO = @NCODIGO) = 'V' BEGIN
         SELECT @NNOMI = @NNOMINAL

         IF @NMONEMIS <> 999 BEGIN
            SELECT       @NPARNOM = @NNOMI * VMVALOR 
                   FROM  VIEW_VALOR_MONEDA
                   WHERE VMCODIGO = @NMONEMIS    AND
                         VMFECHA  = @DFECPRO

         END ELSE BEGIN
            SELECT @NPARNOM = @NNOMI

         END

      END ELSE BEGIN
         SELECT @NPARNOM = @NVPRESEN

      END

      SELECT @LLAVE = '2P17' + SUBSTRING( CONVERT( CHAR(08), @DFECPRO, 112 ), 3, 6 ) +
                      CONVERT( CHAR(04), @PRODUCTO ) + CONVERT( CHAR(03), @NMONEMIS ) +
                      CONVERT( CHAR(05), @COM_INV )

      SELECT @CINST = INSERIE FROM VIEW_INSTRUMENTO WHERE INCODIGO = @NCODIGO

      INSERT INTO #TEMPO
             VALUES ( 
                     @LLAVE,
                     @NVPRESEN,
                     @NVALMER,
                     @NPARNOM,
                     @CINST
                    )

   END

   DELETE MDP17

   INSERT INTO MDP17 (
                      NOMCLI,
                      RUTCLI,
                      FECPRO,
                      FAMILIA,
                      CTABCCH,
                      MONEDA,
                      COMPINST,
                      VPRESENTE,
                      VMERCADO,
                      SALNOMI
                     )
          SELECT      @CNOMPRO,
                      @CRUTPRO,
                      CONVERT( CHAR(10), @DFECPRO, 103 ),
                      INST,
                      CONVERT( INTEGER, SUBSTRING( LLAVE, 11, 4 ) ),
                      CONVERT( INTEGER, SUBSTRING( LLAVE, 15, 3 ) ),
                      CONVERT( INTEGER, SUBSTRING( LLAVE, 18, 5 ) ),
	              SUM( VPRESEN ),
                      SUM( VALPRES ),
                      SUM(  PARNOM )
                 FROM #TEMPO
                 GROUP BY LLAVE,INST

   SELECT      LLAVE,
               SUM( VPRESEN ),
               SUM( VALPRES ),
               SUM(  PARNOM ),
               INST,
               @CNOMPRO,
               @CRUTPRO,
               CONVERT( CHAR(10), @DFECPRO, 103 )
          FROM #TEMPO
          GROUP BY LLAVE,INST

   SET NOCOUNT OFF

   RETURN

END

-- SP_P17 '20010525'
-- SELECT * FROM MDP17
-- SELECT SUBSTRING(CONVERT(CHAR(8),ACFECPROC,112),3,6) FROM MDAC
-- SELECT VIVPTIRV,* FROM MDVI WHERE VITIPOPER = 'CP'
-- SELECT SUM(PTWVPRESEN),SUM(PTWNOMINAL) FROM MDPTW WHERE PTWCODINST=5
-- SELECT SUM(PTWVPRESEN),SUM(PTWNOMINAL) FROM MDPTW WHERE PTWCODINST=6 AND PTWCARTERA='1'
-- SELECT * FROM MDITM WHERE CODSER=20
-- SELECT SUM(NOMINAL),SUM(VPTIRC),SUM(VPMCD),SUM(DIFMCDO) FROM MDITM WHERE CODSER=20
-- SP_P17 '20020903'
-- SELECT * FROM MDP17
-- SELECT * FROM VIEW_INSTRUMENTO


GO
