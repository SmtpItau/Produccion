USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONDICIONESINTERBANCARIO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONDICIONESINTERBANCARIO]
       (
        @nrutcli NUMERIC (9,0),
        @ncodcli NUMERIC (3,0)
       )
AS
BEGIN
   SET NOCOUNT ON
   SELECT 'Fecha'          = Convert(char(10),acfecproc,103),
          'BANCO'          = acnomprop                                               ,
          'RUTBANCO'       = CONVERT ( CHAR ( 9 ), acrutprop ) + '-' + acdigprop,
          'DIRBANCO'       = acdirprop                                               ,
          'TELBANCO'       = actelefono                                              ,
          'FAXBANCO'       = acfax                                                   ,
          'CONTRAPARTE'    = clnombre                                                ,
          'RUTCONTRAPARTE' = CONVERT ( CHAR ( 9 ), clrut ) + '-' + cldv         ,
          'DIRCONTRAPARTE' = cldirecc                                                     ,
          'TELCONTRAPARTE' = clfono                                                  ,
          'FAXCONTRAPARTE' = clfax
   FROM    MFAC,
           VIEW_CLIENTE
   WHERE   clrut    = @nrutcli AND
           clcodigo = @ncodcli
   SET NOCOUNT OFF
END

GO
