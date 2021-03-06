USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DURATION]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_DURATION] ( @Serie_Valor          CHAR(12),
                                        @Fecha_Proceso  DATETIME,
                                        @Monto_Durat    FLOAT  OUTPUT)



AS
BEGIN

    SET NOCOUNT OFF

/*******************************************************************************
* Esto debe hacerse en el devengo, pedir punto de planilla, es importante por  *
* que el duration de un papel puede ser 8.47 y este proceso arroja el valor    *
* 9.7780819999999995 que es un año más lo que distorciona la evaluación        *
* de la matriz.                                                                *
********************************************************************************/
        SELECT  @Monto_Durat = datediff( dd, @Fecha_Proceso, sefecven ) / 365.0  
	FROM  BacParamSuda..Serie 
	WHERE seserie = @Serie_Valor
        RETURN


/*
    CREATE TABLE #Temporal(
                            ERROR     INTEGER ,
                            mascara   CHAR(12),
                            codigo    INTEGER,
                            serie     CHAR(12),  
                            rutemi     NUMERIC(10),
                            monemi     INTEGER,
                            tasemi     FLOAT,
                            basemi     NUMERIC (3,0), 
                            fecemi      CHAR(10),    
                            fecven      CHAR(10),    
                            refnomi    CHAR(1),
                            genemi     CHAR(6),
                            nemmon     CHAR(5),
                            corte      NUMERIC(19,4),
                            seriado    CHAR(1),
                            lecemi     CHAR(6),
                            fecpro     CHAR(10)) 


DECLARE                     @ERROR     INTEGER ,
                            @mascara   CHAR(12),
                            @codigo    INTEGER,
                            @serie     CHAR(12),  
                            @rutemi     NUMERIC(10),
                            @monemi     INTEGER,
                            @tasemi     FLOAT,
                            @basemi     NUMERIC (3,0), 
                            @fecemi      CHAR(10),    
                            @fecven      CHAR(10),    
                            @refnomi    CHAR(1),
                            @genemi     CHAR(6),
                            @nemmon     CHAR(5),
                            @corte      NUMERIC(19,4),
                            @seriado    CHAR(1),
                            @lecemi     CHAR(6),
                            @fecpro     CHAR(10),
                            @Fecha_Paso    CHAR(10),
                            @fDurat        FLOAT,
                            @Fecha_Paso_Emi   CHAR(10),
                            @Fecha_Paso_Vcto   CHAR(10)



    SET NOCOUNT ON

    SELECT @Fecha_Paso = CONVERT(CHAR(10),@Fecha_Proceso,112) 

   
    INSERT #Temporal
    EXECUTE BACTRADERSUDA..SP_CHKINSTSER @Serie_Valor



    SELECT @ERROR    = Error,  
           @mascara  = mascara,
           @codigo   =  codigo,
           @serie    = serie,  
           @rutemi   =  rutemi,
           @monemi   =  monemi,
           @tasemi   =  tasemi,
           @basemi   = basemi, 
           @fecemi   =  fecemi,    
           @fecven   = fecven  ,    
           @refnomi  =  refnomi,
           @genemi   = genemi,
           @nemmon   = nemmon,
           @corte    = corte,
           @seriado  =  seriado,
           @lecemi   = lecemi   
         , @fecpro   = fecpro
     FROM  #Temporal

    CREATE TABLE #Temporal_2(
                              fError       INTEGER ,
                              fNominal     FLOAT,
                              fTir         FLOAT,
                              fPvp         FLOAT, 
                              fMT          FLOAT,
                              fMTUM        FLOAT,
                              fMT_cien     FLOAT,
                              fVan        FLOAT,
                              fVpar       FLOAT,
                              nNumucup    INTEGER,
                              cFecucup    DATETIME,
                              fIntucup    FLOAT,
                              fAmoucup    FLOAT,
                              fSalucup    FLOAT,
                              nNumpcup    INTEGER,
                              cFecpcup    DATETIME,
                              fIntpcup    FLOAT,
                              fAmopcup    FLOAT,
                   fSalpcup    FLOAT,
                              fDurat      FLOAT,
                              fConvx      FLOAT,
                              fDurmo      FLOAT                  )



    INSERT #Temporal_2
    EXECUTE BACTRADERSUDA..SP_VALORIZAR_CLIENT
                                               2 ,
                                               @Fecha_Paso,
                                               @Codigo ,
                                               @mascara ,
                                               @monemi ,
                                               @fecemi ,
                                               @fecven,
                                               @tasemi  ,
                                               @basemi ,
                                               0  ,
                                               100000  ,
                                               3.3 ,
                                                0.0,
                                                0.0


    SELECT @fDurat = fDurat from #Temporal_2


    SELECT @Monto_Durat = @fDurat
*/

    SET NOCOUNT OFF


END




GO
