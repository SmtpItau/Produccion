USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_CUOTASFM]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_CONSULTA_CUOTASFM]   
   (   @cfecha   DATETIME   )  
AS  
BEGIN  
  
   SET NOCOUNT ON   
  
   DECLARE @iRegistros          NUMERIC(9)  
   DECLARE @iContador           NUMERIC(9)  
  
   DECLARE @carterasuper CHAR(1)  
   DECLARE @morutcart  NUMERIC(9,0)  
   DECLARE @numdocu  NUMERIC(10,0)  
   DECLARE @correla             NUMERIC(3,0)  
   DECLARE @numoper             NUMERIC(10,0)  
   DECLARE @codigo              NUMERIC(5,0)  
   DECLARE @instser             VARCHAR(20)  
   DECLARE @rutemi              VARCHAR(10)  
   DECLARE @monemi              NUMERIC(3,0)  
   DECLARE @nominal             NUMERIC(19,4)  
   DECLARE @valcompori          NUMERIC(19,4)  
   DECLARE @tmp1               NUMERIC(8,4)  
   DECLARE @tmp2                NUMERIC(19,4)  
   DECLARE @tmp3                NUMERIC(19,4)  
   DECLARE @tmp4                NUMERIC(19,4)  
   DECLARE @fecven              DATETIME  
   DECLARE @fecemi              DATETIME  
   DECLARE @mascara             VARCHAR(12)  
   DECLARE @iCodCliente         NUMERIC(9)  
  
  
   DECLARE @fec_proc DATETIME  
       SET @fec_proc    = ( SELECT acfecproc FROM MDAC )  
  
   DELETE FROM PRECIO_CUOTA  
         WHERE fec_proc = @fec_proc  
  
   SELECT 'fec_proc'  = @fec_proc  
   ,      'numdocu' = cpnumdocu  
   ,      'correla' = cpcorrela  
   ,      'numoper' = cpnumdocuo  
   ,      'codigo ' = cpcodigo  
   ,      'instser' = cpinstser  
   ,      'rutemi ' = nsrutemi  
   ,      'monemi ' = nsmonemi  
   ,      'nominal' = cpnominal  
   ,      'valcompori' = valor_par_compra_original  
   ,      'tmp1'        = 0  
   ,      'tmp2'        = valor_compra_original  
   ,      'tmp3'        = 0  
   ,      'tmp4'        = 0  
   ,      'fecven' = cpfecven  
   ,      'codcli'      = cpcodcli  
   ,      'Puntero'     = identity(Int)  
   INTO   #TMP_PRECIO  
   FROM   MDCP  
          INNER JOIN MDDI         ON cpnumdocu = dinumdocu AND cpcorrela = dicorrela  
          INNER JOIN VIEW_NOSERIE ON cpnumdocu = nsnumdocu AND cpcorrela = nscorrela  
          LEFT  JOIN VIEW_EMISOR  ON nsrutemi  = emrut         --> emgeneric = digenemi  
    WHERE cpcodigo  = 98  
      AND cpnominal > 0  
  
   SELECT @iregistros  = MAX( puntero )  
   ,      @icontador   = MIN( puntero )  
   FROM   #TMP_PRECIO  
  
   WHILE  @iregistros >= @icontador  
   BEGIN  
      SELECT @numdocu     = numdocu  
      ,      @correla     = correla  
      ,      @numoper     = numoper  
      ,      @codigo      = codigo  
      ,      @instser     = instser  
      ,      @rutemi      = rutemi  
      ,      @monemi      = monemi  
      ,      @nominal     = nominal  
      ,      @valcompori  = valcompori  
      ,      @tmp1        = tmp1  
      ,      @tmp2        = tmp2  
      ,      @tmp3        = tmp3  
      ,      @tmp4        = tmp4  
      ,      @fecven      = fecven  
      ,      @iCodCliente = codcli  
      FROM   #TMP_PRECIO  
      WHERE  puntero      = @icontador  
  
      IF NOT EXISTS (SELECT 1 FROM PRECIO_CUOTA WHERE fec_proc = @fec_proc AND num_docu    = @numdocu   
                                                  AND num_corr = @correla  AND instrumento = @instser   
                                                  AND rut_emi  = @rutemi   AND fec_venc    = @fecven )  
      BEGIN  
  
         INSERT INTO PRECIO_CUOTA  
         (      FEC_PROC  
         ,      NUM_DOCU  
         ,      NUM_CORR  
         ,      NUM_OPER  
         ,      NUM_COD  
         ,      INSTRUMENTO  
         ,      RUT_EMI  
         ,      MONEDA_EMI  
         ,      VALOR_NOMINAL  
         ,      PRECIO_COMPRA  
         ,      PRECIO_MERCADO  
         ,      VALOR_PRESENTE  
         ,      VALOR_MERCADO  
         ,      DIFERENCIA_MERCADO  
         ,      FEC_VENC   
         ,      COD_CLI  
         )  
         SELECT @fec_proc  
         ,      @numdocu  
         ,      @correla  
         ,      @numoper  
         ,      @codigo  
         ,      @instser  
         ,      @rutemi  
         ,      @monemi  
         ,      @nominal  
         ,      @valcompori  
         ,      @tmp1  
         ,      @tmp2  
         ,      @tmp3  
         ,      @tmp4  
         ,      @fecven  
         ,      @iCodCliente  
      END  
  
      SET @iContador = @iContador + 1  
  
   END  
  
	/*
   SELECT nsrutemi         as nsrutemi  
        , emdv             as cldv  
        , cpcodcli         as cpcodcli  
        , emnombre         as clnombre  
        , cpinstser        as cpinstser  
        , cpfecven         as cpfecven  
        , SUM( cpnominal ) as cpnominal  
        , SUM( 0 )         as vCuota   
     FROM MDCP  
          INNER JOIN MDDI         ON cpnumdocu = dinumdocu AND cpcorrela = dicorrela  
          INNER JOIN VIEW_NOSERIE ON cpnumdocu = nsnumdocu AND cpcorrela = nscorrela  
          LEFT  JOIN VIEW_EMISOR  ON nsrutemi  = emrut         --> emgeneric = digenemi  
    WHERE cpcodigo  = 98  
      AND cpnominal > 0  
   GROUP BY nsrutemi, emdv, cpcodcli, emnombre, cpinstser, cpfecven  
	*/

   SELECT nsrutemi         as nsrutemi
        , emdv             as cldv
        , cpcodcli         as cpcodcli
        , emnombre         as clnombre
        , cpinstser        as cpinstser
        , cpfecven         as cpfecven
        , sum(cpnominal)   as cpnominal
        , sum(0)		   as vCuota 
		, cpnumdocu		   as Documento
		, cpcorrela		   as Correlativo
		, clnombre		   as Cliente	
     FROM MDCP
          INNER JOIN MDDI         ON cpnumdocu = dinumdocu AND cpcorrela = dicorrela
          INNER JOIN VIEW_NOSERIE ON cpnumdocu = nsnumdocu AND cpcorrela = nscorrela
          LEFT  JOIN VIEW_EMISOR  ON nsrutemi  = emrut         --> emgeneric = digenemi
		  inner join BacParamSuda.dbo.Cliente cli ON cli.clrut = cprutcli and cli.clcodigo = cpcodcli
    WHERE cpcodigo  = 98
      AND cpnominal > 0
   GROUP BY nsrutemi, emdv, cpcodcli, emnombre, cpinstser, cpfecven, cpnumdocu, cpcorrela, clnombre
  
END

GO
