USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDMNLeerCodigo]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_MDMNLeerCodigo]
       (
        @ncodigo     NUMERIC(5,0)    , -- C¢digo moneda
        @dfecpro     DATETIME          -- Fecha de Proceso (Ojo este dato se
                                       -- podria traer de la tabla de
                                       -- par metros (datos_generales).
       )
AS
BEGIN


   SET DATEFORMAT dmy

   /*=======================================================================*/
   SELECT       mncodmon                                  ,
                mnglosa                                   ,
                mnnemo                                    ,
                mnfactor                                  ,
                mnredondeo                                ,
                mncodbanco                                ,
                mncodsuper                                ,
                mnbase                                    ,
                mnrefusd                                  ,
                mnlocal                                   ,
                mnextranj                                 ,
                'mnvalor'  = ISNULL( vmvalor, 0 )         ,
                mnrefmerc                                 ,
--                mningval                                  ,
                mnrrda 					  
          FROM  MONEDA, VALOR_MONEDA
          WHERE mncodmon   = @ncodigo                  AND
                mncodmon  *= vmcodigo                  AND
                vmfecha    = @dfecpro                  AND
                MONEDA.ESTADO<>'A'

   /*=======================================================================*/
   RETURN

END




GO
