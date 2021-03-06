USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OMA2]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OMA2](@FechaConsulta CHAR(8))
AS                            
BEGIN
 SET NOCOUNT ON                                                                         

 CREATE TABLE  #oma2                                                                 
       ( 
        TIPOPE10    	CHAR(01)	,                        
        CODIGO10    	NUMERIC(03)	,                        
        MONTO10     	NUMERIC(20,4)   ,                         
        TIPCAMP10   	NUMERIC(20,4)   ,
        NOMBREEMI10 	CHAR(40)        ,
	COMERCIO10	CHAR(10)	,
        TIPOPE40    	CHAR(01)	,
        CODIGO40    	NUMERIC(03)	,                        
        MONTO40     	NUMERIC(20,4)   ,                         
        TIPCAMP40   	NUMERIC(20,4)	,
        NOMBREEMI40 	CHAR(40)	,
	COMERCIO40	CHAR(10)	,
	FECHA_PROCESO 	CHAR(10)	,
	HORA		CHAR(08)	,
        RUTBCO          NUMERIC(09)	,
        RUTCLI10        NUMERIC(09)	,
        RUTCLI40        NUMERIC(09)	,
        NUMFUT10        NUMERIC(08)	,
        NUMFUT40        NUMERIC(08)	,
        MERCADO10       CHAR(04)	,
        MERCADO40       CHAR(04)	,
	MONCNV10	CHAR(03)	,
	MONCNV40	CHAR(03)	,
	TIPCLI10	NUMERIC(05)	,
	TIPCLI40	NUMERIC(05)	

       )                                                                           


 DECLARE @OP 	         INT 		,
         @CONSE          NUMERIC(05)	,
	 @CONT 	         INT		,
         @MONTO          NUMERIC(20,4)	,                        
         @NUM	         NUMERIC(10)	,
         @OPERA          CHAR(1)	,
         @CODOMA         NUMERIC(5)	,
         @TIPCAMP        NUMERIC(20,4)	,  
         @NOMBREEMI      CHAR(40)	,
	 @mercado        CHAR(04)	,    	
         @tipcli         NUMERIC(05)	,
         @comercio       CHAR(10)	, 
         @rutcli         NUMERIC(09)	,
         @numfut         NUMERIC(08)	,
         @monedacnv	 CHAR(03)

 SELECT @OP=0
 SELECT @NUM=0
 SELECT @MONTO=0 

 SELECT @CONT = COUNT(*)
   FROM memo
       ,tbomadelsuda 
       ,VIEW_CLIENTE  
  WHERE mocodoma  = codi_opera and
        (((CODI_OMA=1 OR CODI_OMA=4 OR CODI_OMA=6 OR CODI_OMA=9) AND motipmer='EMPR') or 
         ((CODI_OMA=1 OR CODI_OMA=3 OR CODI_OMA=6 ) AND motipmer='PTAS'))AND
       (morutcli=clrut and clcodigo = 1 and cltipcli > 2) and
        momonmo  > 499999  AND
        (MOESTATUS='M' or MOESTATUS='')


WHILE @OP < @CONT

	BEGIN

		SET ROWCOUNT @OP
	      ----	

		SELECT 	 @OPERA     = motipope
			,@CODOMA    = codi_oma
			,@MONTO     = momonmo
			,@TIPCAMP   = moticam
			,@NOMBREEMI = monomcli
			,@mercado   = motipmer
			,@TIPCLI    = cltipcli
			,@comercio  = codigo_comercio --isnull( ( select codigo_comercio + ' ' + concepto from view_planilla_spt where planilla_fecha = '20011129' AND operacion_numero = monumope ) , '')
			,@rutcli    = morutcli
			,@numfut    = monumfut
			,@monedacnv = mocodcnv
		FROM 	memo
			,tbomadelsuda
			,VIEW_CLIENTE 
		WHERE 	mocodoma  = codi_opera And
			(((CODI_OMA=1 OR CODI_OMA=4 OR CODI_OMA=6 OR CODI_OMA=9) AND motipmer='EMPR') or 
			 ((CODI_OMA=1 OR CODI_OMA=3 OR CODI_OMA=6 ) AND motipmer='PTAS'))AND
			(morutcli=clrut and clcodigo = 1 and cltipcli > 2) and
			momonmo  > 499999  AND
			(MOESTATUS='M' or MOESTATUS='')
		ORDER BY monumope, motipope


