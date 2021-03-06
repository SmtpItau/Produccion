USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CLIENTE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_CLIENTE]( @Rut     NUMERIC(9) ,   
                                  @Codigo  NUMERIC(9) )
AS
BEGIN
     SET NOCOUNT ON
 
     SELECT clrut                                , -- 1
            cldv                                 , -- 2
            clcodigo                             , -- 3
            clnombre                             , -- 4
            clgeneric                            , -- 5
            cldirecc                             , -- 6
            clcomuna                             , -- 7
            clciudad                             , -- 8
            clregion                             , -- 9
            clpais     , -- 10
            cltipomx                             , -- 11
           'clfecingr' = CONVERT( CHAR(10), clfecingr, 103 )  , -- 12
            clfono                               , -- 13
            clfax                                , -- 14
            cltipcli                             , -- 15
            clctacte                             , -- 16
            clctausd                             , -- 17
            claba                                , -- 18
            clchips                              , -- 19 
            clswift                              , -- 20
     cod_inst                             , -- 21 Codigo BCCH
            clcodban          , -- 22 Codigo SBIF
            codigo_OTC                           , -- 23 Codigo OTC - Bolsa de Comercio
            Bloqueado            , -- 24 
    'Ciudad' = SPACE(30)                   -- 25
      INTO #cliente
   
      FROM  VIEW_CLIENTE    
     WHERE  clrut     = @Rut
       AND (clcodigo  = @Codigo OR @Codigo = 0)
    ----<< Actualiza nombre de ciudad 
    UPDATE #Cliente SET ciudad = nombre  
                   FROM view_ciudad  
                  WHERE codigo_ciudad = clciudad 
                    AND codigo_region = clregion
    ----<< Resultado de consulta
    SELECT * FROM #cliente
END

GO
