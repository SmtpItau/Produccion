USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDMNLeerCodigo]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MDMNLeerCodigo    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDMNLeerCodigo    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
/*==========================================================================*/
CREATE PROCEDURE [dbo].[Sp_MDMNLeerCodigo]
       (
        @ncodigo     NUMERIC(5,0)    , -- C¢digo moneda
        @dfecpro     DATETIME          -- Fecha de Proceso (Ojo este dato se
                                       -- podria traer de la tabla de
                                       -- par metros (MDAC).
       )
AS
BEGIN
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
                mningval                                  ,
                mnrrda        
          FROM  MONEDA, VALOR_MONEDA
          WHERE mncodmon   = @ncodigo                  AND
                mncodmon  *= vmcodigo                  AND
                vmfecha    = @dfecpro
   /*=======================================================================*/
   RETURN
END






GO