--sp_oma2 '20030724'
		


      IF @CODOMA=1 AND @mercado = 'PTAS' BEGIN
  
       IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE10=' ' and TIPOPE40 = @OPERA)
          BEGIN
                  UPDATE #oma2  
            SET   CODIGO10    = @CODOMA,
                  MONTO10     = @MONTO,
                  TIPCAMP10   = @TIPCAMP,
                  TIPOPE10    = @OPERA,
                  NOMBREEMI10 = @NOMBREEMI,
		  COMERCIO10  = @comercio,
                  RUTCLI10    = @rutcli,
                  NUMFUT10    = @numfut,
                  MERCADO10   = @mercado,
      	          MONCNV10    = @monedacnv,
	          TIPCLI10    = @TIPCLI

            WHERE TIPOPE10=' ' -- MONTO10=0
                  and TIPOPE40 = @OPERA

          END   
  ELSE BEGIN

              INSERT #oma2 (TIPOPE10,
                               CODIGO10,
                               MONTO10,
                               TIPCAMP10,
                               NOMBREEMI10,
	       		       COMERCIO10,
                               TIPOPE40,
                               CODIGO40,
                               MONTO40,
                               TIPCAMP40,
                               NOMBREEMI40,
			       COMERCIO40, 
                               RUTCLI10, 
                               NUMFUT10, 
                               MERCADO10,
              	               MONCNV10,
	                       TIPCLI10)

              VALUES('C',
                     @CODOMA,
                     @MONTO,
                     @TIPCAMP,
                     @NOMBREEMI,
           	     @COMERCIO,
                     ' ',
                     0,
                     0,
                     0,
                     '',
		     '',
                     @rutcli,
                     @numfut,
                     @mercado,
      	             @monedacnv,
	             @TIPCLI)

           END

    END
    -- select * from tbomadelsuda
    IF @CODOMA=1 AND @mercado = 'EMPR' AND @tipcli > 4 BEGIN
  
       IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE40=' ' and TIPOPE10 = @OPERA)
          BEGIN
                  UPDATE #oma2  
            SET   CODIGO40    = @CODOMA,
                  MONTO40     = @MONTO,
                  TIPCAMP40   = @TIPCAMP,
                  TIPOPE40    = @OPERA,
                  NOMBREEMI40 = @NOMBREEMI,
		  COMERCIO40  = @comercio,
                  RUTCLI40    = @rutcli,
                  NUMFUT40    = @numfut,
                  MERCADO40   = @mercado,
      	          MONCNV40    = @monedacnv,
	          TIPCLI40    = @TIPCLI

            WHERE TIPOPE40=' ' -- MONTO10=0
                  and TIPOPE10 = @OPERA

          END       
       ELSE BEGIN

               INSERT #oma2 (TIPOPE40,
                                CODIGO40,
                                MONTO40,
                                TIPCAMP40,
              			NOMBREEMI40,
				COMERCIO40,
                                TIPOPE10,
                                CODIGO10,
                                MONTO10,
                                TIPCAMP10,
                                NOMBREEMI10,
		  		COMERCIO10, 
                                RUTCLI40,
                                NUMFUT40,
                                MERCADO40,
      	                        MONCNV40,
	                        TIPCLI40)

               VALUES('C'	,
                      @CODOMA	,
                      @MONTO	,
                      @TIPCAMP	,
                      @NOMBREEMI,
		      @comercio	,
                      ' '	,
                      0		,
                      0		,
                      0		,
                      ''	,
		      ''        ,
                      @rutcli   ,
                      @numfut   ,
                      @mercado  ,
      	              @monedacnv,
	              @TIPCLI)

            END
    END
    ELSE BEGIN
       IF @CODOMA=1 AND @mercado = 'EMPR' AND @tipcli < 5 BEGIN
       
       IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE10=' ' and TIPOPE40 = @OPERA)
          BEGIN
                  UPDATE #oma2  
            SET   CODIGO10    = @CODOMA,
                  MONTO10     = @MONTO,
                  TIPCAMP10   = @TIPCAMP,
                  TIPOPE10    = @OPERA,
                  NOMBREEMI10 = @NOMBREEMI,
  		  COMERCIO10  = @comercio,
                  RUTCLI10    = @rutcli,
                  NUMFUT10    = @numfut,
                  MERCADO10   = @mercado,
      	          MONCNV10    = @monedacnv,
	          TIPCLI10    = @TIPCLI

            WHERE TIPOPE10=' ' -- MONTO10=0
                  and TIPOPE40 = @OPERA
          END       
       ELSE BEGIN

              INSERT #oma2 (TIPOPE10,
                            CODIGO10,
                           MONTO10,
                            TIPCAMP10,
                            NOMBREEMI10,
			    COMERCIO10,
                            TIPOPE40,
                            CODIGO40,
                            MONTO40,
                            TIPCAMP40,
                            NOMBREEMI40,
			    COMERCIO40, 
                            RUTCLI10,
                            NUMFUT10,
                            MERCADO10,
      	                    MONCNV10,
	                    TIPCLI10)

              VALUES('C',
                     @CODOMA,
                     @MONTO,
                     @TIPCAMP,
                     @NOMBREEMI,
		     @comercio,
                     ' ',
                     0,
                     0,
                     0,
                     '',
		     '',
                     @rutcli,
                     @numfut,
                     @mercado,
      	             @monedacnv,
	             @TIPCLI)

            END
       END
   
       END

    ------
    IF @CODOMA=3 BEGIN
  
       IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE10=' ' and TIPOPE40 = @OPERA) --MONTO10=0)
          BEGIN
                  UPDATE #oma2  
            SET   CODIGO10    = @CODOMA,
                  MONTO10     = @MONTO,
                  TIPCAMP10   = @TIPCAMP,
                  TIPOPE10    = @OPERA,
                  NOMBREEMI10 = @NOMBREEMI,
		  COMERCIO10  = @comercio,
                  RUTCLI10    = @rutcli,
                  NUMFUT10    = @numfut,
                  MERCADO10   = @mercado,
      	          MONCNV10    = @monedacnv,
	          TIPCLI10    = @TIPCLI

            WHERE TIPOPE10=' ' -- MONTO10=0
                  and TIPOPE40 = @OPERA
          END       
       ELSE BEGIN

              INSERT #oma2 (TIPOPE10,
                            CODIGO10,
                            MONTO10,
                            TIPCAMP10,
                            NOMBREEMI10,
		  	    COMERCIO10,
                            TIPOPE40,
                            CODIGO40,
                            MONTO40,
                            TIPCAMP40,
                            NOMBREEMI40,
		  	    COMERCIO40, 
                            RUTCLI10,
                            NUMFUT10,
                            MERCADO10,
      	                    MONCNV10,
	                    TIPCLI10)

              VALUES('C',
                     @CODOMA,
                     @MONTO,
                     @TIPCAMP,
                     @NOMBREEMI,
		     @comercio,
                     ' ',
                     0,
                     0,
                     0,
                     '',
		     '',
                     @rutcli,
                     @numfut,
                     @mercado,
      	             @monedacnv,
	             @TIPCLI)

           END
       END
    ------

    IF @CODOMA=4 BEGIN
  
        IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE40=' 'and TIPOPE10 = @OPERA)
           BEGIN
          
             UPDATE #oma2  
             SET    CODIGO40    = @CODOMA,
                    MONTO40     = @MONTO,
                    TIPCAMP40   = @TIPCAMP,
                    TIPOPE40    = @OPERA,
                    NOMBREEMI40 = @NOMBREEMI,
		    COMERCIO40  = @comercio,
                    RUTCLI40    = @rutcli,
                    NUMFUT40    = @numfut,
                    MERCADO40   = @mercado,
      	            MONCNV40    = @monedacnv,
	            TIPCLI40    = @TIPCLI

             WHERE  TIPOPE40=' ' --MONTO40=0
                  and TIPOPE10 = @OPERA             
           END
        ELSE BEGIN

          INSERT #oma2 (TIPOPE40,
                        CODIGO40,
                        MONTO40,
                        TIPCAMP40,
              		NOMBREEMI40,
		  	COMERCIO40,
                        TIPOPE10,
                        CODIGO10,
                        MONTO10,
                        TIPCAMP10,
                        NOMBREEMI10,
		  	COMERCIO10, 
                        RUTCLI40,
                        NUMFUT40,
                        MERCADO40,
      	                MONCNV40,
	                TIPCLI40)

               VALUES('C',
                      @CODOMA,
                      @MONTO,
                      @TIPCAMP,
                      @NOMBREEMI,
		      @comercio,
                      ' ',
                      0,
                      0,
                      0,
                      '',
		      '',
                      @rutcli,
                      @numfut,
                      @mercado,
      	              @monedacnv,
	              @TIPCLI)

             END
    END
    ------

    IF @CODOMA=6 AND @mercado = 'PTAS' BEGIN

         IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE10=' ' and TIPOPE40 = @OPERA) --MONTO10=0)
            BEGIN
      
              UPDATE #oma2  
              SET    CODIGO10    = @CODOMA,
                     MONTO10     = @MONTO,
                     TIPCAMP10   = @TIPCAMP,
                     TIPOPE10    = @OPERA,
                     NOMBREEMI10 = @NOMBREEMI,
		     COMERCIO10  = @comercio,
                     RUTCLI10    = @rutcli,
                     NUMFUT10    = @numfut,
                     MERCADO10   = @mercado,
      	             MONCNV10    = @monedacnv,
	             TIPCLI10    = @TIPCLI

              WHERE  TIPOPE10=' ' --MONTO10=0
                  and TIPOPE40 = @OPERA
                  END
         ELSE BEGIN

                INSERT #oma2 (TIPOPE10,
                              CODIGO10,
                              MONTO10,
                              TIPCAMP10,
                              NOMBREEMI10,
		  	      COMERCIO10,
                              TIPOPE40,
                              CODIGO40,
                              MONTO40,
                              TIPCAMP40,
			      NOMBREEMI40,
			      COMERCIO40,
                              RUTCLI10,    
                              NUMFUT10,    
                              MERCADO10,
      	                      MONCNV10,
	                      TIPCLI10)

                VALUES('V',
                       @CODOMA,
                       @MONTO,
                       @TIPCAMP,
                       @NOMBREEMI,
		       @comercio,
                       ' ',
                       0,
                       0,
                       0,
                       '',
		       '',
                       @rutcli,
                       @numfut,
                       @mercado,
      	               @monedacnv,
	               @TIPCLI)

              END
    END
    -------

    IF @CODOMA=6 AND @mercado = 'EMPR' AND @tipcli > 4 BEGIN

         IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE40=' ' and TIPOPE10 = @OPERA) --MONTO10=0)
            BEGIN
      
              UPDATE #oma2  
              SET    CODIGO40    = @CODOMA,
                     MONTO40     = @MONTO,
                     TIPCAMP40   = @TIPCAMP,
                     TIPOPE40    = @OPERA,
                     NOMBREEMI40 = @NOMBREEMI,
		     COMERCIO40  = @comercio,
                     RUTCLI40    = @rutcli,
                     NUMFUT40    = @numfut,
                     MERCADO40   = @mercado,
      	             MONCNV40    = @monedacnv,
	             TIPCLI40    = @TIPCLI

              WHERE  TIPOPE40=' ' --MONTO10=0
                  and TIPOPE10 = @OPERA
                  END
         ELSE BEGIN

                 INSERT #oma2 (TIPOPE40,
                               CODIGO40,
                               MONTO40,
                               TIPCAMP40,
                               NOMBREEMI40,
		  	       COMERCIO40,
                               TIPOPE10,
                               CODIGO10,
                               MONTO10,
                               TIPCAMP10,
                               NOMBREEMI10,
		   	       COMERCIO10,
                               RUTCLI40, 
                               NUMFUT40, 
          MERCADO40,
      	                       MONCNV40,
	                       TIPCLI40)

                 VALUES('V',
                        @CODOMA,
                        @MONTO,
                        @TIPCAMP,
                        @NOMBREEMI,
			@comercio,
                        ' ',
                        0,
                        0,
                        0,
                        '',
			'',
                        @rutcli,
                        @numfut,
                        @mercado,
      	                @monedacnv,
	                @TIPCLI)

              END
    END
    ELSE BEGIN
    IF @CODOMA=6 AND @mercado = 'EMPR' AND @tipcli < 5 BEGIN
         IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE10=' ' and TIPOPE40 = @OPERA) --MONTO10=0)
            BEGIN
      
              UPDATE #oma2  
              SET    CODIGO10    = @CODOMA,
                     MONTO10     = @MONTO,
                     TIPCAMP10   = @TIPCAMP,
                     TIPOPE10    = @OPERA,
                     NOMBREEMI10 = @NOMBREEMI,
                     COMERCIO10  = @comercio,
                     RUTCLI10    = @rutcli,
                     NUMFUT10    = @numfut,
                     MERCADO10   = @mercado,
      	             MONCNV10    = @monedacnv,
	             TIPCLI10    = @TIPCLI

              WHERE  TIPOPE10=' ' --MONTO10=0
                  and TIPOPE40 = @OPERA
                  END
         ELSE BEGIN

                INSERT #oma2 (TIPOPE10,
                              CODIGO10,
                              MONTO10,
                              TIPCAMP10,
                              NOMBREEMI10,
			      COMERCIO10,
                              TIPOPE40,
                              CODIGO40,
                              MONTO40,
                              TIPCAMP40,
			      NOMBREEMI40,
			      COMERCIO40,
                              RUTCLI10,
                              NUMFUT10,
                              MERCADO10,
      	                      MONCNV10,
	                      TIPCLI10)


                VALUES('V',
                       @CODOMA,
                       @MONTO,
                       @TIPCAMP,
                       @NOMBREEMI,
		       @comercio,
                       ' ',
                       0,
                       0,
                       0,
                       '',
		       '',
                       @rutcli,
                       @numfut,
                       @mercado,
      	               @monedacnv,
	               @TIPCLI)

              END
    END
    END

    IF @CODOMA=9 BEGIN

          IF  EXISTS(SELECT * FROM #oma2 WHERE  TIPOPE40=' ' and TIPOPE10 = @OPERA)  --MONTO40=0)
             BEGIN
      


             UPDATE #oma2  
               SET    CODIGO40    = @CODOMA,
                      MONTO40     = @MONTO,
                      TIPCAMP40   = @TIPCAMP,
                      TIPOPE40    = @OPERA,
                      NOMBREEMI40 = @NOMBREEMI,
		      COMERCIO40  = @comercio,
                      RUTCLI40    = @rutcli,
                      NUMFUT40    = @numfut,
                      MERCADO40   = @mercado,
      	              MONCNV40    = @monedacnv,
	              TIPCLI40    = @TIPCLI

               WHERE  TIPOPE40=' '  
                  and TIPOPE10 = @OPERA
      
             END
          ELSE BEGIN



                 INSERT #oma2 (TIPOPE40,
                               CODIGO40,
                               MONTO40,
                               TIPCAMP40,
                               NOMBREEMI40,
			       COMERCIO40,
                               TIPOPE10,
                               CODIGO10,
                               MONTO10,
                               TIPCAMP10,
                               NOMBREEMI10,
			       COMERCIO10,
                               RUTCLI40,
                               NUMFUT40,
                               MERCADO40,
      	                       MONCNV40,
	                       TIPCLI40)

                 VALUES('V',
                        @CODOMA,
                        @MONTO,
                        @TIPCAMP,
                        @NOMBREEMI,
			@comercio,
                        ' ',
                        0,
                        0,
                        0,
                        '',
			'',
                        @rutcli,
                        @numfut,
                        @mercado,
      	                @monedacnv,
	                @TIPCLI)

               END
      END

    -----
    SELECT @OP = @OP + 1
    SET ROWCOUNT 0

 END

  UPDATE #oma2
  SET	 FECHA_PROCESO 	= CONVERT( CHAR(10) , acfecpro , 103 ),
	 HORA		= CONVERT( CHAR(08) , GETDATE(), 108 ),
         RUTBCO         = acrut
  FROM 	 meac

  SELECT * FROM #oma2 --order by comercio40
  set nocount off

END

GO
