USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDMNLEERCODIGO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MDMNLeerCodigo    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDMNLeerCodigo    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
/*==========================================================================*/
CREATE PROCEDURE [dbo].[SP_MDMNLEERCODIGO]
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
          FROM  MONEDA
                LEFT JOIN VALOR_MONEDA ON mncodmon  = vmcodigo
          WHERE mncodmon   = @ncodigo                  AND
                vmfecha    = @dfecpro
   /*=======================================================================*/
   RETURN
END

GO
