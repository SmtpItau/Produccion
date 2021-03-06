USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_P17]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_P17] -- SP_P17  '20070424'
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
   DECLARE @NNUMDOCU    NUMERIC(15,0)
   DECLARE @NNUMOPER    NUMERIC(15,0)
   DECLARE @NCORRELA    NUMERIC(03,0)
   DECLARE @CSERIADO    CHAR(01)
   DECLARE @CMASCARA    CHAR(20)
   DECLARE @CCART_SBIF  CHAR(01)
   DECLARE @NCODIGO     NUMERIC(04,0)
   DECLARE @NNOMINAL    NUMERIC(19,4)
   DECLARE @NVALCOMU    NUMERIC(19,4)
   DECLARE @NVALPAR     NUMERIC(19,8)
   DECLARE @NNOMI       NUMERIC(19,4)
   DECLARE @NVPRESEN    NUMERIC(19,4)
   DECLARE @NVALMER     NUMERIC(19,4)
   DECLARE @NPARNOM     NUMERIC(19,4)
   DECLARE @FECHAVENC   DATETIME
   DECLARE @MONEM       CHAR(03)

   SELECT      @NRUT    = ACRUTPROP,
               @CNOMPRO = ACNOMPROP,
               @CRUTPRO = LTRIM( RTRIM( CONVERT( VARCHAR(10), ACRUTPROP ) ) ) + '-' + ACDIGPROP
          FROM text_arc_ctl_dri

   SELECT @NRUTESTADO = 97030000
   SELECT @NRUTTGR    = 60805000

   SELECT      'LLAVE'   = CONVERT(      CHAR(22), '' ),
               'VPRESEN' = CONVERT( NUMERIC(19,4),  0 ),
               'VALPRES' = CONVERT( NUMERIC(19,4),  0 ),
               'PARNOM'  = CONVERT( NUMERIC(19,4),  0 ),
               'INST'    = CONVERT(      CHAR(20), '' )
          INTO #TEMPO

   DELETE #TEMPO

   --*********************************************--
   --**  C A R T E R A   I N V E R S I O N E S  **--
   --*********************************************--


   SELECT       @NCONTADOR = COUNT(*) 
          FROM  text_ctr_inv, text_rsu
          WHERE CPNOMINAL  > 0           AND
                CPRUTCART  > 0           AND
               (rsfecpro    = @DFECPRO    AND 
                RSTIPOPER  = 'DEV'       AND
                RSNUMDOCU  = CPNUMDOCU )  



   SELECT @X  = 1

   WHILE @X <= @NCONTADOR BEGIN

      SELECT @CINSTSER = '*'

      SET ROWCOUNT @X
      SELECT       @CINSTSER    = a.id_instrum,
                   @NRUTCART    = CPRUTCART,
                   @NNUMDOCU    = CPNUMDOCU,
                   @CMASCARA    = a.id_instrum, --CPMASCARA,
                   @NCODIGO     = a.cod_familia, --CPCODIGO,
                   @NNOMINAL    = CPNOMINAL,
                   @NVALPAR     = RSVPCOMP,
                   @NVPRESEN    = RSVPPRESENX,
                   @CCART_SBIF  = A.CODIGO_CARTERASUPER,
                   @NRUTEMIS    = 0,
                   @NTASEMIS    = 0.0,
                   @NVALMER     = 0,
                   @NPARNOM     = 0,
                   @CTIPOEMI    = '',
		   @FECHAVENC	= CPFECVEN
		
             FROM  text_ctr_inv A, text_rsu B
             WHERE CPNOMINAL    > 0          AND
                   CPRUTCART    > 0          AND
                  (rsfecpro      = @DFECPRO   AND
                   RSTIPOPER    = 'DEV'      AND
                   RSNUMDOCU    = CPNUMDOCU ) --AND

      SET ROWCOUNT 0

      SELECT @X = @X + 1

  --    IF @CSERIADO = 'S' BEGIN
  	 select @NMONEMIS = 142 -- MAP PARCHE, corregir urgente
         SELECT       @NRUTEMIS = rut_emis,
                      @NTASEMIS = tasa_emis,
                      @NMONEMIS = monemi
                FROM  text_ser
		      
               WHERE @CMASCARA = cod_nemo
		AND   @FECHAVENC= fecha_vcto


      SELECT @CTIPOEMI = EMTIPO FROM VIEW_EMISOR WHERE EMRUT=@NRUTEMIS


         SELECT @PRODUCTO = CASE 	WHEN @CTIPOEMI='1'           THEN 430
				 	WHEN @CTIPOEMI='3'           THEN 430
				 	WHEN @CTIPOEMI='4'           THEN 430
                                	 	                     ELSE 111
                            END,
                @COM_INV  = CASE 	WHEN @CTIPOEMI = '1'          THEN 30099
					WHEN @CTIPOEMI = '3'          THEN 30001
					WHEN @CTIPOEMI = '4'          THEN 30001
                                	                              ELSE 11111
                            END

      SELECT  @NVALMER = rsvalmerc , @NMONEMIS = rsmonemi         -- MAP20070424 Sacando dato de un lugar más seguro
        FROM  text_rsu --VALORIZACION_MERCADO  
       WHERE (rsfecpro = @DFECPRO   AND
              @NNUMDOCU = rsnumdocu AND 
              @NNUMDOCU = rsnumoper )


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

      END ELSE IF @NTASEMIS = 0  BEGIN -- si es efectiva o vencimiento -- AND (SELECT INREFNOMI FROM VIEW_INSTRUMENTO WHERE INCODIGO = @NCODIGO) = 'V' BEGIN
         SELECT @NNOMI = @NNOMINAL

         IF @NMONEMIS <> 999 BEGIN
            SELECT @NPARNOM = @NNOMI * VMVALOR FROM VIEW_VALOR_MONEDA WHERE VMCODIGO = @NMONEMIS AND VMFECHA = @DFECPRO

         END ELSE BEGIN
            SELECT @NPARNOM = @NNOMI

         END

      END ELSE BEGIN
         SELECT @NPARNOM = @NVPRESEN

      END

      IF @NMONEMIS < 10 BEGIN
		SELECT @MONEM = '00' + CONVERT( CHAR(01), @NMONEMIS )
      END		
      ELSE IF @NMONEMIS < 100 BEGIN
		SELECT @MONEM = '0' + CONVERT( CHAR(02), @NMONEMIS )
      END
      ELSE BEGIN
		SELECT @MONEM = CONVERT( CHAR(03), @NMONEMIS )
      END
		
      SELECT @LLAVE = '2P17' + SUBSTRING( CONVERT( CHAR(8), @DFECPRO, 112 ), 3, 6 ) +
                      CONVERT( CHAR(03), @PRODUCTO ) + @MONEM + CONVERT( CHAR(5), @COM_INV )

      SELECT @CINST = Nom_Familia FROM text_fml_inm WHERE Cod_familia = @NCODIGO


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

GO
