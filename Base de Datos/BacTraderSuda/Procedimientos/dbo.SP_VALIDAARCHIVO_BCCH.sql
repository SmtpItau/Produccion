USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDAARCHIVO_BCCH]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VALIDAARCHIVO_BCCH]

             (  @Folio      Numeric(9)
              , @InstSerie  Char(12)
              , @gsbac_user VARCHAR(15)
              , @Normativa  VARCHAR(255) = ''
              , @Financiera VARCHAR(255) = ''
              , @hWnd       NUMERIC(9)
              , @TipOper    CHAR(3)
             )
AS BEGIN

 SET NOCOUNT ON
 DECLARE @SerieBAC   CHAR(12)
       , @EmisorBAC  NUMERIC(9,0)
       , @Instru     CHAR(12)      
       , @InstruSVS  CHAR(12)   
       , @ERROR      INTEGER
       , @mascara    CHAR (12) 
       , @codigo     INTEGER
       , @serie      CHAR (12)
       , @rutemi     NUMERIC (9,0)
       , @monemi     INTEGER
       , @tasemi     FLOAT
       , @basemi     NUMERIC (3,0) 
       , @fecemi     DATETIME
       , @fecven     DATETIME
       , @refnomi    CHAR (1) 
       , @genemi     CHAR (10) 
       , @nemmon     CHAR (5) 
       , @corte      NUMERIC (19,4)
       , @seriado    CHAR (1)
       , @lecemi     CHAR (6)
       , @fecpro     DATETIME 
       , @Resultado  NUMERIC(1)
       , @descripcion CHAR (50)

    CREATE TABLE 
	   #ChequeaSerie 
                      (
	   		error      	INTEGER		,
	   		Descripcion     CHAR(40)
                      )


    CREATE TABLE 
	   #DatosSerie( 
	   		nerror      	INTEGER		,
			cmascara    	CHAR(12)	,
			codigo		INTEGER		,
			cserie      	CHAR(12)	,
			nrutemi     	NUMERIC(9,0)	,
			nmonemi     	INTEGER		,
			ftasemi     	FLOAT		,
			nbasemi     	NUMERIC(3,0)	,
			dfecemi     	CHAR(10)	,
			dfecven     	CHAR(10)	,
			crefnomi    	CHAR(1)		,
			cgenemi     	CHAR(10)	,
			cnemmon     	CHAR(5) 	,
			ncorte      	NUMERIC(19,4)	,
			cseriado    	CHAR(1)		,
			clecemi     	CHAR(6)		,
			fecpro	    	CHAR(10)	
                      )


 IF @InstSerie = ''  
 BEGIN 
  SELECT 'Resultado' = 2 ,
         'Serie'     = '',  
         'Emisor'    = 0
  RETURN
 END


 INSERT INTO #ChequeaSerie
 EXECUTE dbo.Sp_chkinstser @InstSerie,'SP'    

 SELECT  @descripcion  = Descripcion 
 FROM #ChequeaSerie 




 IF  @descripcion <> 'OK'
 BEGIN 
   SELECT @Instru = Inserie
        , @InstruSVS = InCodSVS
        , @SerieBAC = RTRIM(inserie) + '-' + SUBSTRING(@InstSerie,7,12)
   FROM BacParamSuda..Instrumento   
   WHERE  InCodSVS = SUBSTRING(@InstSerie,1,2)

 
 END 
 ELSE 
 BEGIN 
   SELECT @SerieBAC = @InstSerie       
 END 


 INSERT INTO #DatosSerie
 EXECUTE dbo.Sp_chkinstser @SerieBAC

  
 SELECT @rutemi = nrutemi 
 FROM #DatosSerie

 IF @rutemi = 0 
 BEGIN 
      SELECT @rutemi    = EmRut  
      FROM BacParamSuda..EmisorCodigos
      WHERE EmCod = SUBSTRING(@InstSerie,3,3)

 END 
 

  IF NOT EXISTS (SELECT 1 FROM DETALLE_FLI WHERE  Usuario = @gsbac_user AND (CHARINDEX( LTRIM(RTRIM(CarteraSuper)), @Normativa)  > 0 or @Normativa  = '') AND Serie = @SerieBAC AND Rut_Emisor = @rutemi AND Ventana  = @hWnd   AND TipOper = @TipOper)
  BEGIN     
       SELECT @Resultado = 2
  END
  ELSE
  BEGIN 
    IF EXISTS (SELECT FolioBCCH FROM CARGASOMA WHERE FolioBCCH = @Folio) 
     BEGIN
        SELECT @Resultado = 1
     END
     ELSE
        SELECT @Resultado = 0  
  END  
 

   SELECT  'Resultado' = @Resultado ,
           'Serie'     = @SerieBAC  ,
           'Emisor'    = @rutemi

 SET NOCOUNT OFF
END

GO
